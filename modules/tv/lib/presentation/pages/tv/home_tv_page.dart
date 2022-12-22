import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/constants.dart';
import 'package:core/styles/text_styles.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:about/about_page.dart';
import 'package:movie/presentation/pages/movie/home_movie_page.dart';
import 'package:tv/presentation/pages/tv/tv_detail_page.dart';
import 'package:tv/presentation/pages/tv/popular_tvs_page.dart';
import 'package:tv/presentation/pages/tv/airing_today_tvs_page.dart';
import 'package:tv/presentation/pages/tv/search_tvs_page.dart';
import 'package:tv/presentation/pages/tv/top_rated_tvs_page.dart';
import 'package:tv/presentation/pages/tv/watchlist_tvs_page.dart';
import 'package:movie/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:tv/presentation/pages/tv/on_the_air_tvs_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv/airing_today_bloc.dart';
import 'package:tv/presentation/bloc/tv/on_the_air_bloc.dart';
import 'package:tv/presentation/bloc/tv/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv/top_rated_tv_bloc.dart';
import 'package:tv/presentation/bloc/tv/common/tv_state.dart';
import 'package:tv/presentation/bloc/tv/common/tv_event.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv';
  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AiringTodayTvsBloc>().add(OnAiringTodayTv());
      context.read<OnTheAirTvsBloc>().add(OnTheAirTv());
      context.read<PopularTvsBloc>().add(OnPopularTv());
      context.read<TopRatedTvsBloc>().add(OnTopRatedTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        key: Key('tv'),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('tv@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movie'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Tv'),
              onTap: () {
                Navigator.pop(context);
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
              title: Text('Watchlist Tv'),
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
        title: Text('Tv'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
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
              _buildSubHeading(
                title: 'Airing Today',
                onTap: () =>
                    Navigator.pushNamed(context, AiringTodayTvsPage.ROUTE_NAME),
              ),
              BlocBuilder<AiringTodayTvsBloc, TvState>(
                builder: (context, state) {
                  if (state is TvLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvHasData) {
                    return TvList(state.result);
                  } else {
                    return Text(
                      'Failed',
                      key: Key('Failed'),
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: 'On Tv',
                onTap: () =>
                    Navigator.pushNamed(context, OnTheAirTvsPage.ROUTE_NAME),
              ),
              BlocBuilder<OnTheAirTvsBloc, TvState>(
                builder: (context, state) {
                  if (state is TvLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvHasData) {
                    return TvList(state.result);
                  } else {
                    return Text(
                      'Failed',
                      key: Key('Failed'),
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvsPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvsBloc, TvState>(
                builder: (context, state) {
                  if (state is TvLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvHasData) {
                    return TvList(state.result);
                  } else {
                    return Text(
                      'Failed',
                      key: Key('Failed'),
                    );
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvsPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvsBloc, TvState>(
                builder: (context, state) {
                  if (state is TvLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TvHasData) {
                    return TvList(state.result);
                  } else {
                    return Center(
                      key: const Key('failed'),
                      child: Text('Failed'),
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

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  TvList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
