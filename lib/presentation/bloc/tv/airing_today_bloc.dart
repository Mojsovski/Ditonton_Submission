import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/tv/get_airing_today_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/common/tv_event.dart';
import 'package:ditonton/presentation/bloc/tv/common/tv_state.dart';

class AiringTodayTvsBloc extends Bloc<TvEvent, TvState> {
  final GetAiringTodayTvs _getAiringTodayTvs;

  AiringTodayTvsBloc(this._getAiringTodayTvs) : super(TvLoading()) {
    on<OnAiringTodayTv>((event, emit) async {
      emit(TvLoading());
      final result = await _getAiringTodayTvs.execute();

      result.fold(
        (failure) => emit(TvError(failure.message)),
        (data) => emit(TvHasData(data)),
      );
    });
  }
}
