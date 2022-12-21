import 'package:movie/movie.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import '../../../presentation/bloc/movie/movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
])
void main() {
  late MovieDetailBloc blocMovieDetail;

  late MockGetMovieDetail mockMovieDetail;

  setUp(() {
    mockMovieDetail = MockGetMovieDetail();

    blocMovieDetail = MovieDetailBloc(mockMovieDetail);
  });

  const tId = 1;

  group('movie detail', () {
    test('initial state should be loading', () {
      expect(blocMovieDetail.state, MovieLoading());
    });

    blocTest<MovieDetailBloc, MovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return blocMovieDetail;
      },
      act: (bloc) => bloc.add(const OnMovieDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        MovieDetailHasData(testMovieDetail),
      ],
      verify: (bloc) {
        verify(mockMovieDetail.execute(tId));
      },
    );
    blocTest<MovieDetailBloc, MovieState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return blocMovieDetail;
      },
      act: (bloc) => bloc.add(const OnMovieDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        MovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockMovieDetail.execute(tId));
      },
    );
  });
}
