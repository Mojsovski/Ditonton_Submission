import 'package:tv/tv.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import '../../dummy_data/tv/dummy_objects_tv.dart';
import '../bloc/on_the_air_bloc_test.mocks.dart';

@GenerateMocks([
  GetOnTheAirTvs,
])
void main() {
  late OnTheAirTvsBloc blocOnTheAirTvs;

  late MockGetOnTheAirTvs mockOnTheAirTvs;

  setUp(() {
    mockOnTheAirTvs = MockGetOnTheAirTvs();

    blocOnTheAirTvs = OnTheAirTvsBloc(mockOnTheAirTvs);
  });

  group('airing today tvs', () {
    test('initial state should be loading', () {
      expect(blocOnTheAirTvs.state, TvLoading());
    });

    blocTest<OnTheAirTvsBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockOnTheAirTvs.execute())
            .thenAnswer((_) async => Right(testTvList));
        return blocOnTheAirTvs;
      },
      act: (bloc) => bloc.add(OnTheAirTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockOnTheAirTvs.execute());
      },
    );

    blocTest<OnTheAirTvsBloc, TvState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockOnTheAirTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return blocOnTheAirTvs;
      },
      act: (bloc) => bloc.add(OnTheAirTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockOnTheAirTvs.execute());
      },
    );
  });
}
