import 'package:flutter/material.dart';

import 'model.dart';

class StationList extends StatefulWidget {
  const StationList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StationListState();
}

class _StationListState extends State<StationList> {
  List<Data> _data = [];

  @override
  Widget build(BuildContext context) {
    return ListView(children: const <Widget>[
      Text('1'),
      Text('2'),
    ]);
  }
}
