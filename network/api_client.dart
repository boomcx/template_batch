export 'params.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:template_getx/models.dart';

import 'params.dart';

part 'api_client.g.dart';

/// https://pub.dev/packages/retrofit
@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  /// 退出登录
  @DELETE('/user/logout')
  Future<void> logout(); 

  @POST('/action/openapi/token')
  Future<void> token(@Body() TokenParams params);

  @GET('/getHaoKanVideo')
  Future<PagingIndex<VideoList>> videoList(
      @Query('value') int page, @Query('size') int size);

  // @GET('https://api.thecatapi.com/v1/images/search')
  // Future<List<ArticleModel>> getArticle(
  //   @Query('limit') int limit,
  // );
  // Future<List<ArticleModel>> getArticle(@Queries() Map<String, dynamic> query);
}

/**
 *   @GET('/tasks/{id}')
  Future<Task> getTask(@Path('id') String id);
  
  @GET('/demo')
  Future<String> queries(@Queries() Map<String, dynamic> queries);
  
  @GET('https://httpbin.org/get')
  Future<String> namedExample(
      @Query('apikey') String apiKey,
      @Query('scope') String scope,
      @Query('type') String type,
      @Query('from') int from);
  
  @PATCH('/tasks/{id}')
  Future<Task> updateTaskPart(
      @Path() String id, @Body() Map<String, dynamic> map);
  
  @PUT('/tasks/{id}')
  Future<Task> updateTask(@Path() String id, @Body() Task task);
  
  @DELETE('/tasks/{id}')
  Future<void> deleteTask(@Path() String id);
  
  @POST('/tasks')
  Future<Task> createTask(@Body() Task task);
  
  @POST('http://httpbin.org/post')
  Future<void> createNewTaskFromFile(@Part() File file);
  
  @POST('http://httpbin.org/post')
  @FormUrlEncoded()
  Future<String> postUrlEncodedFormData(@Field() String hello);
 */