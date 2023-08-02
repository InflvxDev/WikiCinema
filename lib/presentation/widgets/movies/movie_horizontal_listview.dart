import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';


class MovieHorizontalListview extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;


  const MovieHorizontalListview({super.key, required this.movies, this.title, this.subtitle, this.loadNextPage});

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;
      
      if((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent){
        widget.loadNextPage!();
      }

    });
  } 

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [

          if(widget.title!= null || widget.subtitle!= null)
            _Tittle(tittle: widget.title, subtittle: widget.subtitle,),
          
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
            )
          )


        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null){
                    return const Center(child: CircularProgressIndicator(strokeWidth: 2,));
                  }
                  return GestureDetector(
                    onTap: () => context.push('/movie/${movie.id}'),
                    child: FadeIn(child: child)
,
                  ) ;
                },
              ),
            ),
          ),

          const SizedBox(height: 3,),

          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Row(
            children: [
              Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
              const SizedBox(width: 3,),
              Text('${movie.voteAverage}'),
              const SizedBox(width: 10,),
              Text(HumansFormats.humanReadbleNumbers(movie.popularity))

            ],
          )
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
            Text(tittle!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          
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