import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/models/moviedb/PopularMoviesEntity.dart'as Network;
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/entities/ResultModel.dart' as Domain;

extension ToDomain on Network.Result{
  Domain.ResultModel toDomain(){
    return Domain.ResultModel( Network.PopularMoviesEntity.)
  }

}