import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:movies_clean_arq_flutter/core/error/exceptions.dart';
import 'package:movies_clean_arq_flutter/core/error/failures.dart';
import 'package:movies_clean_arq_flutter/core/network/NetworkInfo.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/models/moviedb/PopularMoviesEntity.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/local/local_datasource.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/network/NumberTriviaRemoteDatasource.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDatasource remoteDatasource;
  final NumberTriviaLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDatasource,
    @required this.localDatasource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, Result>> getConcreteNumberTrivia(int number) async {
    return await _getTrivia(
        () => remoteDatasource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, Result>> getRandomNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDatasource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, Result>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDatasource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDatasource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
