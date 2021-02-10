import 'package:flutter/material.dart';

Container withDataEmpty() {
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