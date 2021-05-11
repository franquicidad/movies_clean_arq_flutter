import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      home: MyHomePage(title: 'MoviesDb'),
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

  static const API_KEY = '7d51874568317dfd0c91db399be2bdec';
  static const IMAGE_URL = "https://image.tmdb.org/t/p/w342";

  String imageUrl;
  String movieName;
  String path;

  PopularMoviesEntity popularMoviesOrTv = null;
  List<Result> listPopularMoviesOrTv = [];
  @override
  void initState() {
    super.initState();
    getPopularMoviesOrTv();
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    getPopularMoviesOrTv();
  }

  @override
  Widget build(BuildContext context) {
    final double Height = MediaQuery.of(context).size.height;
    final double Width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        leading: Icon(Icons.article),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Popular',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite')
        ],
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: (Width / 2) / (Height * 0.3)),
            itemCount: listPopularMoviesOrTv.length,
            itemBuilder: (_, int index) {
              imageUrl = IMAGE_URL + listPopularMoviesOrTv[index].backdropPath;
              movieName = listPopularMoviesOrTv[index].originalTitle;

              return Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: 10,
                  child: Center(
                    child: Text(
                      '$movieName',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        letterSpacing: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ]);
            },
          ),
        ),
      ),
    );
  }
}
