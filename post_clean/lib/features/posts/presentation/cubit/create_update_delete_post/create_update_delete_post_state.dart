part of 'create_update_delete_post_cubit.dart';

abstract class CreateUpdateDeletePostState extends Equatable {
  const CreateUpdateDeletePostState();

  @override
  List<Object> get props => [];
}

class CreateUpdateDeletePostInitial extends CreateUpdateDeletePostState {}

class CreateUpdateDeletePostLoading extends CreateUpdateDeletePostState {}

class CreateUpdateDeletePostError extends CreateUpdateDeletePostState {
  final String message;

  const CreateUpdateDeletePostError({required this.message});

  @override
  List<Object> get props => [message];
}

class CreateUpdateDeletePostSuccess extends CreateUpdateDeletePostState {
  final String message;

  const CreateUpdateDeletePostSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
