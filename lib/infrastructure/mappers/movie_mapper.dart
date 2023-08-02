import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/movieDB/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/movieDB/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBtoEntity(MovieMovieDB movieDB) => Movie(
      adult: movieDB.adult,
      backdropPath: 
        (movieDB.backdropPath != '') 
        ? 'https://image.tmdb.org/t/p/w500${ movieDB.backdropPath }'
        : 'https://ih1.redbubble.net/image.1027712254.9762/pp,840x830-pad,1000x1000,f8f8f8.u2.jpg',
      genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
      id: movieDB.id,
      originalLanguage: movieDB.originalLanguage,
      originalTitle: movieDB.originalTitle,
      overview: movieDB.overview,
      popularity: movieDB.popularity,
      posterPath: (movieDB.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500${ movieDB.posterPath }'
        : 'no-poster',
      releaseDate: movieDB.releaseDate,
      title: movieDB.title,
      video: movieDB.video,
      voteAverage: movieDB.voteAverage,
      voteCount: movieDB.voteCount);

  static Movie movieDetailstoEntity(MovieDetailsResponse movieDetails) => Movie(
    adult: movieDetails.adult,
    backdropPath: (movieDetails.backdropPath != '')
       ? 'https://image.tmdb.org/t/p/w500${movieDetails.backdropPath}'
       : 'https://ih1.redbubble.net/image.1027712254.9762/pp,840x830-pad,1000x1000,f8f8f8.u2.jpg',
    genreIds: movieDetails.genres.map((e) => e.name).toList(),
    id: movieDetails.id,
    originalLanguage: movieDetails.originalLanguage,
    originalTitle: movieDetails.originalTitle,
    overview: movieDetails.overview,
    popularity: movieDetails.popularity,
    posterPath: (movieDetails.posterPath != '')
       ? 'https://image.tmdb.org/t/p/w500${movieDetails.posterPath}'
       : 'no-poster',
    releaseDate: movieDetails.releaseDate,
    title: movieDetails.title,
    video: movieDetails.video,
    voteAverage: movieDetails.voteAverage,
    voteCount: movieDetails.voteCount
  );
}
