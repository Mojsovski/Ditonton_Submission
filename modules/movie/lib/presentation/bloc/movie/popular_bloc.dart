import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/movie/get_popular_movies.dart';
import 'package:movie/presentation/bloc/movie/common/movie_event.dart';
import 'package:movie/presentation/bloc/movie/common/movie_state.dart';

class PopularMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(MovieLoading()) {
    on<OnPopularMovie>(
      (event, emit) async {
        emit(MovieLoading());
        final result = await _getPopularMovies.execute();

        result.fold(
          (failure) => emit(MovieError(failure.message)),
          (data) => emit(MovieHasData(data)),
        );
      },
    );
  }
}
