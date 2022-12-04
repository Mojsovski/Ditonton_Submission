import 'package:ditonton/domain/entities/tv/tv_episode.dart';
import 'package:equatable/equatable.dart';

class TvSeasonDetail extends Equatable {
  final String airDate;
  final List<TvEpisode> episodes;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;

  TvSeasonDetail({
    required this.airDate,
    required this.episodes,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  @override
  List<Object?> get props => [
        airDate,
        episodes,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}
