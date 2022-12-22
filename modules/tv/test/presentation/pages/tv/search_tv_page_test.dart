import 'package:tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helpers/bloc_test_helper_tv.dart';

void main() {
  group('search tv page', () {
    late MockSearchTvBloc mockSearchTvBloc;

    setUpAll(() {
      mockSearchTvBloc = MockSearchTvBloc();
      registerFallbackValue(TvStateFake());
      registerFallbackValue(TvEventFake());
    });

    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<SearchTvBloc>.value(
        value: mockSearchTvBloc,
        child: MaterialApp(
          home: Scaffold(body: body),
        ),
      );
    }

    tearDown(() {
      mockSearchTvBloc.close();
    });

    final tTv = Tv(
      backdropPath: 'backdropPath',
      genreIds: const [1, 2, 3, 4],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      name: 'name',
      voteAverage: 1.0,
      voteCount: 1,
    );

    final List<Tv> tListTv = [tTv];

    testWidgets('should be return List Tvs when success', (tester) async {
      when(() => mockSearchTvBloc.state).thenReturn(TvHasData(tListTv));
      await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));
      await tester.enterText(find.byType(TextField), 'name');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('name'), findsWidgets);
    });
    testWidgets('should be return progress loading when loading',
        (tester) async {
      when(() => mockSearchTvBloc.state).thenReturn(TvLoading());

      await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });
    testWidgets('should be return container when error', (tester) async {
      when(() => mockSearchTvBloc.state).thenReturn(TvError('Error message'));

      await tester.pumpWidget(_makeTestableWidget(SearchTvPage()));

      expect(find.byKey(const Key('error')), findsWidgets);
    });
  });
}
