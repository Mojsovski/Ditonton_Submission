import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/tv/get_on_the_air_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/common/tv_event.dart';
import 'package:ditonton/presentation/bloc/tv/common/tv_state.dart';

class OnTheAirTvsBloc extends Bloc<TvEvent, TvState> {
  final GetOnTheAirTvs _getOnTheAirTvs;

  OnTheAirTvsBloc(this._getOnTheAirTvs) : super(TvLoading()) {
    on<OnTheAirTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getOnTheAirTvs.execute();

      result.fold(
        (failure) => emit(TvError(failure.message)),
        (data) => emit(TvHasData(data)),
      );
    });
  }
}
