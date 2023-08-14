import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_outlined,
                color: colors.primary,
                size: 25,
              ),
              const SizedBox(width: 5,),
              const Text('FilmografíaWiki',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold
                )
              ),
      
              const Spacer(),
      
              IconButton(
                icon: const Icon(
                  Icons.search_outlined,
                  color: Colors.grey,
                  size: 25,
                ),
                onPressed: () {

                  final movieRepository= ref.read(movieRepositoryProvider);
                  final searchQuery = ref.read(searchQueryProvider);

                  showSearch<Movie?>(
                    query: searchQuery,
                    context: context, 
                    delegate: SearchMovieDelegate(
                      searchMovies: (query) {
                        ref.read(searchQueryProvider.notifier).update((state) => query);
                        return movieRepository.searchMovies(query);
                      }
                    )
                  ).then((value) {
                    if (value != null) {
                      context.push('/movie/${value.id}');
                    }
                    return;
                  });
                },
              ),
      
            ],
          ),
        ),
      
      )
    );
  }
}
