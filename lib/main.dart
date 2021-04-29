import 'package:flutter/material.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/models/moviedb/PopularMoviesEntity.dart';
import 'package:movies_clean_arq_flutter/features/number_trivia/data/datasources/network/MovieApiService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  static const API_KEY = '7d51874568317dfd0c91db399be2bdec';
  static const IMAGE_URL = "https://image.tmdb.org/t/p/w342";
  String imageUrl;
  String path;

  PopularMoviesEntity popularMoviesOrTv;
  List<Result> listPopularMoviesOrTv;

  @override
  Widget build(BuildContext context) {
    getPopularMoviesOrTv();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 30,
                childAspectRatio: 1.8),
            itemCount: 20, //como hago para que me coja list.lenght
            itemBuilder: (_, int index) {
              imageUrl = IMAGE_URL + listPopularMoviesOrTv[index].backdropPath;

              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  getPopularMoviesOrTv() async {
    var service = MovieApiService.create();
    var responce = await service.getPopularMoviesOrTv('movie', API_KEY, 1);
    if (responce.isSuccessful) {
      popularMoviesOrTv = popularMoviesEntityFromJson(responce.bodyString);
      listPopularMoviesOrTv = popularMoviesOrTv.results;

      path = listPopularMoviesOrTv[0].backdropPath;
      print('Success' + responce.bodyString);
    } else {
      print('Error');
    }
  }
}
