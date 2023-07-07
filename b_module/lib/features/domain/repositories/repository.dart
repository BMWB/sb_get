import 'package:dartz/dartz.dart';
import 'package:b_module/core/error/failures.dart';
import 'package:b_module/features/domain/entities/feed_entity.dart';

abstract class Repository {
  /// Function to get list of feeds
  Future<Either<Failure, Stream<List<FeedEntity>>>> getFeedStream();

  /// Function to add new feed post
  Future<Either<Failure, bool>> addNewFeedPost(
      {required final int id,
      required final String title,
      required final String description,
      required final String mediaPath});

  Future<Either<Failure, List<FeedEntity>>> getFeeds();
}
