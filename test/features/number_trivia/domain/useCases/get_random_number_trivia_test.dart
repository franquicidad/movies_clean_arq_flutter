import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_clean_arq_flutter/core/usecases/use_case.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/useCases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia getRandomNumberTriviaUseCase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    getRandomNumberTriviaUseCase =
        GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final numberTrivia = NumberTrivia(text: 'text', number: 1);
  test(
    'get trivia from repository',
    () async {
      //arrange
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => Right(numberTrivia));
      //act
      final result = await getRandomNumberTriviaUseCase(NoParams());
      //assert
      expect(result, Right(numberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
