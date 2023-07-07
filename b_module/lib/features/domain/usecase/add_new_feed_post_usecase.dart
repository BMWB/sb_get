import 'package:dartz/dartz.dart';
import 'package:b_module/core/error/failures.dart';
import 'package:b_module/core/usecase/usecase.dart';
import 'package:b_module/features/domain/repositories/repository.dart';

class AddNewFeedPostUseCase extends UseCase<bool, AddNewFeedPostParams> {
  final Repository _repository;

  AddNewFeedPostUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(AddNewFeedPostParams params) {
    return _repository.addNewFeedPost(
        id: params.id,
        title: params.title,
        description: params.description,
        mediaPath: params.mediaPath);
  }
}

class AddNewFeedPostParams {
  final int id;
  final String title;
  final String description;
  final String mediaPath;

  AddNewFeedPostParams(
      {required this.id,
      required this.title,
      required this.description,
      required this.mediaPath});
}
