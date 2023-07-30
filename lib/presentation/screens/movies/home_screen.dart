import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView()
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final moviesNowPlaying = ref.watch(nowPlayingMoviesProvider);

    return Column(
      children: [

        CustomAppbar(),

        Expanded(
          child: ListView.builder(
            itemCount: moviesNowPlaying.length,
            itemBuilder: (context, index) {
            final movie = moviesNowPlaying[index];
              return ListTile(
                title: Text(movie.title),
              );
            },
          ),
        )
      ],
    );
  }
}