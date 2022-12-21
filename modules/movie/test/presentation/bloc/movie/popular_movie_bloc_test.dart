import 'package:movie/movie.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import '../../../presentation/bloc/movie/popular_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetPopularMovies,
])
void main() {
  late PopularMoviesBloc blocPopularMovies;

  late MockGetPopularMovies mockPopularMovies;

  setUp(() {
    mockPopularMovies = MockGetPopularMovies();

    blocPopularMovies = PopularMoviesBloc(mockPopularMovies);
  });

  group('airing today movies', () {
    test('initial state should be loading', () {
      expect(blocPopularMovies.state, MovieLoading());
    });

    blocTest<PopularMoviesBloc, MovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return blocPopularMovies;
      },
      act: (bloc) => bloc.add(OnPopularMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        MovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockPopularMovies.execute());
      },
    );

    blocTest<PopularMoviesBloc, MovieState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return blocPopularMovies;
      },
      act: (bloc) => bloc.add(OnPopularMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        MovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockPopularMovies.execute());
      },
    );
  });
}
