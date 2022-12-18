import 'package:tv/tv.dart';
import 'package:core/core.dart';

final testTv = Tv(
  backdropPath: 'backdropPath',
  genreIds: [1, 2],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: 'posterPath',
  firstAirDate: 'firstAirDate',
  name: 'name',
  voteAverage: 1.0,
  voteCount: 1,
);

final testTvList = [testTv];

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvDetail = TvDetail(
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  seasons: [],
  firstAirDate: 'firstAirDate',
  episodeRuntime: [1, 2],
  name: 'name',
  numberOfEpisodes: 12,
  numberOfSessions: 1,
  voteAverage: 1.0,
  voteCount: 1,
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
