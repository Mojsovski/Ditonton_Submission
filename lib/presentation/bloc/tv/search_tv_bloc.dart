import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ditonton/domain/usecases/tv/search_tvs.dart';
import 'package:ditonton/presentation/bloc/tv/common/tv_event.dart';
import 'package:ditonton/presentation/bloc/tv/common/tv_state.dart';

class SearchTvBloc extends Bloc<TvEvent, TvState> {
  final SearchTvs _searchTvs;

  SearchTvBloc(this._searchTvs) : super(TvEmpty()) {
    on<OnTvSearch>((event, emit) async {
      final query = event.query;

      emit(TvLoading());
      final result = await _searchTvs.execute(query);

      result.fold(
        (failure) {
          emit(TvError(failure.message));
        },
        (data) {
          emit(SearchTvHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
