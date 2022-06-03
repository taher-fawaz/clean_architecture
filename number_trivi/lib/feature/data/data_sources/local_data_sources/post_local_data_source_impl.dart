
import 'package:number_trivi/core/error/exception.dart';
import 'package:number_trivi/feature/data/data_sources/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:number_trivi/feature/data/data_sources/local_data_sources/post_local_data_source.dart';

const cashedPosts = 'CACHED_NUMBER_TRIVIA';

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final Future<SharedPreferences> sharedPreferences =
      SharedPreferences.getInstance();

  @override
  Future<List<PostModel>> getPosts() async {
    final jsonString =
        await sharedPreferences.then((value) => value.getString(cashedPosts));
    if (jsonString != null) {
      return Future.value(postModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cachePosts(List<PostModel> postList) {
    return sharedPreferences.then((value) => value.setString(
          cashedPosts,
          postModelToJson(postList),
        ));
  }
}
