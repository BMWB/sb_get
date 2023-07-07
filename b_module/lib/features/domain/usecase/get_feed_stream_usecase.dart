import 'package:dartz/dartz.dart';
import 'package:b_module/core/error/failures.dart';
import 'package:b_module/core/usecase/usecase.dart';
import 'package:b_module/features/domain/entities/feed_entity.dart';
import 'package:b_module/features/domain/repositories/repository.dart';

class GetFeedStreamUseCase extends UseCase<Stream<List<FeedEntity>>, NoParams> {
  final Repository _repository;

  GetFeedStreamUseCase(this._repository);

  @override
  Future<Either<Failure, Stream<List<FeedEntity>>>> call(NoParams params) {
    return _repository.getFeedStream();
  }
}
