import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/movie.dart';

class MovieStateFake extends Fake implements MovieState {}

class MovieEventFake extends Fake implements MovieEvent {}

class MockNowPlayingMoviesBloc extends MockBloc<MovieEvent, MovieState>
    implements NowPlayingMoviesBloc {}

class MockPopularMoviesBloc extends MockBloc<MovieEvent, MovieState>
    implements PopularMoviesBloc {}

class MockTopRatedMoviesBloc extends MockBloc<MovieEvent, MovieState>
    implements TopRatedMoviesBloc {}

class MockMovieDetailBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieDetailBloc {}

class MockMovieRecommendationsBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieRecommendationsBloc {}

class MockWatchlistMoviesBloc extends MockBloc<MovieEvent, MovieState>
    implements WatchlistMoviesBloc {}
