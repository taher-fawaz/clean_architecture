import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/authentication/presentation/login_screen.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/feature/data/data_sources/local_data_sources/post_local_data_source.dart';
import 'package:number_trivia/feature/data/data_sources/local_data_sources/post_local_data_source_impl.dart';
import 'package:number_trivia/feature/data/data_sources/remote_data_sources/post_remote_data_source_impl.dart';
import 'package:number_trivia/feature/data/repositories/posts_repository_impl.dart';
import 'package:number_trivia/feature/domain/repositories/post_repository.dart';
import 'package:number_trivia/feature/domain/use_cases/get_posts_usecase.dart';
import 'package:number_trivia/feature/presentation/cubit/note/post_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/presentation/pages/home_page.dart';
import 'injection_container.dart' as di;

import 'on_generate_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final PostsRepositoryImpl _repository;
  late final NetworkInfo _networkInfo;
  late final PostCubit _postCubit;
  @override
  void initState() {
    super.initState();
    _networkInfo = NetworkInfo.getInstance();
    _repository = PostsRepositoryImpl(
        remoteDataSource: PostsRemoteDataSourceImpl(),
        localDataSource: PostsLocalDataSourceImpl(),
        networkInfo: _networkInfo);
    _postCubit =
        PostCubit(getPostsUseCase: GetPostsUseCase(repository: _repository));
  }

//  http.Response response = await authRepository.post(
//       url: 'http://192.168.1.9/elfatek/public/api/login',
//       //super.loginPath,
//       headers: {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//         'Connection': 'keep-alive'
//       },
//       //super.headers,
//       user: user,
//     );
  @override
  void dispose() {
    _networkInfo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(posts.then((value) => value.map((e) => e.id)));
    return MultiBlocProvider(
      providers: [
        // BlocProvider<AuthCubit>(
        //     create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<PostCubit>(
            create: (_) =>
                // _postCubit
                di.sl<PostCubit>()),
        // BlocProvider<NoteCubit>(create: (_) => di.sl<NoteCubit>()),
      ],
      child: MaterialApp(
        title: 'My Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: LoginScreen(),
      ),
    );
    // initialRoute: '/',
    // onGenerateRoute: OnGenerateRoute.route,
    // routes: {
    //   "/": (context) {
    //     // return BlocBuilder<AuthCubit, AuthState>(
    //     //     builder: (context, authState) {
    //     //   if (authState is Authenticated) {
    //         return HomePage(
    //         );
    //     }
    //     if (authState is UnAuthenticated) {
    //       return SignInPage();
    //     }

    //     return CircularProgressIndicator();
    //   });
    // }
    // },
    // ),
    // );
  }
}
