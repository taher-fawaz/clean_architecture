// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['id'] as int?,
      title: json['title'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };

PostsDTOResponse _$PostsDTOResponseFromJson(Map<String, dynamic> json) =>
    PostsDTOResponse(
      (json['posts'] as List<dynamic>)
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostsDTOResponseToJson(PostsDTOResponse instance) =>
    <String, dynamic>{
      'posts': instance.posts,
    };
