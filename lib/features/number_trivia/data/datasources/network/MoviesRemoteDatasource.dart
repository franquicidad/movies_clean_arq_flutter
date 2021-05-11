import 'package:movies_clean_arq_flutter/Utils.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/models/moviedb/PopularMoviesEntity.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/network/MovieApiService.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/entities/ResultModel.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/network/NumberTriviaRemoteDatasource.dart';

class MoviesRemoteDatasource implements NumberTriviaRemoteDatasource {
  @override
  Future<ResultModel> getPopularMoviesOrTv() async {
    var result = await MovieApiService.create()
        .getPopularMoviesOrTv('movie', API_KEY, 1);
    return PopularMoviesEntity.fromJson(result.body);
  }
}
