import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rocket_movies/blocs/details_bloc.dart';
import 'package:rocket_movies/utils/utils.dart';
import 'package:rocket_movies/widgets/my_stream_builder.dart';
import 'package:rocket_movies/widgets/with_data_empty.dart';

class Details extends StatefulWidget {
  /* Local variables */
  final int id;

  /* Constructor */
  Details(this.id);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final DetailsBloc bloc = DetailsBloc();

  @override
  void initState() {
    bloc.getDetails(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes do filme')),
      body: Container(
        color: Colors.black,
        child: myStreamBuilder(
          context: context,
          stream: bloc.details,
          onLoad: Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white)),
          ),
          withDataEmpty: withDataEmpty(),
          withValidData: buildWithValidData,
        ),
      ),
    );
  }

  buildWithValidData(context, snapshot) {
    final Map results = snapshot.data;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.3, 1],
                    colors: [Colors.blueGrey.shade600, Colors.black])),
            padding: EdgeInsets.all(10),
            height: 300,
            width: double.infinity,
            child: Image.network(
              'https://image.tmdb.org/t/p/w185/${results['poster_path'].toString()}',
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.3, 1],
                    colors: [Colors.black, Colors.blueGrey.shade900])),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildHeader(results),
                buildDetails(results),
                buildProductionCredits(results)
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildHeader(Map results) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(results['title'],
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('nota: ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Text.rich(TextSpan(
                      text: '${results['vote_average']}',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '/10',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 16))
                      ])))
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text.rich(
                TextSpan(text: 'Data de lançamento: ', children: [
                  TextSpan(
                      text: '${date2br(results['release_date'])}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 18))
                ]),
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          )
        ],
      ),
    );
  }

  Container buildDetails(results) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Generos',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              )),
          Container(
            constraints: BoxConstraints(minHeight: 0,maxHeight: 200),
            width: double.infinity,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                  results['genres'].length,
                  (index) => Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Text(
                        '${results['genres'][index]['name']}',
                        style: TextStyle(color: Colors.white),
                      ))),
            ),
          ),
          SizedBox(height: 5),
          Container(
              child: Text(results['overview'],
                  maxLines: 15,
                  style: TextStyle(
                      color: Colors.white, fontSize: 16, height: 1.5))),
        ],
      ),
    );
  }

  Container buildProductionCredits(results) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Produção',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Container(
            color: Colors.white,
            height: 50,
            child: ListView(
              padding: EdgeInsets.all(10),
              scrollDirection: Axis.horizontal,
              children: List.generate(results['production_companies'].length,
                  (index) {
                List companies = results['production_companies'];
                bool error = companies[index]['logo_path'].toString() == 'null';
                return Container(
                  constraints: BoxConstraints(minWidth: 0, maxWidth: error?0:100),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                    child: error
                        ? Container()
                        : Image.network(
                            'https://image.tmdb.org/t/p/w185/${results['production_companies'][index]['logo_path']}'));
              }),
            ),
          )
        ],
      ),
    );
  }
}
