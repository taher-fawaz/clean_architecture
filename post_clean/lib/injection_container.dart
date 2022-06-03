import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:post_clean/core/network/network_info.dart';
import 'package:post_clean/features/posts/data/data_sources/post_local_data_source.dart';
import 'package:post_clean/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:post_clean/features/posts/data/repository/post_repository_impl.dart';
import 'package:post_clean/features/posts/domain/repository/post_repository.dart';
import 'package:post_clean/features/posts/domain/use_case/create_post.dart';
import 'package:post_clean/features/posts/domain/use_case/delete_post.dart';
import 'package:post_clean/features/posts/domain/use_case/get_all_posts.dart';
import 'package:post_clean/features/posts/domain/use_case/update_post.dart';
import 'package:post_clean/features/posts/presentation/cubit/create_update_delete_post/create_update_delete_post_cubit.dart';
import 'package:post_clean/features/posts/presentation/cubit/posts/posts_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => PostsCubit(getAllPosts: sl()));
  sl.registerFactory(() => CreateUpdateDeletePostCubit(
        createPostUseCase: sl(),
        updatePostUseCase: sl(),
        deletePostUseCase: sl(),
      ));

// Usecases

  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => CreatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

// Repository

  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      postRemoteDataSource: sl(),
      postLocalDataSource: sl(),
      networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
