import 'package:movie/movie.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import '../../../presentation/bloc/movie/search_movie_bloc_test.mocks.dart';

@GenerateMocks([
  SearchMovies,
])
void main() {
  late SearchMovieBloc searchMovieBloc;

  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();

    searchMovieBloc = SearchMovieBloc(mockSearchMovies);
  });

  group('search event', () {
    testWidgets('on query changed event', (tester) async {
      expect(
        OnMovieSearch('spiderman') != OnMovieSearch('avengers'),
        true,
      );
    });
  });

  group('search movie', () {
    test('initial state should be empty', () {
      expect(searchMovieBloc.state, MovieEmpty());
    });

    final tMovie = Movie(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );
    final tMovies = <Movie>[tMovie];
    final tQuery = 'spiderman';

    blocTest<SearchMovieBloc, MovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovies));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(OnMovieSearch(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieLoading(),
        SearchHasData(tMovies),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchMovieBloc, MovieState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchMovieBloc;
      },
      act: (bloc) => bloc.add(OnMovieSearch(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieLoading(),
        MovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });
}
