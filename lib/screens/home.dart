import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rocket_movies/blocs/home_bloc.dart';
import 'package:rocket_movies/widgets/my_stream_builder.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /* Declaration of variables*/
  final HomeBloc bloc = HomeBloc();

  /* On initiate the screen run a query to get the list of movies */
  @override
  void initState() {
    bloc.getMovies();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
        drawer: Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width - 50,
          height: MediaQuery.of(context).size.height,
        ),
        appBar: AppBar(title: Text('Rocket Movies')),
        body: myStreamBuilder(
          context: context,
          stream: bloc.movies,
          // Show a progress indicator
          onLoad: Center(child: CircularProgressIndicator()),
          // Show a message explaining that don't have any movie close to release
          withValidData: (context, snapshot) {
            final List results = snapshot.data["results"];
            return Container(
              child: Container(
                height: double.infinity,
                child: ListView.separated(
                  padding: EdgeInsets.all(10),
                    itemCount: snapshot.data.length,
                    separatorBuilder: (context, index) => SizedBox(height: 5),
                    itemBuilder: (context, index) => buildCard(
                          title: results[index]["title"].toString(),
                          overview: results[index]["overview"].toString(),
                          vote: double.parse(
                                  results[index]["vote_average"].toString())
                              .toStringAsFixed(1)
                              .toString()
                              .replaceAll('.', ','),
                          releaseDt: results[index]["release_date"].toString(),
                          posterPath: results[index]["poster_path"].toString(),
                        )),
              ),
            );
          },
          withDataEmpty: buildWithDataEmpty(),
        ));
  }

  buildCard(
          {String title,
          String overview,
          String vote,
          String releaseDt,
          String posterPath}) =>
      Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        child: Container(
          height: 130,
          width: double.infinity,
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              Container(
                width: 85,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w185/$posterPath',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text.rich(
                            TextSpan(
                              text: '$vote',
                              children: [
                                TextSpan(
                                    text: '/10',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                    ))
                              ],
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          overview,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      child: Text.rich(
                        TextSpan(text: 'Lançamento: ', children: [
                          TextSpan(
                              text: '$releaseDt',
                              style: TextStyle(fontWeight: FontWeight.normal))
                        ]),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      );

  Container buildWithDataEmpty() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: 80,
          child: Card(
            child: Center(
                child:
                    Text('Não há de novos lançamentos para serem exibidos!')),
          ),
        ),
      ),
    );
  }
}
