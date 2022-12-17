import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail.dart';
import 'package:tv/presentation/bloc/tv/common/tv_event.dart';
import 'package:tv/presentation/bloc/tv/common/tv_state.dart';

class TvDetailBloc extends Bloc<TvEvent, TvState> {
  final GetTvDetail _getTvDetail;

  TvDetailBloc(this._getTvDetail) : super(TvLoading()) {
    on<OnTvDetail>((event, emit) async {
      final id = event.id;

      emit(TvLoading());
      final result = await _getTvDetail.execute(id);

      result.fold(
        (failure) => emit(TvError(failure.message)),
        (data) => emit(TvDetailHasData(data)),
      );
    });
  }
}
