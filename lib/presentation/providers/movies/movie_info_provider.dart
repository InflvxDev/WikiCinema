

import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';


final movieInfoProvier = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final getmovie = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovie: getmovie.getMovieById);
});


typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier <Map<String, Movie>> {

  final GetMovieCallback getMovie;

  MovieMapNotifier({required this.getMovie}):super({});

  Future<void> loadMovie (String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }
}