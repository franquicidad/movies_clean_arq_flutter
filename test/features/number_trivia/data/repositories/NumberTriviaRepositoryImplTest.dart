import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_clean_arq_flutter/core/error/exceptions.dart';
import 'package:movies_clean_arq_flutter/core/error/failures.dart';
import 'package:movies_clean_arq_flutter/core/network/NetworkInfo.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/local/NumberTriviaLocalDatasource.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/network/NumberTriviaRemoteDatasource.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/models/NumberTriviaModel.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/repositories/NumberTriviaRepositoryImpl.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/entities/number_trivia.dart';

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

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

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

    runTestsOnline(() {
      test(
        'should return remote data when the call to remoteDatasource is successfull',
        () async {
          //arrange
          when(mockRemoteDatasource.getConcreteNumberTrivia(any))
              .thenAnswer((_) async => tNumberTriviaModel);

          //act
          final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
          //assert
          verify(mockRemoteDatasource.getConcreteNumberTrivia(tNumber));
          expect(result, equals(Right(tNumberTrivia)));
        },
      );

      test(
        'should cache data locally when the call to remoteDatasource is successfull',
        () async {
          //arrange
          when(mockRemoteDatasource.getConcreteNumberTrivia(any))
              .thenAnswer((_) async => tNumberTriviaModel);

          //act
          await repositoryImpl.getConcreteNumberTrivia(tNumber);
          //assert
          verify(mockRemoteDatasource.getConcreteNumberTrivia(tNumber));
          verify(mockLocalDatasource.cacheNumberTrivia(tNumberTriviaModel));
        },
      );

      test(
        'should return server Failure when the call to remoteDatasource is unsuccessfull',
        () async {
          //arrange
          when(mockRemoteDatasource.getConcreteNumberTrivia(any))
              .thenThrow(ServerException());

          //act
          final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
          //assert
          verify(mockRemoteDatasource.getConcreteNumberTrivia(tNumber));
          verifyZeroInteractions(mockLocalDatasource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when there is cache data',
        () async {
          //arrange
          when(mockLocalDatasource.getLastNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);
          //act
          final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);

          //assert
          verifyZeroInteractions(mockRemoteDatasource);
          verify(mockLocalDatasource.getLastNumberTrivia());
          expect(result, equals(Right(tNumberTrivia)));
        },
      );

      test(
        'should return cache Failure when there is not cache data',
        () async {
          //arrange
          when(mockLocalDatasource.getLastNumberTrivia())
              .thenThrow(CacheException());
          //act
          final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);

          //assert
          verifyZeroInteractions(mockRemoteDatasource);
          verify(mockLocalDatasource.getLastNumberTrivia());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel(text: 'test trivia', number: 123);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;
    test(
      'should check if the device is online',
      () async {
        //arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        //act
        repositoryImpl.getRandomNumberTrivia();

        ///Flutter TDD Clean Arquitecture Course[6] Repository impl
        //assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remoteDatasource is successfull',
        () async {
          //arrange
          when(mockRemoteDatasource.getRandomNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);

          //act
          final result = await repositoryImpl.getRandomNumberTrivia();
          //assert
          verify(mockRemoteDatasource.getRandomNumberTrivia());
          expect(result, equals(Right(tNumberTrivia)));
        },
      );

      test(
        'should cache data locally when the call to remoteDatasource is successfull',
        () async {
          //arrange
          when(mockRemoteDatasource.getRandomNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);

          //act
          await repositoryImpl.getRandomNumberTrivia();
          //assert
          verify(mockRemoteDatasource.getRandomNumberTrivia());
          verify(mockLocalDatasource.cacheNumberTrivia(tNumberTriviaModel));
        },
      );

      test(
        'should return server Failure when the call to remoteDatasource is unsuccessfull',
        () async {
          //arrange
          when(mockRemoteDatasource.getRandomNumberTrivia())
              .thenThrow(ServerException());

          //act
          final result = await repositoryImpl.getRandomNumberTrivia();
          //assert
          verify(mockRemoteDatasource.getRandomNumberTrivia());
          verifyZeroInteractions(mockLocalDatasource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when there is cache data',
        () async {
          //arrange
          when(mockLocalDatasource.getLastNumberTrivia())
              .thenAnswer((_) async => tNumberTriviaModel);
          //act
          final result = await repositoryImpl.getRandomNumberTrivia();

          //assert
          verifyZeroInteractions(mockRemoteDatasource);
          verify(mockLocalDatasource.getLastNumberTrivia());
          expect(result, equals(Right(tNumberTrivia)));
        },
      );

      test(
        'should return cache Failure when there is not cache data',
        () async {
          //arrange
          when(mockLocalDatasource.getLastNumberTrivia())
              .thenThrow(CacheException());
          //act
          final result = await repositoryImpl.getRandomNumberTrivia();

          //assert
          verifyZeroInteractions(mockRemoteDatasource);
          verify(mockLocalDatasource.getLastNumberTrivia());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
