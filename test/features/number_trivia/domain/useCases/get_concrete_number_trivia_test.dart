import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/useCases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia getConcreteNumberTriviaUseCase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    getConcreteNumberTriviaUseCase =
        GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final numberTrivia = NumberTrivia(text: 'text', number: 1);
  final tNumber = 1;
  test(
    'get trivia from the number in the repo',
    () async {
      //arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(numberTrivia));
      //act
      final result =
          await getConcreteNumberTriviaUseCase(Params(number: tNumber));
      //assert
      expect(result, Right(numberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
