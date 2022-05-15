import 'package:bloc/bloc.dart';
import 'package:state_management/blocs/posts/posts_bloc.dart';
import 'package:state_management/data/model/post_model.dart';
import 'package:state_management/data/repository/get_posts_repository.dart';

class PostsCubit extends Cubit<PostsState>{
  final RepoGetPosts repoGetPosts;

  PostsCubit(this.repoGetPosts) : super(PostsInitialState());

  Future<void> refreshPost() async{
    emit(PostsLoadingState());
    await Future.delayed(Duration(seconds: 1), (){},);
    try{
      List<Post> posts;
      await repoGetPosts.getPosts()
      .then(
        (value) {
         posts = value;
        }
      );
      posts.shuffle();
      emit(PostsLoadedState(posts));
    }
    catch(exception){
      emit(PostsLoadedFailureState(exception));
    }
  }
}