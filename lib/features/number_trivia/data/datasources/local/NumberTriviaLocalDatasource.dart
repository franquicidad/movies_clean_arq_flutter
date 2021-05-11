import 'dart:convert';

import 'package:movies_clean_arq_flutter/core/error/exceptions.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/models/NumberTriviaModel.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/local/local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDatasourceImpl implements NumberTriviaLocalDatasource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDatasourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {}

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
