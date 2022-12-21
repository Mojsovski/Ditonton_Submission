import 'package:movie/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import '../../../helpers/bloc_test_helper_movie.dart';

void main() {
  late MockWatchlistMoviesBloc mockGetWatchlistMoviesBloc;

  setUpAll(() {
    mockGetWatchlistMoviesBloc = MockWatchlistMoviesBloc();
    registerFallbackValue(MovieEventFake());
    registerFallbackValue(MovieStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistMoviesBloc>(
            create: (_) => mockGetWatchlistMoviesBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should be show MovieCard List when Watchlist success loaded',
      (WidgetTester tester) async {
    when(() => mockGetWatchlistMoviesBloc.state)
        .thenReturn(MovieHasData(testMovieList));

    await tester.pumpWidget(
        _makeTestableWidget(Material(child: WatchlistMoviesPage())));

    expect(find.byType(MovieCard), findsOneWidget);
  });

  testWidgets('should be show CircularProgress when Watchlist loading',
      (WidgetTester tester) async {
    when(() => mockGetWatchlistMoviesBloc.state).thenReturn(MovieLoading());

    await tester.pumpWidget(
        _makeTestableWidget(Material(child: WatchlistMoviesPage())));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should be show text error when Watchlist error',
      (WidgetTester tester) async {
    when(() => mockGetWatchlistMoviesBloc.state)
        .thenReturn(MovieError('Error'));

    await tester.pumpWidget(
        _makeTestableWidget(Material(child: WatchlistMoviesPage())));

    expect(find.text('Error'), findsOneWidget);
  });
}
