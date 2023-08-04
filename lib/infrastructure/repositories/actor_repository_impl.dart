


import 'package:cinemapedia/domain/datasources/actors_datasrc.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actor_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {

  final ActorsDataSource dataSource;

  ActorRepositoryImpl(this.dataSource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return dataSource.getActorsByMovie(movieId);
  }
  
}