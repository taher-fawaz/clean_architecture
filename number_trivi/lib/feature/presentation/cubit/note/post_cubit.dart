import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivi/core/error/failure.dart';
import 'package:number_trivi/core/usecase/usecase.dart';
import 'package:number_trivi/feature/domain/entities/post_entity.dart';
import 'package:number_trivi/feature/domain/use_cases/get_posts_usecase.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final GetPostsUseCase getPostsUseCase;
  PostCubit({required this.getPostsUseCase}) : super(PostInitial());
  PostState postState = PostInitial();
  Future<void> getPosts() async {
    postState = PostLoading();
    emit(postState);
    try {
      getPostsUseCase.call(NoParams()).then((value) async {
        value.fold((failure) {
          postState = PostFailure(failure: failure);
          emit(postState);
        }, (posts) async {
          postState = PostLoaded(posts: posts);
          emit(postState);
        });
      });
    } on SocketException catch (_) {
      postState = PostFailure(failure: ServerFailure());
      emit(postState);
    } catch (_) {
      postState = PostFailure(failure: ServerFailure());
      emit(postState);
    }
  }
}
