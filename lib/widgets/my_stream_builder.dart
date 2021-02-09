import 'package:flutter/material.dart';

StreamBuilder myStreamBuilder({
  @required BuildContext context,
  @required Stream stream,
  @required Widget onLoad,
  @required Widget withDataEmpty,
  @required Function(BuildContext, AsyncSnapshot<dynamic>) withValidData,
}) =>
    StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return onLoad;
        if (snapshot.data.length == 0)
          return withDataEmpty;
        else
          return withValidData(context,snapshot);
      },
    );
