import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movieDB/moviedb_response.dart';
import 'package:dio/dio.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasrc.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MovieDBDatasourceImpl extends MoviesDataSource {

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.movieDBKey,
      'language': 'es-MX'
    }
  ));


  List<Movie> _mapMoviesResponse (response){
    final moviedbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = moviedbResponse.results
        .where((movieDB) => movieDB.posterPath != 'no-poster')
        .map((movieDB) => MovieMapper.movieDBtoEntity(movieDB))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async{
    
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page' : page
    });
    
    return _mapMoviesResponse(response);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async{
    final response = await dio.get('/movie/popular', queryParameters: {
      'page' : page
    });
    
    return _mapMoviesResponse(response);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async{
    final response = await dio.get('/movie/top_rated', queryParameters: {
      'page' : page
    });
    
    return _mapMoviesResponse(response);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async{
    final response = await dio.get('/movie/upcoming', queryParameters: {
      'page' : page
    });
    
    return _mapMoviesResponse(response);
  }
  
}