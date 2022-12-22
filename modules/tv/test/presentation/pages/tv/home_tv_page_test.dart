import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import '../../../helpers/bloc_test_helper_tv.dart';

import '../../../../../movie/test/helpers/bloc_test_helper_movie.dart';

void main() {
  late MockAiringTodayTvsBloc mockGetAiringTodayTvBloc;
  late MockOnTheAirTvsBloc mockGetOnTheAirTvsBloc;
  late MockPopularTvsBloc mockGetPopularTvsBloc;
  late MockTopRatedTvsBloc mockGetTopRatedTvsBloc;
  late MockWatchlistTvsBloc mockGetWatchlistTvsBloc;
  late MockSearchTvBloc mockSearchTvBloc;

  late MockNowPlayingMoviesBloc mockGetNowPlayingMovieBloc;
  late MockPopularMoviesBloc mockGetPopularMoviesBloc;
  late MockTopRatedMoviesBloc mockGetTopRatedMoviesBloc;
  late MockWatchlistMoviesBloc mockGetWatchlistMoviesBloc;

  setUpAll(() {
    mockGetAiringTodayTvBloc = MockAiringTodayTvsBloc();
    mockGetOnTheAirTvsBloc = MockOnTheAirTvsBloc();
    mockGetPopularTvsBloc = MockPopularTvsBloc();
    mockGetTopRatedTvsBloc = MockTopRatedTvsBloc();
    mockGetWatchlistTvsBloc = MockWatchlistTvsBloc();
    mockSearchTvBloc = MockSearchTvBloc();
    registerFallbackValue(TvEventFake());
    registerFallbackValue(TvStateFake());

    mockGetNowPlayingMovieBloc = MockNowPlayingMoviesBloc();
    mockGetPopularMoviesBloc = MockPopularMoviesBloc();
    mockGetTopRatedMoviesBloc = MockTopRatedMoviesBloc();
    mockGetWatchlistMoviesBloc = MockWatchlistMoviesBloc();

    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesBloc>(
            create: (_) => mockGetNowPlayingMovieBloc),
        BlocProvider<PopularMoviesBloc>(
            create: (_) => mockGetPopularMoviesBloc),
        BlocProvider<TopRatedMoviesBloc>(
            create: (_) => mockGetTopRatedMoviesBloc),
        BlocProvider<WatchlistMoviesBloc>(
            create: (_) => mockGetWatchlistMoviesBloc),
        BlocProvider<AiringTodayTvsBloc>(
            create: (_) => mockGetAiringTodayTvBloc),
        BlocProvider<OnTheAirTvsBloc>(create: (_) => mockGetOnTheAirTvsBloc),
        BlocProvider<PopularTvsBloc>(create: (_) => mockGetPopularTvsBloc),
        BlocProvider<TopRatedTvsBloc>(create: (_) => mockGetTopRatedTvsBloc),
        BlocProvider<WatchlistTvsBloc>(create: (_) => mockGetWatchlistTvsBloc),
        BlocProvider<SearchTvBloc>(create: (_) => mockSearchTvBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Show Body', () {
    testWidgets('show TvList when On The Air success fetch data',
        (WidgetTester tester) async {
      when(() => mockGetAiringTodayTvBloc.state).thenReturn(TvEmpty());
      when(() => mockGetOnTheAirTvsBloc.state)
          .thenReturn(TvHasData(testTvList));
      when(() => mockGetPopularTvsBloc.state).thenReturn(TvEmpty());
      when(() => mockGetTopRatedTvsBloc.state).thenReturn(TvEmpty());

      final tvList = find.byType(TvList);
      final keyFailedAiringTodayTvs = find.byKey(const Key('failed'));
      final keyFailedPopularTvs = find.byKey(const Key('failed'));
      final keyFailedTopRatedTvs = find.byKey(const Key('failed'));

      await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(tvList, findsOneWidget);
      expect(keyFailedAiringTodayTvs, findsOneWidget);
      expect(keyFailedPopularTvs, findsOneWidget);
      expect(keyFailedTopRatedTvs, findsOneWidget);
    });

    testWidgets('show TvList when Popular Tvs success fetch data',
        (WidgetTester tester) async {
      when(() => mockGetAiringTodayTvBloc.state).thenReturn(TvEmpty());
      when(() => mockGetOnTheAirTvsBloc.state).thenReturn(TvEmpty());
      when(() => mockGetPopularTvsBloc.state).thenReturn(TvHasData(testTvList));
      when(() => mockGetTopRatedTvsBloc.state).thenReturn(TvEmpty());

      final tvList = find.byType(TvList);
      final keyFailedAiringTodayTvs = find.byKey(const Key('failed'));
      final keyFailedPopularTvs = find.byKey(const Key('failed'));
      final keyFailedTopRatedTvs = find.byKey(const Key('failed'));

      await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(tvList, findsOneWidget);
      expect(keyFailedAiringTodayTvs, findsOneWidget);
      expect(keyFailedPopularTvs, findsOneWidget);
      expect(keyFailedTopRatedTvs, findsOneWidget);
    });

    testWidgets('show TvList when Top Rated Tvs success fetch data',
        (WidgetTester tester) async {
      when(() => mockGetAiringTodayTvBloc.state).thenReturn(TvEmpty());
      when(() => mockGetOnTheAirTvsBloc.state).thenReturn(TvEmpty());
      when(() => mockGetPopularTvsBloc.state).thenReturn(TvEmpty());
      when(() => mockGetTopRatedTvsBloc.state)
          .thenReturn(TvHasData(testTvList));

      final tvList = find.byType(TvList);

      await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(tvList, findsOneWidget);
    });

    testWidgets(
        'show text failed when Airing Today, Popular, Top Rated Tvs error fetch data',
        (WidgetTester tester) async {
      when(() => mockGetAiringTodayTvBloc.state).thenReturn(TvEmpty());
      when(() => mockGetOnTheAirTvsBloc.state).thenReturn(TvEmpty());
      when(() => mockGetPopularTvsBloc.state).thenReturn(TvEmpty());
      when(() => mockGetTopRatedTvsBloc.state).thenReturn(TvEmpty());

      await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));
    });

    testWidgets('show CircularLoading when loading fetch data',
        (WidgetTester tester) async {
      when(() => mockGetAiringTodayTvBloc.state).thenReturn(TvLoading());
      when(() => mockGetOnTheAirTvsBloc.state).thenReturn(TvLoading());
      when(() => mockGetPopularTvsBloc.state).thenReturn(TvLoading());
      when(() => mockGetTopRatedTvsBloc.state).thenReturn(TvLoading());

      final typeCircularProgressIndicator =
          find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(HomeTvPage()));

      expect(typeCircularProgressIndicator, findsNWidgets(4));
    });
  });
}
