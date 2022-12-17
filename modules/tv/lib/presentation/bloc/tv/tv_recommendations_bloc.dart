import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:tv/presentation/bloc/tv/common/tv_event.dart';
import 'package:tv/presentation/bloc/tv/common/tv_state.dart';

class TvRecommendationsBloc extends Bloc<TvEvent, TvState> {
  final GetTvRecommendations _getTvRecommendations;

  TvRecommendationsBloc(this._getTvRecommendations) : super(TvLoading()) {
    on<OnTvRecommendations>((event, emit) async {
      final id = event.id;

      emit(TvLoading());
      final result = await _getTvRecommendations.execute(id);

      result.fold(
        (failure) => emit(TvError(failure.message)),
        (data) => emit(TvHasData(data)),
      );
    });
  }
}
