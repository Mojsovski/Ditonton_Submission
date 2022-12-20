import 'package:tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import '../../../helpers/bloc_test_helper.dart';

void main() {
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvRecommendationsBloc mockTvRecommendationsBloc;
  late MockWatchlistTvsBloc mockTvWatchlistBloc;

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvRecommendationsBloc = MockTvRecommendationsBloc();
    mockTvWatchlistBloc = MockWatchlistTvsBloc();
    registerFallbackValue(TvEventFake());
    registerFallbackValue(TvStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>.value(value: mockTvDetailBloc),
        BlocProvider<TvRecommendationsBloc>.value(
            value: mockTvRecommendationsBloc),
        BlocProvider<WatchlistTvsBloc>.value(value: mockTvWatchlistBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvHasData(testTvList));
    when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvHasData(testTvList));
    when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvHasData(testTvList));
    when(() => mockTvWatchlistBloc.state).thenReturn(TvWatchlistStatus(false));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationsBloc.state)
        .thenReturn(TvHasData(testTvList));
    when(() => mockTvWatchlistBloc.state).thenReturn(TvError('Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
