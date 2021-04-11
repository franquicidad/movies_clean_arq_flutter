import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/models/NumberTriviaModel.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixtureReader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: "Test Text");
  test(
    'should be a subclass of Number trivia entity',
    () async {
      //assert
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        //arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia.json'));
        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        //assert
        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'should return a valid model when the JSON number is regarded as a Double',
      () async {
        //arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('triviaDouble.json'));
        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        //assert
        expect(result, tNumberTriviaModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper Data',
      () async {
        //act
        final result = tNumberTriviaModel.toJson();
        //assert
        final expectedMap = {
          "text": "Test Text",
          "number": 1,
        };
        expect(result, expectedMap);
      },
    );
  });
}
