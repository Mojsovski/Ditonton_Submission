import 'package:tv/tv.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import '../../dummy_data/tv/dummy_objects_tv.dart';
import '../bloc/popular_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetPopularTvs,
])
void main() {
  late PopularTvsBloc blocPopularTvs;

  late MockGetPopularTvs mockPopularTvs;

  setUp(() {
    mockPopularTvs = MockGetPopularTvs();

    blocPopularTvs = PopularTvsBloc(mockPopularTvs);
  });

  group('airing today tvs', () {
    test('initial state should be loading', () {
      expect(blocPopularTvs.state, TvLoading());
    });

    blocTest<PopularTvsBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockPopularTvs.execute())
            .thenAnswer((_) async => Right(testTvList));
        return blocPopularTvs;
      },
      act: (bloc) => bloc.add(OnPopularTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockPopularTvs.execute());
      },
    );

    blocTest<PopularTvsBloc, TvState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockPopularTvs.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return blocPopularTvs;
      },
      act: (bloc) => bloc.add(OnPopularTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockPopularTvs.execute());
      },
    );
  });
}
