import 'package:rxdart/rxdart.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/common/movie_event.dart';
import 'package:ditonton/presentation/bloc/movie/common/movie_state.dart';

class SearchMovieBloc extends Bloc<MovieEvent, MovieState> {
  final SearchMovies _searchMovies;

  SearchMovieBloc(this._searchMovies) : super(MovieEmpty()) {
    on<OnMovieSearch>((event, emit) async {
      final query = event.query;

      emit(MovieLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(MovieError(failure.message));
        },
        (data) {
          emit(SearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
