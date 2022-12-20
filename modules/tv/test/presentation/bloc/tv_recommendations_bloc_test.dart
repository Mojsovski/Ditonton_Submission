import 'package:tv/tv.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import '../../dummy_data/tv/dummy_objects_tv.dart';
import '../bloc/tv_recommendations_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvRecommendations,
])
void main() {
  late TvRecommendationsBloc blocTvRecommendations;

  late MockGetTvRecommendations mockTvRecommendations;

  setUp(() {
    mockTvRecommendations = MockGetTvRecommendations();

    blocTvRecommendations = TvRecommendationsBloc(mockTvRecommendations);
  });

  const tId = 1;

  group('tv recommendations', () {
    test('initial state should be loading', () {
      expect(blocTvRecommendations.state, TvLoading());
    });

    blocTest<TvRecommendationsBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTvList));
        return blocTvRecommendations;
      },
      act: (bloc) => bloc.add(const OnTvRecommendations(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockTvRecommendations.execute(tId));
      },
    );
    blocTest<TvRecommendationsBloc, TvState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return blocTvRecommendations;
      },
      act: (bloc) => bloc.add(const OnTvRecommendations(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockTvRecommendations.execute(tId));
      },
    );
  });
}
