import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:movie/presentation/bloc/movie/common/movie_event.dart';
import 'package:movie/presentation/bloc/movie/common/movie_state.dart';

class NowPlayingMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies) : super(MovieLoading()) {
    on<OnNowPlayingMovie>((event, emit) async {
      emit(MovieLoading());
      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
  }
}
