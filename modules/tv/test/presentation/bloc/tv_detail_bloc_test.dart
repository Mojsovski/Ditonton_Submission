import 'package:tv/tv.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import '../../dummy_data/tv/dummy_objects_tv.dart';
import '../bloc/tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
])
void main() {
  late TvDetailBloc blocTvDetail;

  late MockGetTvDetail mockTvDetail;

  setUp(() {
    mockTvDetail = MockGetTvDetail();

    blocTvDetail = TvDetailBloc(mockTvDetail);
  });

  const tId = 1;

  group('tv detail', () {
    test('initial state should be loading', () {
      expect(blocTvDetail.state, TvLoading());
    });

    blocTest<TvDetailBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        return blocTvDetail;
      },
      act: (bloc) => bloc.add(const OnTvDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvDetailHasData(testTvDetail),
      ],
      verify: (bloc) {
        verify(mockTvDetail.execute(tId));
      },
    );
    blocTest<TvDetailBloc, TvState>(
      'Should emit [Loading, Error] when unsuccessful',
      build: () {
        when(mockTvDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return blocTvDetail;
      },
      act: (bloc) => bloc.add(const OnTvDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TvLoading(),
        TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockTvDetail.execute(tId));
      },
    );
  });
}
