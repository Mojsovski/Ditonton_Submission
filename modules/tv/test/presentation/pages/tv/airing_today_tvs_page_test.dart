import 'package:tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import '../../../helpers/bloc_test_helper_tv.dart';

void main() {
  late MockAiringTodayTvsBloc mockAiringTodayTvsBloc;

  setUp(() {
    mockAiringTodayTvsBloc = MockAiringTodayTvsBloc();
    registerFallbackValue(TvEventFake());
    registerFallbackValue(TvStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<AiringTodayTvsBloc>.value(
      value: mockAiringTodayTvsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockAiringTodayTvsBloc.state).thenReturn(TvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(AiringTodayTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockAiringTodayTvsBloc.state).thenReturn(TvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(AiringTodayTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display TvsCard when data is loaded',
      (WidgetTester tester) async {
    when(() => mockAiringTodayTvsBloc.state).thenReturn(TvHasData(testTvList));

    final movieCardFinder = find.byType(TvCard);

    await tester.pumpWidget(_makeTestableWidget(AiringTodayTvsPage()));

    expect(movieCardFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockAiringTodayTvsBloc.state)
        .thenReturn(TvError('Something went wrong'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(AiringTodayTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
