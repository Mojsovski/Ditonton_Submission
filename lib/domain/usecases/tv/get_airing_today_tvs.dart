import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:core/utils/failure.dart';

class GetAiringTodayTvs {
  final TvRepository repository;

  GetAiringTodayTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getAiringTodayTvs();
  }
}
