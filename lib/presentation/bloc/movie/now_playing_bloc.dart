// import 'package:ditonton/domain/entities/movie/movie.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:ditonton/domain/usecases/movie/search_movies.dart';

// part 'event/movie_event.dart';
// part 'state/movie_state.dart';

// class SearchMovieBloc extends Bloc<MovieEvent, SearchState> {
//   final SearchMovies _searchMovies;

//   SearchMovieBloc(this._searchMovies) : super(SearchEmpty()) {
//     on<OnMovieSearch>((event, emit) async {
//       final query = event.query;

//       emit(SearchLoading());
//       final result = await _searchMovies.execute(query);

//       result.fold(
//         (failure) {
//           emit(SearchError(failure.message));
//         },
//         (data) {
//           emit(SearchHasData(data));
//         },
//       );
//     }, transformer: debounce(const Duration(milliseconds: 500)));
//   }

//   EventTransformer<T> debounce<T>(Duration duration) {
//     return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
//   }
// }
