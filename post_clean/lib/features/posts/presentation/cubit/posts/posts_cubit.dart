import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_clean/core/constants.dart';
import 'package:post_clean/core/error/failure.dart';
import 'package:post_clean/features/posts/domain/entities/post_entity.dart';
import 'package:post_clean/features/posts/domain/use_case/get_all_posts.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final GetAllPostsUseCase getAllPosts;
  PostsCubit({required this.getAllPosts}) : super(PostsInitial());

  void getPosts() async {
    emit(PostsLoading());
    final failureOrPosts = await getAllPosts.call();
    failureOrPosts.fold(
      (failure) => emit(PostsError(message: _mapFailureToMessage(failure))),
      (posts) => emit(PostsLoaded(posts: posts)),
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
