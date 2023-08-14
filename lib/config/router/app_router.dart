import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [

  GoRoute(
    path: '/home/:page', 
    builder: (context, state) {
      final pageIndex = state.pathParameters['page'] ?? '0';
      return HomeScreen(pageIndex: int.parse(pageIndex),);
    }, 
    routes: [
      GoRoute(
        path: 'movie/:id',
        builder: (context, state) {
          final movieid = state.pathParameters['id'] ?? 'No-id';
          return MovieScreen(
            movieId: movieid,
          );
        },
      ),
  ]),

  GoRoute(
    path: '/',
    redirect: ( _ , __ ) => '/home/0',
  ),

]);
