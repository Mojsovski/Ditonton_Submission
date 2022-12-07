import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/common/tv_event.dart';
import 'package:ditonton/presentation/bloc/tv/common/tv_state.dart';

class TopRatedTvsBloc extends Bloc<TvEvent, TvState> {
  final GetTopRatedTvs _getTopRatedTvs;

  TopRatedTvsBloc(this._getTopRatedTvs) : super(TvLoading()) {
    on<OnTopRatedTv>(
      (event, emit) async {
        emit(TvLoading());
        final result = await _getTopRatedTvs.execute();

        result.fold(
          (failure) => emit(TvError(failure.message)),
          (data) => emit(TvHasData(data)),
        );
      },
    );
  }
}
