import 'dart:ui';

import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
              const Text('WikiCinema',
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
                  
                },
              ),
      
            ],
          ),
        ),
      
      )
    );
  }
}
