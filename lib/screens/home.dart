import 'package:flutter/material.dart';
import 'package:rocket_movies/blocs/home_bloc.dart';
import 'package:rocket_movies/utils/utils.dart';
import 'package:rocket_movies/widgets/my_stream_builder.dart';
import 'package:rocket_movies/widgets/with_data_empty.dart';
import 'details.dart';

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
          alignment: Alignment.topCenter,
          color: Colors.blue,
          width: MediaQuery.of(context).size.width - 50,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                height: 200,
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey, shape: BoxShape.circle),
                      margin: EdgeInsets.all(10),
                      height: 80,
                      width: 80,
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text.rich(
                        TextSpan(text:'Rocket Movies\n',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(text: 'by André Ervilha',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12))
                          ]
                        )
                      ),
                    ))
                  ],
                ),
              ),
              Expanded(child: Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.bottomCenter,
                child: Text('v1.0',style: TextStyle(color: Colors.white),),
              ))
            ],
          ),
        ),
        appBar: AppBar(title: Text('Rocket Movies')),
        body: myStreamBuilder(
          context: context,
          stream: bloc.movies,
          // Show a progress indicator
          onLoad: Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white))),
          // Show a message explaining that don't have any movie close to release
          withValidData: buildWithValidData,
          withDataEmpty: withDataEmpty(),
        ));
  }

  void increasePagination() {
    bloc.increasePagination();
  }

  void decreasePagination() {
    bloc.decreasePagination();
  }

  buildWithValidData(context, snapshot) {
    final List results = snapshot.data["results"];
    return Column(
      children: [
        Expanded(
          child: Container(
            child: Container(
              height: double.infinity,
              child: ListView.separated(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  itemBuilder: (context, index) => buildCard(
                        id: results[index]["id"],
                        title: results[index]["title"].toString(),
                        overview: results[index]["overview"].toString(),
                        vote: double.parse(
                                results[index]["vote_average"].toString())
                            .toStringAsFixed(1)
                            .toString()
                            .replaceAll('.', ','),
                        releaseDt: date2br(results[index]["release_date"].toString()),
                        posterPath: results[index]["poster_path"].toString(),
                      )),
            ),
          ),
        ),
        Divider(height: 10),
        Container(
            color: Colors.blue,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: RaisedButton(
                          color: Colors.blueGrey,
                          disabledColor: Colors.blueGrey.shade200,
                          child: Text('Anterior',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: snapshot.data['page'] == 1
                              ? null
                              : decreasePagination,
                        ))),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  alignment: Alignment.center,
                  child: Text(
                      '${snapshot.data['page']}/${snapshot.data['total_pages']}'),
                ),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: RaisedButton(
                          color: Colors.blueGrey,
                          disabledColor: Colors.blueGrey.shade200,
                          child: Text('próximo',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: snapshot.data['total_pages'] ==
                                  snapshot.data['page']
                              ? null
                              : increasePagination,
                        )))
              ],
            ))
      ],
    );
  }

  buildCard(
          {int id,
          String title,
          String overview,
          String vote,
          String releaseDt,
          String posterPath}) =>
      Card(
        elevation: 2,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: Material(
          child: InkWell(
            splashColor: Colors.blueGrey.shade200,
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Details(id)));
            },
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
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
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
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal))
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
          ),
        ),
      );
}
