// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MovieApiService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$MovieApiService extends MovieApiService {
  _$MovieApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = MovieApiService;

  Future<Response> getPopularMoviesOrTv(
      String movieOrTv, String api_key, int page) {
    final $url = '/${movieOrTv}/popular';
    final Map<String, dynamic> $params = {'api_key': api_key, 'page': page};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}
