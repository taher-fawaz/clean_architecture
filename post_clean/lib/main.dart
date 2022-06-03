import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/app_theme.dart';
import 'features/posts/presentation/cubit/create_update_delete_post/create_update_delete_post_cubit.dart';
import 'features/posts/presentation/cubit/posts/posts_cubit.dart';
import 'features/posts/presentation/pages/posts_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsCubit>(
          create: (context) => di.sl<PostsCubit>(),
        ),
        BlocProvider<CreateUpdateDeletePostCubit>(
          create: (context) => di.sl<CreateUpdateDeletePostCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: appTheme,
        home: const PostsScreen(),
      ),
    );
  }
}
