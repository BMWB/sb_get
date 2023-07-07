import 'package:dartz/dartz.dart';
import 'package:b_module/core/error/failures.dart';
import 'package:b_module/core/usecase/usecase.dart';
import 'package:b_module/features/domain/entities/feed_entity.dart';
import 'package:b_module/features/domain/repositories/repository.dart';

class GetFeedsUseCase extends UseCase<List<FeedEntity>, NoParams> {
  final Repository _repository;

  GetFeedsUseCase(this._repository);

  @override
  Future<Either<Failure, List<FeedEntity>>> call(NoParams params) {
    return _repository.getFeeds();
  }
}
