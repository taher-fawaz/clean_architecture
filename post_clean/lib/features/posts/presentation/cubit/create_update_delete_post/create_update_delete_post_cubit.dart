import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:post_clean/core/constants.dart';
import 'package:post_clean/core/error/failure.dart';
import 'package:post_clean/features/posts/domain/entities/post_entity.dart';
import 'package:post_clean/features/posts/domain/use_case/create_post.dart';
import 'package:post_clean/features/posts/domain/use_case/delete_post.dart';
import 'package:post_clean/features/posts/domain/use_case/update_post.dart';

part 'create_update_delete_post_state.dart';

class CreateUpdateDeletePostCubit extends Cubit<CreateUpdateDeletePostState> {
  final CreatePostUseCase createPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;
  CreateUpdateDeletePostCubit({
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  }) : super(CreateUpdateDeletePostInitial());

  Future<void> addPost(Post post) async {
    emit(CreateUpdateDeletePostLoading());
    final failureOrCreatePost = await createPostUseCase.call(post);

    emit(_eitherDoneOrErrorState(
        failureOrCreatePost, AppConstants.addSuccessMessage));
  }

  Future<void> updatePost(Post post) async {
    emit(CreateUpdateDeletePostLoading());
    final failureOrUpdatePost = await updatePostUseCase.call(post);

    emit(_eitherDoneOrErrorState(
        failureOrUpdatePost, AppConstants.updateSuccessMessage));
  }

  Future<void> deletePost(int postId) async {
    emit(CreateUpdateDeletePostLoading());
    final failureOrDeletePost = await deletePostUseCase.call(postId);

    emit(_eitherDoneOrErrorState(
        failureOrDeletePost, AppConstants.deleteSuccessMessage));
  }

  CreateUpdateDeletePostState _eitherDoneOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) =>
          CreateUpdateDeletePostError(message: _mapFailureToMessage(failure)),
      (_) => CreateUpdateDeletePostSuccess(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppConstants.serverFailureMessage;
      case EmptyCacheFailure:
        return AppConstants.emptyCashedFailureMessage;
      case OfflineFailure:
        return AppConstants.offlineFailureMessage;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
