import 'package:ditonton/data/models/tv/tv_season_model.dart';
import 'package:ditonton/domain/entities/tv/tv_season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeasonModel = TvSeasonModel(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  final tTvSeasonModelJson = {
    'air_date': 'airDate',
    'episode_count': 1,
    'id': 1,
    'name': 'name',
    'overview': 'overview',
    'poster_path': 'posterPath',
    'season_number': 1,
  };

  final tTvSeason = TvSeason(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  test('should be json form TvSeasonModel', () async {
    final result = tTvSeasonModel.toJson();
    expect(result, tTvSeasonModelJson);
  });

  test('should be entitiy TvSeason form TvSeasonModel', () async {
    final result = tTvSeasonModel.toEntity();
    expect(result, tTvSeason);
  });
}
