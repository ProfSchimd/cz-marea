import 'package:flutter/material.dart';

import 'detail_page.dart';
import 'model.dart';

void main() {
  runApp(const SensorListPage());
}

class SensorListPage extends StatefulWidget {
  const SensorListPage({super.key});
  @override
  _SensorListState createState() => _SensorListState();
}

class _SensorListState extends State<SensorListPage> {
  List<Data> _data = [];

  Future<void> _getData() async {
    List<Data> data = await fetchDataList();
    setState(() {
      _data = data;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDataList()
        .then((data) => {
              setState(() {
                _data = data;
              })
            })
        .onError((error, stackTrace) => {
              setState(() {
                _data = [Data.dummyData(), Data.dummyData()];
              })
            });
  }

  void _tapped(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailPage(info: _data[index])));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Marea a Venezia')),
            body: RefreshIndicator(
              onRefresh: _getData,
              child: ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                    leading: const Icon(
                      Icons.water,
                      color: Colors.blue,
                    ),
                    trailing: Text(_data[index].valore,
                        style: TextStyle(
                            color: (_data[index].valoreDouble < 0.7)
                                ? Colors.green
                                : Colors.red)),
                    title: Text(
                      _data[index].stazione,
                      textAlign: TextAlign.left,
                    ),
                    onTap: () => _tapped(context, index),
                  ));
                },
              ),
            )));
  }
}
