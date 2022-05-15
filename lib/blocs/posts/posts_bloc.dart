import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:state_management/data/model/post_model.dart';
import 'package:state_management/data/repository/get_posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final RepoGetPosts repoGetPosts;
  PostsBloc(this.repoGetPosts) : super(PostsInitialState()) {
    on<GetPostsEvent>((event, emit) async{
      if (event is GetPostsEvent) {
        emit(PostsLoadingState());
        await Future.delayed(Duration(seconds: 1), (){},);
        try{
          await repoGetPosts.getPosts().then((value) => emit(PostsLoadedState(value),),);
        }
        catch(exception){
          emit(PostsLoadedFailureState(exception));
        }
      }
    });
  }
}
