import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/feature/data/data_sources/models/post_model.dart';
import 'package:number_trivia/feature/data/data_sources/remote_data_sources/posts_remote_data_source.dart';
import 'package:number_trivia/feature/domain/entities/post_entity.dart';
import 'package:http/http.dart' as http;

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  @override
  Future<List<PostModel>> getPosts() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      List<PostModel> listOfModel = postModelFromJson(response.body);
      return listOfModel;
    } else {
      throw ServerException();
    }
  }

  // PostsRemoteDataSourceImpl({});

  // @override
  // Stream<List<NoteEntity>> getNotes(String uid) {
  //   final noteCollectionRef =
  //       firestore.collection("users").doc(uid).collection("notes");

  //   return noteCollectionRef.snapshots().map((querySnap) {
  //     return querySnap.docs
  //         .map((docSnap) => NoteModel.fromSnapshot(docSnap))
  //         .toList();
  //   });
  // }

}
