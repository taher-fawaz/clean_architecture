import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_clean/core/util/snackbar_message.dart';
import 'package:post_clean/core/widgets/loading_widget.dart';
import 'package:post_clean/features/posts/presentation/cubit/create_update_delete_post/create_update_delete_post_cubit.dart';
import 'package:post_clean/features/posts/presentation/widgets/form_widget.dart';

import '../../domain/entities/post_entity.dart';

class PostCreateUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const PostCreateUpdatePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdatePost ? "Edit Post" : "Add Post"));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(10),
          child: BlocConsumer<CreateUpdateDeletePostCubit,
              CreateUpdateDeletePostState>(
            listener: (context, state) {
              if (state is CreateUpdateDeletePostSuccess) {
                Navigator.of(context).pop();
              } else if (state is CreateUpdateDeletePostError) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is CreateUpdateDeletePostLoading) {
                return LoadingWidget();
              }

              return FormWidget(
                  isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
            },
          )),
    );
  }
}
