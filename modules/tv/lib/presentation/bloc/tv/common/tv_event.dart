import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv/tv_detail.dart';

abstract class TvEvent extends Equatable {
  const TvEvent();

  @override
  List<Object> get props => [];
}

class OnTvSearch extends TvEvent {
  final String query;
  OnTvSearch(this.query);

  @override
  List<Object> get props => [query];
}

class OnAiringTodayTv extends TvEvent {}

class OnTheAirTv extends TvEvent {}

class OnPopularTv extends TvEvent {}

class OnTopRatedTv extends TvEvent {}

class OnWatchlistTvs extends TvEvent {}

class OnWatchlistTvStatus extends TvEvent {
  final int id;
  const OnWatchlistTvStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnSaveWatchlistTv extends TvEvent {
  final TvDetail tvDetail;
  const OnSaveWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class OnRemoveWatchlistTv extends TvEvent {
  final TvDetail tvDetail;
  const OnRemoveWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class OnTvDetail extends TvEvent {
  final int id;
  const OnTvDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnTvRecommendations extends TvEvent {
  final int id;
  const OnTvRecommendations(this.id);

  @override
  List<Object> get props => [id];
}
