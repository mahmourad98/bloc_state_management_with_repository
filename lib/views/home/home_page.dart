import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/blocs/posts/posts_bloc.dart';
import 'package:state_management/blocs/posts/posts_cubit.dart';
import 'package:state_management/data/model/post_model.dart';
import 'package:state_management/data/repository/get_posts_repository.dart';
import '../../constants.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('BLOC Repository App'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: (){
                //context.read<PostsBloc>().add(GetPostsEvent());
                return BlocProvider.of<PostsCubit>(context).refreshPost();
              },
              icon: Icon(Icons.refresh),
            )
          ],
        ),
          body: BlocBuilder<PostsBloc, PostsState>(
              builder: (BuildContext context, PostsState state){
                if (state is PostsLoadingState){
                  return Center(child: CircularProgressIndicator());
                }
                else if(state is PostsLoadedFailureState){
                  return Text('${state.errorMessage}');
                }
                else if(state is PostsInitialState){
                  return Text('${'No Posts Yet.'}');
                }
                else{
                  final myState = state as PostsLoadedState;
                  final List<Post> myPosts = myState.posts;
                  return RefreshIndicator(
                    onRefresh: () {
                      return BlocProvider.of<PostsCubit>(context).refreshPost();
                    },
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: myPosts.length,
                        itemBuilder: (buildContext, index){
                          return Card(
                            child: Text("${myPosts[index]}"),
                          );
                        }
                    ),
                  );
                }
              }
          ),
        // body: BlocBuilder<PostsCubit, PostsState>(
        //   builder: (BuildContext context, PostsState state){
        //     if (state is PostsLoadingState){
        //       return Center(child: CircularProgressIndicator());
        //     }
        //     else if(state is PostsLoadedFailureState){
        //       return Text('${state.errorMessage}');
        //     }
        //     else if(state is PostsInitialState){
        //       return Text('${'No Posts Yet.'}');
        //     }
        //     else{
        //       final myState = state as PostsLoadedState;
        //       final List<Post> myPosts = myState.posts;
        //       return RefreshIndicator(
        //         onRefresh: () {
        //           return BlocProvider.of<PostsCubit>(context).refreshPost();
        //         },
        //         child: ListView.builder(
        //           scrollDirection: Axis.vertical,
        //           itemCount: myPosts.length,
        //           itemBuilder: (buildContext, index){
        //             return Card(
        //               child: Text("${myPosts[index]}"),
        //             );
        //           }
        //         ),
        //       );
        //     }
        //   }
        // ),
      ),
    );
  }
}