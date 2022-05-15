import 'package:state_management/data/model/post_model.dart';
import 'package:state_management/data/model/error_model.dart';
import 'package:state_management/data/source/api_posts_helper.dart';

abstract class RepoGetPosts{
  Future<List<Post>> getPosts();
}

class RepoGetPostsApi extends RepoGetPosts{
  final String _path;

  RepoGetPostsApi(this._path);

  @override
  Future<List<Post>> getPosts() async{
    //Future.delayed(Duration(seconds: 2), (){});
    try {
      var myClient = PostsApiHelper.getClient();
      var response = await myClient.get(_path);
      if ((response.statusCode ~/ 100) == 2) {
        var data = response.data as List;
        List<Post> posts = List.from(data).map((post) => Post.fromJson(post)).toList();
        print("posts: ${posts.length}");
        return posts;
      }
      else{
        throw Error(errorMessage:'Something Went Wrong. Please Try Again',);
      }
    }
    catch(exception) {
      throw Error(errorMessage:'exception: $exception',);
    }
  }
}