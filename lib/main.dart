import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zuccante Maree',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Zuccante Maree'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Data> _data = [];
  // List<double>? _accelerometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  void _getData() async {
    List<Data> data = await fetchDataList();
    setState(() {
      _data = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            // _accelerometerValues = <double>[event.x, event.y, event.z];
            print(event.z);
            if (event.z.abs() > 2) {
              _getData();
            }
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child: Stack(
        children: <Widget>[
          Container(
              alignment: Alignment.bottomCenter,
              child: WaveWidget(
                config: CustomConfig(
                  colors: [
                    // tre onde dello stesso colore con trasparenza
                    Colors.teal.withOpacity(0.3),
                    Colors.teal.withOpacity(0.3),
                    Colors.teal.withOpacity(0.3),
                  ],
                  durations: [4000, 5000, 7000], // durata delle onde in ms
                  heightPercentages: [
                    0.01,
                    0.02,
                    0.005
                  ], // altezza in percentuale di ogni onda
                  blur: const MaskFilter.blur(
                      BlurStyle.solid, 3), // bordo dell'onda sfocato
                ),
                waveAmplitude: 10.00, //
                waveFrequency: 3, // number of curves in waves
                backgroundColor: Colors.white, // background colors
                size: Size(
                  double.infinity,
                  100 + (_data.isEmpty ? 0 : _data[0].valoreDouble * 200),
                ),
              )),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _data.isEmpty
                ? <Widget>[
                    Text('get data!',
                        style: TextStyle(
                            color: Colors.teal.shade700, fontSize: 40))
                  ]
                : <Widget>[
                    Text(_data[0].data,
                        style: TextStyle(
                            color: Colors.teal.shade700, fontSize: 30)),
                    Text(_data[0].stazione,
                        style: TextStyle(
                            color: Colors.teal.shade700, fontSize: 30)),
                    Text(_data[0].valore,
                        style: TextStyle(
                            color: Colors.teal.shade700, fontSize: 80)),
                  ],
          )),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _getData,
        tooltip: 'Increment',
        child: const Icon(Icons.arrow_downward),
      ),
    );
  }
}
