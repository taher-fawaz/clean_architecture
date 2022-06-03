import 'package:get_it/get_it.dart';
import 'package:number_trivi/core/network/network_info.dart';
import 'package:number_trivi/feature/data/data_sources/local_data_sources/post_local_data_source.dart';
import 'package:number_trivi/feature/data/data_sources/local_data_sources/post_local_data_source_impl.dart';
import 'package:number_trivi/feature/data/data_sources/remote_data_sources/post_remote_data_source_impl.dart';
import 'package:number_trivi/feature/data/data_sources/remote_data_sources/posts_remote_data_source.dart';
import 'package:number_trivi/feature/data/repositories/posts_repository_impl.dart';
import 'package:number_trivi/feature/domain/repositories/post_repository.dart';
import 'package:number_trivi/feature/domain/use_cases/get_posts_usecase.dart';
import 'package:number_trivi/feature/presentation/cubit/note/post_cubit.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //Cubit/Bloc
  // sl.registerFactory<AuthCubit>(() => AuthCubit(
  //     isSignInUseCase: sl.call(),
  //     signOutUseCase: sl.call(),
  //     getCurrentUidUseCase: sl.call()));
  // sl.registerFactory<UserCubit>(() => UserCubit(
  //       getCreateCurrentUserUseCase: sl.call(),
  //       signInUseCase: sl.call(),
  //       signUPUseCase: sl.call(),
  //     ));
  sl.registerFactory<PostCubit>(() => PostCubit(
        // updateNoteUseCase: sl.call(),
        getPostsUseCase: sl.call(),
        // deleteNoteUseCase: sl.call(),
        // addNewNoteUseCase: sl.call(),
      ));

  //useCase

  sl.registerLazySingleton<GetPostsUseCase>(
      () => GetPostsUseCase(repository: sl.call()));

  //repository
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
      remoteDataSource: sl.call(),
      localDataSource: sl.call(),
      networkInfo: sl.call()));

  //data source
  sl.registerLazySingleton<PostsRemoteDataSource>(
      () => PostsRemoteDataSourceImpl());
  sl.registerLazySingleton<PostsLocalDataSource>(
      () => PostsLocalDataSourceImpl());

  // networkInfo
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfo.getInstance());
  //External
  // final auth = FirebaseAuth.instance;
  // final fireStore = FirebaseFirestore.instance;

  // sl.registerLazySingleton(() => auth);
  // sl.registerLazySingleton(() => fireStore);
}
