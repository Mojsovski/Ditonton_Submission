import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/common/tv_event.dart';
import 'package:ditonton/presentation/bloc/tv/common/tv_state.dart';

class PopularTvsBloc extends Bloc<TvEvent, TvState> {
  final GetPopularTvs _getPopularTvs;

  PopularTvsBloc(this._getPopularTvs) : super(TvLoading()) {
    on<OnPopularTv>(
      (event, emit) async {
        emit(TvLoading());
        final result = await _getPopularTvs.execute();

        result.fold(
          (failure) => emit(TvError(failure.message)),
          (data) => emit(TvHasData(data)),
        );
      },
    );
  }
}
