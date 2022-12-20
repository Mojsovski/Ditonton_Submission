import 'package:tv/tv.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import '../../dummy_data/tv/dummy_objects_tv.dart';
import '../bloc/watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvs,
  GetWatchListTvStatus,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late WatchlistTvsBloc blocWatchlistTvs;

  late MockGetWatchlistTvs mockGetWatchlistTvs;
  late MockGetWatchListTvStatus mockGetWatchListTvStatus;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    mockGetWatchListTvStatus = MockGetWatchListTvStatus();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();

    blocWatchlistTvs = WatchlistTvsBloc(
      mockGetWatchlistTvs,
      mockGetWatchListTvStatus,
      mockSaveWatchlistTv,
      mockRemoveWatchlistTv,
    );
  });

  const tId = 1;
  const tSaveMessage = WatchlistTvsBloc.watchlistAddSuccessMessage;
  const tRemoveMessage = WatchlistTvsBloc.watchlistRemoveSuccessMessage;

  group('watchlist tvs', () {
    test('initial state should be loading', () {
      expect(blocWatchlistTvs.state, TvLoading());
    });
    group('get watchlist tvs list', () {
      blocTest<WatchlistTvsBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistTvs.execute())
              .thenAnswer((_) async => Right(testTvList));
          return blocWatchlistTvs;
        },
        act: (bloc) => bloc.add(OnWatchlistTvs()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          TvHasData(testTvList),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTvs.execute());
        },
      );
      blocTest<WatchlistTvsBloc, TvState>(
        'Should emit [Loading, Error] when unsuccessful',
        build: () {
          when(mockGetWatchlistTvs.execute()).thenAnswer(
              (_) async => Left(DatabaseFailure('Database Failure')));
          return blocWatchlistTvs;
        },
        act: (bloc) => bloc.add(OnWatchlistTvs()),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          TvError('Database Failure'),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTvs.execute());
        },
      );
    });

    group('get watchlist tvs status', () {
      blocTest<WatchlistTvsBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchListTvStatus.execute(tId))
              .thenAnswer((_) async => true);
          return blocWatchlistTvs;
        },
        act: (bloc) => bloc.add(OnWatchlistTvStatus(tId)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          const TvWatchlistStatus(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchListTvStatus.execute(tId));
        },
      );
    });

    group('save watchlist tv', () {
      blocTest<WatchlistTvsBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSaveWatchlistTv.execute(testTvDetail))
              .thenAnswer((_) async => const Right(tSaveMessage));
          return blocWatchlistTvs;
        },
        act: (bloc) => bloc.add(OnSaveWatchlistTv(testTvDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          const TvWatchlistMessage(tSaveMessage),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistTv.execute(testTvDetail));
        },
      );
      blocTest<WatchlistTvsBloc, TvState>(
        'Should emit [Loading, Error] when unsuccessful',
        build: () {
          when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer(
              (_) async => Left(DatabaseFailure('Database Failure')));
          return blocWatchlistTvs;
        },
        act: (bloc) => bloc.add(OnSaveWatchlistTv(testTvDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          TvError('Database Failure'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistTv.execute(testTvDetail));
        },
      );
    });
    group('remove watchlist tv', () {
      blocTest<WatchlistTvsBloc, TvState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockRemoveWatchlistTv.execute(testTvDetail))
              .thenAnswer((_) async => const Right(tRemoveMessage));
          return blocWatchlistTvs;
        },
        act: (bloc) => bloc.add(OnRemoveWatchlistTv(testTvDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          const TvWatchlistMessage(tRemoveMessage),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistTv.execute(testTvDetail));
        },
      );
      blocTest<WatchlistTvsBloc, TvState>(
        'Should emit [Loading, Error] when unsuccessful',
        build: () {
          when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer(
              (_) async => Left(DatabaseFailure('Database Failure')));
          return blocWatchlistTvs;
        },
        act: (bloc) => bloc.add(OnRemoveWatchlistTv(testTvDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [
          TvLoading(),
          TvError('Database Failure'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistTv.execute(testTvDetail));
        },
      );
    });
  });
}
