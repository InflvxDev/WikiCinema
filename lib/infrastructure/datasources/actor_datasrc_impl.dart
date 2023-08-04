import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movieDB/credits_response.dart';
import 'package:dio/dio.dart';
import '../../config/constants/environment.dart';

import 'package:cinemapedia/domain/datasources/actors_datasrc.dart';
import 'package:cinemapedia/domain/entities/actor.dart';


class ActorMovieDBDataSourceImpl extends ActorsDataSource {

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.movieDBKey,
      'language': 'es-MX'
    }
  ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async{

    final response = await dio.get('/movie/$movieId/credits');
    if(response.statusCode != 200) throw Exception('Movie ID Not Found');

    final credits = CreditsResponse.fromJson(response.data);
    final List<Actor> cast = credits.cast.map((actor) => ActorMapper.castToEntity(actor)).toList();

    return cast;
  }
  
}