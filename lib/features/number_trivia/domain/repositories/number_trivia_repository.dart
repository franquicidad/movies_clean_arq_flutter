import 'package:dartz/dartz.dart';
import 'package:movies_clean_arq_flutter/core/error/failures.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/entities/ResultModel.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, ResultModel>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, ResultModel>> getRandomNumberTrivia();
}
