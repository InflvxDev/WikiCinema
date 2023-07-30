import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';




final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final moviesNowPlaying = ref.watch(nowPlayingMoviesProvider);

  if (moviesNowPlaying.isEmpty) return [];

  return moviesNowPlaying.sublist(0,8);
});