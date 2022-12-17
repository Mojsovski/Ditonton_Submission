import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie/movie_detail.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class OnMovieSearch extends MovieEvent {
  final String query;

  OnMovieSearch(this.query);

  @override
  List<Object> get props => [query];
}

class OnNowPlayingMovie extends MovieEvent {}

class OnPopularMovie extends MovieEvent {}

class OnTopRatedMovie extends MovieEvent {}

class OnWatchlistMovies extends MovieEvent {}

class OnWatchlistMovieStatus extends MovieEvent {
  final int id;
  const OnWatchlistMovieStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnSaveWatchlistMovie extends MovieEvent {
  final MovieDetail movieDetail;
  const OnSaveWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnRemoveWatchlistMovie extends MovieEvent {
  final MovieDetail movieDetail;
  const OnRemoveWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnMovieDetail extends MovieEvent {
  final int id;
  const OnMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnMovieRecommendations extends MovieEvent {
  final int id;
  const OnMovieRecommendations(this.id);

  @override
  List<Object> get props => [id];
}
