part of 'posts_bloc.dart';

abstract class PostsState extends Equatable{}

class PostsInitialState extends PostsState {
  final List<Post> posts = <Post>[];

  PostsInitialState();

  @override
  List<Object> get props => <dynamic>[posts];
}

class PostsLoadingState extends PostsState {
  @override
  List<Object> get props => <dynamic>[];
}

class PostsLoadedState extends PostsState {
  final List<Post> posts;

  PostsLoadedState(this.posts);

  @override
  List<Object> get props => <dynamic>[posts];
}

class PostsLoadedFailureState extends PostsState {
  final String errorMessage;

  PostsLoadedFailureState(this.errorMessage);

  @override
  List<Object> get props => <dynamic>[errorMessage];
}


