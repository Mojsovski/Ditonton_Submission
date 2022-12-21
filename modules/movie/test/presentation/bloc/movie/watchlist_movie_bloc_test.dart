import 'package:movie/movie.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import '../../../dummy_data/movie/dummy_objects.dart';
import '../../../presentation/bloc/movie/watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late WatchlistMoviesBloc blocWatchlistMovies;

  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();

    blocWatchlistMovies = WatchlistMoviesBloc(
      mockGetWatchlistMovies,
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  const tId = 1;
  const tSaveMessage = WatchlistMoviesBloc.watchlistAddSuccessMessage;
  const tRemoveMessage = WatchlistMoviesBloc.watchlistRemoveSuccessMessage;

  group('watchlist movies', () {
    test('initial state should be loading', () {
      expect(blocWatchlistMovies.state, MovieLoading());
    });
    group('get watchlist movies list', () {
      blocTest<WatchlistMoviesBloc, MovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right(testMovieList));
          return blocWatchlistMovies;
        },
        act: (bloc) => bloc.add(OnWatchlistMovies()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieLoading(),
          MovieHasData(testMovieList),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        },
      );
      blocTest<WatchlistMoviesBloc, MovieState>(
        'Should emit [Loading, Error] when unsuccessful',
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer(
              (_) async => Left(DatabaseFailure('Database Failure')));
          return blocWatchlistMovies;
        },
        act: (bloc) => bloc.add(OnWatchlistMovies()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieLoading(),
          MovieError('Database Failure'),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        },
      );
    });

    group('get watchlist movies status', () {
      blocTest<WatchlistMoviesBloc, MovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => true);
          return blocWatchlistMovies;
        },
        act: (bloc) => bloc.add(OnWatchlistMovieStatus(tId)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieLoading(),
          const MovieWatchlistStatus(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(tId));
        },
      );
    });

    group('save watchlist movie', () {
      blocTest<WatchlistMoviesBloc, MovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right(tSaveMessage));
          return blocWatchlistMovies;
        },
        act: (bloc) => bloc.add(OnSaveWatchlistMovie(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieLoading(),
          const MovieWatchlistMessage(tSaveMessage),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
        },
      );
      blocTest<WatchlistMoviesBloc, MovieState>(
        'Should emit [Loading, Error] when unsuccessful',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async => Left(DatabaseFailure('Database Failure')));
          return blocWatchlistMovies;
        },
        act: (bloc) => bloc.add(OnSaveWatchlistMovie(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieLoading(),
          MovieError('Database Failure'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
        },
      );
    });
    group('remove watchlist movie', () {
      blocTest<WatchlistMoviesBloc, MovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right(tRemoveMessage));
          return blocWatchlistMovies;
        },
        act: (bloc) => bloc.add(OnRemoveWatchlistMovie(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieLoading(),
          const MovieWatchlistMessage(tRemoveMessage),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
        },
      );
      blocTest<WatchlistMoviesBloc, MovieState>(
        'Should emit [Loading, Error] when unsuccessful',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async => Left(DatabaseFailure('Database Failure')));
          return blocWatchlistMovies;
        },
        act: (bloc) => bloc.add(OnRemoveWatchlistMovie(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          MovieLoading(),
          MovieError('Database Failure'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
        },
      );
    });
  });
}
