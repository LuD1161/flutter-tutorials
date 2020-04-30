import 'package:provider_architecture/core/enums/viewstate.dart';
import 'package:provider_architecture/core/models/post.dart';
// import 'package:provider_architecture/core/services/api.dart';
import 'package:provider_architecture/core/services/database.dart';
import 'package:provider_architecture/locator.dart';

import 'base_model.dart';

class HomeModel extends BaseModel {
  // Api _api = locator<Api>();
  DatabaseHelper _databaseHelper = locator<DatabaseHelper>();

  List<Post> posts;

  Future getPosts(int userId) async {
    setState(ViewState.Busy);
    // posts = await _api.getPostsForUser(userId);
    posts = await _databaseHelper.getPostsForUser(userId);
    setState(ViewState.Idle);
  }

  Future deletePost(Post post) async{
    setState(ViewState.Busy);
    var result = await _databaseHelper.deletePost(post.id);
    if(result != 0){
      print("note deleted successfully");
      posts.remove(post);
    }
    setState(ViewState.Idle);
  }
}