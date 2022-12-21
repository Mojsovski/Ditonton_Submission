import 'package:movie/movie.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import '../../../presentation/bloc/movie/movie_recommendations_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieRecommendations,
])
void main() {
  late MovieRecommendationsBloc blocMovieRecommendations;

  late MockGetMovieRecommendations mockMovieRecommendations;

  setUp(() {
    mockMovieRecommendations = MockGetMovieRecommendations();

    blocMovieRecommendations =
        MovieRecommendationsBloc(mockMovieRecommendations);
  });

  const tId = 1;

  group('movie recommendations', () {
    test('initial state should be loading', () {
      expect(blocMovieRecommendations.state, MovieLoading());
    });

    blocTest<MovieRecommendationsBloc, MovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return blocMovieRecommendations;
      },
      act: (bloc) => bloc.add(const OnMovieRecommendations(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        MovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockMovieRecommendations.execute(tId));
      },
    );
    blocTest<MovieRecommendationsBloc, MovieState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return blocMovieRecommendations;
      },
      act: (bloc) => bloc.add(const OnMovieRecommendations(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        MovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockMovieRecommendations.execute(tId));
      },
    );
  });
}
