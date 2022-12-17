import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie/common/movie_event.dart';
import 'package:movie/presentation/bloc/movie/common/movie_state.dart';

class TopRatedMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(MovieLoading()) {
    on<OnTopRatedMovie>(
      (event, emit) async {
        emit(MovieLoading());
        final result = await _getTopRatedMovies.execute();

        result.fold(
          (failure) => emit(MovieError(failure.message)),
          (data) => emit(MovieHasData(data)),
        );
      },
    );
  }
}
