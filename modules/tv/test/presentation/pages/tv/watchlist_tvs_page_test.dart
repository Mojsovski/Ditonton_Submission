import 'package:tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import '../../../helpers/bloc_test_helper_tv.dart';

void main() {
  late MockWatchlistTvsBloc mockGetWatchlistTvsBloc;

  setUpAll(() {
    mockGetWatchlistTvsBloc = MockWatchlistTvsBloc();
    registerFallbackValue(TvEventFake());
    registerFallbackValue(TvStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistTvsBloc>(create: (_) => mockGetWatchlistTvsBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should be show TvCard List when Watchlist success loaded',
      (WidgetTester tester) async {
    when(() => mockGetWatchlistTvsBloc.state).thenReturn(TvHasData(testTvList));

    await tester
        .pumpWidget(_makeTestableWidget(Material(child: WatchlistTvsPage())));

    expect(find.byType(TvCard), findsOneWidget);
  });

  testWidgets('should be show CircularProgress when Watchlist loading',
      (WidgetTester tester) async {
    when(() => mockGetWatchlistTvsBloc.state).thenReturn(TvLoading());

    await tester
        .pumpWidget(_makeTestableWidget(Material(child: WatchlistTvsPage())));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should be show text error when Watchlist error',
      (WidgetTester tester) async {
    when(() => mockGetWatchlistTvsBloc.state).thenReturn(TvError('Error'));

    await tester
        .pumpWidget(_makeTestableWidget(Material(child: WatchlistTvsPage())));

    expect(find.text('Error'), findsOneWidget);
  });
}
