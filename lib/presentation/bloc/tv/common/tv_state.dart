import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TvState extends Equatable {
  const TvState();

  @override
  List<Object> get props => [];
}

class TvEmpty extends TvState {}

class TvLoading extends TvState {}

class TvError extends TvState {
  final String message;

  TvError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvHasData extends TvState {
  final List<Tv> result;

  SearchTvHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvHasData extends TvState {
  final List<Tv> result;

  const TvHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvWatchlistMessage extends TvState {
  final String message;
  const TvWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}

class TvWatchlistStatus extends TvState {
  final bool status;
  const TvWatchlistStatus(this.status);

  @override
  List<Object> get props => [status];
}

class TvDetailHasData extends TvState {
  final TvDetail result;

  const TvDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
