import 'package:movie/movie.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import '../../../presentation/bloc/movie/now_playing_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
])
void main() {
  late NowPlayingMoviesBloc blocNowPlayingMovies;

  late MockGetNowPlayingMovies mockNowPlayingMovies;

  setUp(() {
    mockNowPlayingMovies = MockGetNowPlayingMovies();

    blocNowPlayingMovies = NowPlayingMoviesBloc(mockNowPlayingMovies);
  });

  group('airing today movies', () {
    test('initial state should be loading', () {
      expect(blocNowPlayingMovies.state, MovieLoading());
    });

    blocTest<NowPlayingMoviesBloc, MovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return blocNowPlayingMovies;
      },
      act: (bloc) => bloc.add(OnNowPlayingMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        MovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingMoviesBloc, MovieState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return blocNowPlayingMovies;
      },
      act: (bloc) => bloc.add(OnNowPlayingMovie()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        MovieLoading(),
        MovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockNowPlayingMovies.execute());
      },
    );
  });
}
