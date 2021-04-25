import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_clean_arq_flutter/core/error/exceptions.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/local/NumberTriviaLocalDatasource.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/models/NumberTriviaModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';
import '../../../../fixtures/fixtureReader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDatasourceImpl datasource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource = NumberTriviaLocalDatasourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test(
      'return NumberTriviaModel when there is one present in the cache',
      () async {
        //arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('trivia.json'));

        //act
        final result = await datasource.getLastNumberTrivia();

        //assert
        verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a cacheException when there is not a cached value',
      () async {
        //arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);

        //act
        final call = datasource.getLastNumberTrivia();

        //assert
        expect(() => call, throwsA(isA<CacheException>()));
      },
    );
  });
}
