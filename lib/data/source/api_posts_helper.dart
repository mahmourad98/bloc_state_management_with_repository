import 'package:dio/dio.dart';

class PostsApiHelper {
  final _options = BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  static Dio _dio;

  PostsApiHelper._(){
    _dio = Dio(_options);
  }

  static Dio getClient(){
    if (_dio != null){
      return _dio;
    }
    PostsApiHelper._();
    return _dio;
  }
}