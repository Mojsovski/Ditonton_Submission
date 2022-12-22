import 'package:about/about.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import '../../../helpers/bloc_test_helper_movie.dart';

import '../../../../../tv/test/helpers/bloc_test_helper_tv.dart';

void main() {
  late MockNowPlayingMoviesBloc mockNowPlayingMovieBloc;
  late MockPopularMoviesBloc mockPopularMoviesBloc;
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;
  late MockWatchlistMoviesBloc mockWatchlistMoviesBloc;

  late MockSearchMovieBloc mockSearchMovieBloc;

  late MockAiringTodayTvsBloc mockAiringTodayTvBloc;
  late MockOnTheAirTvsBloc mockOnTheAirTvsBloc;
  late MockPopularTvsBloc mockPopularTvsBloc;
  late MockTopRatedTvsBloc mockTopRatedTvsBloc;

  setUpAll(() {
    mockNowPlayingMovieBloc = MockNowPlayingMoviesBloc();
    mockPopularMoviesBloc = MockPopularMoviesBloc();
    mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();
    mockWatchlistMoviesBloc = MockWatchlistMoviesBloc();

    mockSearchMovieBloc = MockSearchMovieBloc();

    mockAiringTodayTvBloc = MockAiringTodayTvsBloc();
    mockOnTheAirTvsBloc = MockOnTheAirTvsBloc();
    mockPopularTvsBloc = MockPopularTvsBloc();
    mockTopRatedTvsBloc = MockTopRatedTvsBloc();

    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());

    registerFallbackValue(TvEventFake());
    registerFallbackValue(TvStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesBloc>(
            create: (_) => mockNowPlayingMovieBloc),
        BlocProvider<PopularMoviesBloc>(create: (_) => mockPopularMoviesBloc),
        BlocProvider<TopRatedMoviesBloc>(create: (_) => mockTopRatedMoviesBloc),
        BlocProvider<WatchlistMoviesBloc>(
            create: (_) => mockWatchlistMoviesBloc),
        BlocProvider<SearchMovieBloc>(create: (_) => mockSearchMovieBloc),
        BlocProvider<AiringTodayTvsBloc>(create: (_) => mockAiringTodayTvBloc),
        BlocProvider<OnTheAirTvsBloc>(create: (_) => mockOnTheAirTvsBloc),
        BlocProvider<PopularTvsBloc>(create: (_) => mockPopularTvsBloc),
        BlocProvider<TopRatedTvsBloc>(create: (_) => mockTopRatedTvsBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Show Body', () {
    testWidgets('show MovieList when Popular Movies success fetch data',
        (WidgetTester tester) async {
      when(() => mockNowPlayingMovieBloc.state).thenReturn(MovieEmpty());
      when(() => mockPopularMoviesBloc.state)
          .thenReturn(MovieHasData(testMovieList));
      when(() => mockTopRatedMoviesBloc.state).thenReturn(MovieEmpty());

      final movieList = find.byType(MovieList);

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(movieList, findsOneWidget);
    });

    testWidgets('show MovieList when Top Rated Movies success fetch data',
        (WidgetTester tester) async {
      when(() => mockNowPlayingMovieBloc.state).thenReturn(MovieEmpty());
      when(() => mockPopularMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(MovieHasData(testMovieList));

      final movieList = find.byType(MovieList);

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(movieList, findsOneWidget);
    });

    testWidgets(
        'show text failed when Now Playing, Popular, Top Rated Movies error fetch data',
        (WidgetTester tester) async {
      when(() => mockNowPlayingMovieBloc.state).thenReturn(MovieEmpty());
      when(() => mockPopularMoviesBloc.state).thenReturn(MovieEmpty());
      when(() => mockTopRatedMoviesBloc.state).thenReturn(MovieEmpty());

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));
    });

    testWidgets('show CircularLoading when loading fetch data',
        (WidgetTester tester) async {
      when(() => mockNowPlayingMovieBloc.state).thenReturn(MovieLoading());
      when(() => mockPopularMoviesBloc.state).thenReturn(MovieLoading());
      when(() => mockTopRatedMoviesBloc.state).thenReturn(MovieLoading());

      final typeCircularProgressIndicator =
          find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

      expect(typeCircularProgressIndicator, findsNWidgets(3));
    });
  });
}
