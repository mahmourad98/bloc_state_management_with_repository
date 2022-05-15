import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/blocs/posts/posts_bloc.dart';
import 'package:state_management/blocs/posts/posts_cubit.dart';
import 'package:state_management/views/home/home_page.dart';
import 'constants.dart';
import 'data/repository/get_posts_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  BlocOverrides.runZoned(
    () {
      runApp(AppRoot());
    },
    blocObserver: MyBlocObserver(),
  );
}

class AppRoot extends StatelessWidget{
  final _repo = RepoGetPostsApi(getAllPostsPath);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostsBloc>(
      create: (context) => PostsBloc(_repo)..add(GetPostsEvent()),
      child: BlocProvider<PostsCubit>(
        create: (context) => PostsCubit(_repo),
        child: MyApp(),
      ),
    );
  }

}

class MyApp extends StatelessWidget {

  MyApp({Key key,}) : super(key: key,);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("transition: ${transition.currentState} => ${transition.nextState}");
  }
}
