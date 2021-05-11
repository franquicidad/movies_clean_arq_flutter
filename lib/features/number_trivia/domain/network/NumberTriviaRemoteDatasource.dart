import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/models/moviedb/PopularMoviesEntity.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/entities/ResultModel.dart';

abstract class NumberTriviaRemoteDatasource {
  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Result> getPopularMoviesOrTv();
}
