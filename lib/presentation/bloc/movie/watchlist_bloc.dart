import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies_status.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/common/movie_event.dart';
import 'package:ditonton/presentation/bloc/movie/common/movie_state.dart';

class WatchlistMoviesBloc extends Bloc<MovieEvent, MovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistMoviesBloc(
    this._getWatchlistMovies,
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(MovieLoading()) {
    on<OnWatchlistMovies>((event, emit) async {
      emit(MovieLoading());

      final result = await _getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieHasData(data)),
      );
    });
    on<OnWatchlistMovieStatus>((event, emit) async {
      final id = event.id;
      emit(MovieLoading());

      final result = await _getWatchListStatus.execute(id);
      emit(MovieWatchlistStatus(result));
    });
    on<OnSaveWatchlistMovie>((event, emit) async {
      final movie = event.movieDetail;
      emit(MovieLoading());

      final result = await _saveWatchlist.execute(movie);
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieWatchlistMessage(data)),
      );
    });
    on<OnRemoveWatchlistMovie>((event, emit) async {
      final movie = event.movieDetail;
      emit(MovieLoading());

      final result = await _removeWatchlist.execute(movie);
      result.fold(
        (failure) => emit(MovieError(failure.message)),
        (data) => emit(MovieWatchlistMessage(data)),
      );
    });
  }
}
