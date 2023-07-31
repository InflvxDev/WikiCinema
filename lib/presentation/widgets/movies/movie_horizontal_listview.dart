import 'package:flutter/material.dart';

import '../../../domain/entities/movie.dart';


class MovieHorizontalListview extends StatelessWidget {

  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;


  const MovieHorizontalListview({super.key, required this.movies, this.title, this.subtitle, this.loadNextPage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [

          if(title!= null || subtitle!= null)
            _Tittle(tittle: title, subtittle: subtitle,)
          


        ],
      ),
    );
  }
}


class _Tittle extends StatelessWidget {

  final String? tittle;
  final String? subtittle;

  const _Tittle({ this.tittle, this.subtittle});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
      child: Row(
        children: [

          if(tittle != null)
            Text(tittle!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          
          const Spacer(),

          if(subtittle != null)
            FilledButton.tonal(
              onPressed: () {},
              child: Text(subtittle!),
            ),
            
        ],
      ),
    );
  }
}