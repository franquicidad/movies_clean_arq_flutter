import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_clean_arq_flutter/core/error/failures.dart';
import 'package:movies_clean_arq_flutter/core/usecases/use_case.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/entities/ResultModel.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCases<ResultModel, NoParams> {
  final NumberTriviaRepository numberTriviaRepository;

  GetRandomNumberTrivia(this.numberTriviaRepository);
  @override
  Future<Either<Failure, ResultModel>> call(NoParams params) {
    return numberTriviaRepository.getRandomNumberTrivia();
  }
}
