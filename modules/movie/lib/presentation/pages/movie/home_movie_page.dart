import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/constants.dart';
import 'package:core/styles/text_styles.dart';
import 'package:movie/domain/entities/movie/movie.dart';
import 'package:about/about_page.dart';
import 'package:movie/presentation/pages/movie/movie_detail_page.dart';
import 'package:movie/presentation/pages/movie/popular_movies_page.dart';
import 'package:movie/presentation/pages/movie/search_movie_page.dart';
import 'package:movie/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:movie/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:tv/presentation/pages/tv/watchlist_tvs_page.dart';
import 'package:tv/presentation/pages/tv/home_tv_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie/now_playing_bloc.dart';
import 'package:movie/presentation/bloc/movie/popular_bloc.dart';
import 'package:movie/presentation/bloc/movie/top_rated_bloc.dart';
import 'package:movie/presentation/bloc/movie/common/movie_state.dart';
import 'package:movie/presentation/bloc/movie/common/movie_event.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/home-movie';
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMoviesBloc>().add(OnNowPlayingMovie());
      context.read<PopularMoviesBloc>().add(OnPopularMovie());
      context.read<TopRatedMoviesBloc>().add(OnTopRatedMovie());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        key: Key('movie'),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movie'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('TV'),
              onTap: () {
                Navigator.pushNamed(context, HomeTvPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist Movie'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist TV'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvsPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Movie'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchMoviePage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMoviesBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieHasData) {
                    return MovieList(state.result);
                  } else {
                    return Center(
                      child: Text(
                        'Failed',
                        key: const Key('failed'),
                      ),
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularMoviesBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieHasData) {
                    return MovieList(state.result);
                  } else {
                    return Center(
                      child: Text(
                        'Failed',
                        key: const Key('failed'),
                      ),
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedMoviesBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieHasData) {
                    return MovieList(state.result);
                  } else {
                    return Center(
                      child: Text(
                        'Failed',
                        key: const Key('failed'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
