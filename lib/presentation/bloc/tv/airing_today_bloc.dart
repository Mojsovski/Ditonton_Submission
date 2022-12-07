// import 'package:ditonton/domain/entities/tv/tv.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:ditonton/domain/usecases/tv/get_airing_today_tvs.dart';

// part 'event/tv_event.dart';
// part 'state/tv_state.dart';

// class AiringTodayTvsBloc extends Bloc<TvEvent, TvState> {
//   final GetAiringTodayTvs _getAiringTodayTv;

//   AiringTodayTvsBloc(this._getAiringTodayTv) : super(TvLoading()) {
//     on<OnAiringTodayTv>((event, emit) async {
//       emit(TvLoading());
//       final result = await _getAiringTodayTv.execute();

//       result.fold(
//         (failure) => emit(TvError(failure.message)),
//         (data) => emit(TvHasData(data)),
//       );
//     });
//   }
// }
