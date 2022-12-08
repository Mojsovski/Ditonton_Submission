import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/presentation/bloc/movie/common/movie_event.dart';
import 'package:ditonton/presentation/bloc/movie/common/movie_state.dart';

class MovieRecommendationsBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRecommendations _getMovieRecommendations;

  MovieRecommendationsBloc(this._getMovieRecommendations)
      : super(MovieLoading()) {
    on<OnMovieRecommendations>((event, emit) async {
      final id = event.id;

      emit(MovieLoading());
      final result = await _getMovieRecommendations.execute(id);

      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
  }
}
