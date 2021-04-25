import 'package:chopper/chopper.dart';

part "MovieApiService.chopper.dart";

@ChopperApi()
abstract class MovieApiService extends ChopperService {
  @Get(path: '/{movie_or_tv}/popular')
  Future<Response> getPopularMoviesOrTv(@Path('movie_or_tv') String movieOrTv,
      @Query('api_key') String api_key, @Query('page') int page);

  static MovieApiService create() {
    final client = ChopperClient(
        baseUrl: 'https://api.themoviedb.org/3',
        converter: JsonConverter(),
        services: [_$MovieApiService()]);
    return _$MovieApiService(client);
  }
}
