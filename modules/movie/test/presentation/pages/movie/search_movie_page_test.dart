import 'package:movie/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helpers/bloc_test_helper_movie.dart';

void main() {
  group('search movie page', () {
    late MockSearchMovieBloc mockSearchMovieBloc;

    setUpAll(() {
      mockSearchMovieBloc = MockSearchMovieBloc();
      registerFallbackValue(MovieStateFake());
      registerFallbackValue(MovieEventFake());
    });

    Widget _makeTestableWidget(Widget body) {
      return BlocProvider<SearchMovieBloc>.value(
        value: mockSearchMovieBloc,
        child: MaterialApp(
          home: Scaffold(body: body),
        ),
      );
    }

    tearDown(() {
      mockSearchMovieBloc.close();
    });

    final tMovie = Movie(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: const [1, 2, 3, 4],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      title: 'title',
      video: false,
      voteAverage: 1.0,
      voteCount: 1,
    );

    final List<Movie> tListMovie = [tMovie];

    testWidgets('should be return List Movies when success', (tester) async {
      when(() => mockSearchMovieBloc.state)
          .thenReturn(MovieHasData(tListMovie));
      await tester.pumpWidget(_makeTestableWidget(SearchMoviePage()));
      await tester.enterText(find.byType(TextField), 'name');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('name'), findsWidgets);
    });
    testWidgets('should be return progress loading when loading',
        (tester) async {
      when(() => mockSearchMovieBloc.state).thenReturn(MovieLoading());

      await tester.pumpWidget(_makeTestableWidget(SearchMoviePage()));

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });
    testWidgets('should be return container when error', (tester) async {
      when(() => mockSearchMovieBloc.state)
          .thenReturn(MovieError('Error message'));

      await tester.pumpWidget(_makeTestableWidget(SearchMoviePage()));

      expect(find.byKey(const Key('error')), findsWidgets);
    });
  });
}
