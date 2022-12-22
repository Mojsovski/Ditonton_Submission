import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/tv.dart';

class TvStateFake extends Fake implements TvState {}

class TvEventFake extends Fake implements TvEvent {}

class MockAiringTodayTvsBloc extends MockBloc<TvEvent, TvState>
    implements AiringTodayTvsBloc {}

class MockOnTheAirTvsBloc extends MockBloc<TvEvent, TvState>
    implements OnTheAirTvsBloc {}

class MockPopularTvsBloc extends MockBloc<TvEvent, TvState>
    implements PopularTvsBloc {}

class MockTopRatedTvsBloc extends MockBloc<TvEvent, TvState>
    implements TopRatedTvsBloc {}

class MockTvDetailBloc extends MockBloc<TvEvent, TvState>
    implements TvDetailBloc {}

class MockTvRecommendationsBloc extends MockBloc<TvEvent, TvState>
    implements TvRecommendationsBloc {}

class MockWatchlistTvsBloc extends MockBloc<TvEvent, TvState>
    implements WatchlistTvsBloc {}

class MockSearchTvBloc extends MockBloc<TvEvent, TvState>
    implements SearchTvBloc {}
