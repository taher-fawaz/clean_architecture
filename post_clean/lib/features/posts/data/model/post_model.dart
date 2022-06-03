import 'package:json_annotation/json_annotation.dart';
import 'package:post_clean/features/posts/domain/entities/post_entity.dart';
part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends Post {
  const PostModel({int? id, required String title, required String body})
      : super(id, title, body);

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

@JsonSerializable()
class PostsDTOResponse {
  final List<PostModel> posts;

  const PostsDTOResponse(this.posts);

  factory PostsDTOResponse.fromJson(Map<String, dynamic> json) =>
      _$PostsDTOResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostsDTOResponseToJson(this);
}
