import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieEmpty extends MovieState {}

class MovieLoading extends MovieState {}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends MovieState {
  final List<Movie> result;

  SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieHasData extends MovieState {
  final List<Movie> result;

  const MovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieWatchlistMessage extends MovieState {
  final String message;
  const MovieWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistStatus extends MovieState {
  final bool status;
  const MovieWatchlistStatus(this.status);

  @override
  List<Object> get props => [status];
}

class MovieDetailHasData extends MovieState {
  final MovieDetail result;

  const MovieDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}
