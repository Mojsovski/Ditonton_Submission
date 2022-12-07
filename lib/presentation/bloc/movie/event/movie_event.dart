part of '../search_movie_bloc.dart';

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

