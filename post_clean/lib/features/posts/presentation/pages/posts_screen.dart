import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_clean/core/widgets/loading_widget.dart';
import 'package:post_clean/features/posts/presentation/cubit/posts/posts_cubit.dart';
import 'package:post_clean/features/posts/presentation/pages/post_create_update_page.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PostsCubit>(context).getPosts();
    return Scaffold(
        appBar: AppBar(title: const Text('Posts')),
        body: BlocBuilder<PostsCubit, PostsState>(
          builder: (context, state) {
            if (state is PostsLoaded) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => PostCreateUpdatePage(
                                  isUpdatePost: false,
                                ))),
                    leading: Text(post.id.toString()),
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  );
                },
              );
            } else if (state is PostsError) {
              return Center(child: Text(state.message));
            }
            return const LoadingWidget();
          },
        ));
  }
}
