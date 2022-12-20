import 'package:tv/tv.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import '../../dummy_data/tv/dummy_objects_tv.dart';
import '../bloc/airing_today_bloc_test.mocks.dart';

@GenerateMocks([
  GetAiringTodayTvs,
])
void main() {
  late AiringTodayTvsBloc blocAiringTodayTvs;

  late MockGetAiringTodayTvs mockAiringTodayTvs;

  setUp(() {
    mockAiringTodayTvs = MockGetAiringTodayTvs();

    blocAiringTodayTvs = AiringTodayTvsBloc(mockAiringTodayTvs);
  });

  group('airing today tvs', () {
    test('initial state should be loading', () {
      expect(blocAiringTodayTvs.state, TvLoading());
    });

    blocTest<AiringTodayTvsBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockAiringTodayTvs.execute())
            .thenAnswer((_) async => Right(testTvList));
        return blocAiringTodayTvs;
      },
      act: (bloc) => bloc.add(OnAiringTodayTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockAiringTodayTvs.execute());
      },
    );

    blocTest<AiringTodayTvsBloc, TvState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockAiringTodayTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return blocAiringTodayTvs;
      },
      act: (bloc) => bloc.add(OnAiringTodayTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockAiringTodayTvs.execute());
      },
    );
  });
}
