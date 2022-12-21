import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tv/presentation/bloc/tv/on_the_air_bloc.dart';
import 'package:tv/presentation/bloc/tv/common/tv_state.dart';
import 'package:tv/presentation/pages/tv/on_the_air_tvs_page.dart';

import '../../../dummy_data/tv/dummy_objects_tv.dart';
import '../../../helpers/bloc_test_helper_tv.dart';

void main() {
  late MockOnTheAirTvsBloc mockOnTheAirTvsBloc;

  setUp(() {
    mockOnTheAirTvsBloc = MockOnTheAirTvsBloc();
    registerFallbackValue(TvEventFake());
    registerFallbackValue(TvStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OnTheAirTvsBloc>.value(
      value: mockOnTheAirTvsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockOnTheAirTvsBloc.state).thenReturn(TvLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockOnTheAirTvsBloc.state).thenReturn(TvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockOnTheAirTvsBloc.state)
        .thenReturn(TvError('Something went wrong'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
