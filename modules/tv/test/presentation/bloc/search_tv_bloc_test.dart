import 'package:tv/tv.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import '../bloc/search_tv_bloc_test.mocks.dart';

@GenerateMocks([
  SearchTvs,
])
void main() {
  late SearchTvBloc searchTvBloc;

  late MockSearchTvs mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTvs();

    searchTvBloc = SearchTvBloc(mockSearchTvs);
  });

  group('search event', () {
    testWidgets('on query changed event', (tester) async {
      expect(
        OnTvSearch('spiderman') != OnTvSearch('avengers'),
        true,
      );
    });
  });

  group('search tv', () {
    test('initial state should be empty', () {
      expect(searchTvBloc.state, TvEmpty());
    });

    final tTvModel = Tv(
      backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
      genreIds: [14, 28],
      id: 557,
      originalName: 'Spider-Man',
      overview:
          'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
      popularity: 60.441,
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      firstAirDate: '2002-05-01',
      name: 'Spider-Man',
      voteAverage: 7.2,
      voteCount: 13507,
    );
    final tTvList = <Tv>[tTvModel];
    final tQuery = 'spiderman';

    blocTest<SearchTvBloc, TvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchTvs.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnTvSearch(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        SearchTvHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockSearchTvs.execute(tQuery));
      },
    );

    blocTest<SearchTvBloc, TvState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchTvs.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnTvSearch(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        TvLoading(),
        TvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTvs.execute(tQuery));
      },
    );
  });
}
