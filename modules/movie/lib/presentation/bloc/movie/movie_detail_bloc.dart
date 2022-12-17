import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/usecases/movie/get_movie_detail.dart';
import 'package:movie/presentation/bloc/movie/common/movie_event.dart';
import 'package:movie/presentation/bloc/movie/common/movie_state.dart';

class MovieDetailBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetail _getMovieDetail;

  MovieDetailBloc(this._getMovieDetail) : super(MovieLoading()) {
    on<OnMovieDetail>((event, emit) async {
      final id = event.id;

      emit(MovieLoading());
      final result = await _getMovieDetail.execute(id);

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieDetailHasData(data)),
      );
    });
  }
}
