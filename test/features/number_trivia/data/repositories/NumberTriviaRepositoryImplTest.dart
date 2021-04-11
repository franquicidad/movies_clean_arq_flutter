import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_clean_arq_flutter/core/platform/NetworkInfo.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/NumberTriviaLocalDatasource.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/NumberTriviaRemoteDatasource.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/models/NumberTriviaModel.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/repositories/NumberTriviaRepositoryImpl.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class MockRemoteDatasource extends Mock
    implements NumberTriviaRemoteDatasource {}

class MockLocalDatasource extends Mock implements NumberTriviaLocalDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl repositoryImpl;
  MockLocalDatasource mockLocalDatasource;
  MockRemoteDatasource mockRemoteDatasource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDatasource = MockRemoteDatasource();
    mockLocalDatasource = MockLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = NumberTriviaRepositoryImpl(
      remoteDatasource: mockRemoteDatasource,
      localDatasource: mockLocalDatasource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel(text: 'test trivia', number: tNumber);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test(
      'should check if the device is online',
      () async {
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        //act
        repositoryImpl.getConcreteNumberTrivia(tNumber);

        ///Flutter TDD Clean Arquitecture Course[6] Repository impl
        //assert
        verify(mockNetworkInfo.isConnected);
      },
    );
  });
}
