
import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';


typedef SearchMoviesCallback = Future<List<Movie>> Function( String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {


  final SearchMoviesCallback searchMovies;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoading = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({required this.searchMovies});

  void clearStreams() {
    debouncedMovies.close();
  }

  void _onQueryChange (String query) {
    isLoading.add(true);
    
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();    
    }


    _debounceTimer = Timer(const Duration(milliseconds: 500), () async{
      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
      isLoading.add(false);
    });
  }

  Widget buildSuggestionsAndResults() {
    _onQueryChange(query);

    return StreamBuilder(
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieItem(
              movie: movies[index],
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoading.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_outlined)),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            duration: const Duration(milliseconds: 200),
            child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(Icons.cleaning_services_outlined)),
          );
        },
      ),

      
      
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      }, 
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    return buildSuggestionsAndResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChange(query);

    return buildSuggestionsAndResults();
  }
  
}


class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        
        child: SizedBox(
          height: 170,
          width: 200,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath),
              ),
    
              const SizedBox(width: 10,),
    
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, 
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10,),
                    Text(movie.overview, 
                      style: const TextStyle(fontWeight: FontWeight.w400),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.star_half_outlined,
                            color: Colors.yellow.shade800),
                        const SizedBox(
                          width: 3,
                        ),  
                        Text(movie.voteAverage.toStringAsFixed(1)),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}