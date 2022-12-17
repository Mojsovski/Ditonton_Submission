import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:tv/domain/usecases/tv/get_watchlist_tvs_status.dart';
import 'package:tv/domain/usecases/tv/save_watchlist_tvs.dart';
import 'package:tv/domain/usecases/tv/remove_watchlist_tvs.dart';
import 'package:tv/presentation/bloc/tv/common/tv_event.dart';
import 'package:tv/presentation/bloc/tv/common/tv_state.dart';

class WatchlistTvsBloc extends Bloc<TvEvent, TvState> {
  final GetWatchlistTvs _getWatchlistTvs;
  final GetWatchListTvStatus _getWatchListStatus;
  final SaveWatchlistTv _saveWatchlist;
  final RemoveWatchlistTv _removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistTvsBloc(
    this._getWatchlistTvs,
    this._getWatchListStatus,
    this._saveWatchlist,
    this._removeWatchlist,
  ) : super(TvLoading()) {
    on<OnWatchlistTvs>((event, emit) async {
      emit(TvLoading());

      final result = await _getWatchlistTvs.execute();
      result.fold(
        (failure) => emit(TvError(failure.message)),
        (data) => emit(TvHasData(data)),
      );
    });
    on<OnWatchlistTvStatus>((event, emit) async {
      final id = event.id;
      emit(TvLoading());

      final result = await _getWatchListStatus.execute(id);
      emit(TvWatchlistStatus(result));
    });
    on<OnSaveWatchlistTv>((event, emit) async {
      final tv = event.tvDetail;
      emit(TvLoading());

      final result = await _saveWatchlist.execute(tv);
      result.fold(
        (failure) => emit(TvError(failure.message)),
        (data) => emit(TvWatchlistMessage(data)),
      );
    });
    on<OnRemoveWatchlistTv>((event, emit) async {
      final tv = event.tvDetail;
      emit(TvLoading());

      final result = await _removeWatchlist.execute(tv);
      result.fold(
        (failure) => emit(TvError(failure.message)),
        (data) => emit(TvWatchlistMessage(data)),
      );
    });
  }
}
