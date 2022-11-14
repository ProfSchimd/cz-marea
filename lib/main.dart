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

  // void _getData() async {
  //   List<Data> data = await fetchDataList();
  //   setState(() {
  //     _data = data;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    fetchDataList().then((data) => {
          setState(() {
            _data = data;
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
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _data[index].stazione,
              textAlign: TextAlign.center,
            ),
            onTap: () => _tapped(context, index),
          );
        },
      ),
    ));
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'CZ Marea',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//       ),
//       home: const MyHomePage(title: 'CZ Marea'),
//       // home: const StationList(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<Data> _data = [];
//   final _streamSubscriptions = <StreamSubscription<dynamic>>[];

//   void _getData() async {
//     List<Data> data = await fetchDataList();
//     setState(() {
//       _data = data;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _streamSubscriptions.add(
//       accelerometerEvents.listen(
//         (AccelerometerEvent event) {
//           setState(() {
//             if (event.z.abs() > 2) {
//               _getData();
//             }
//           });
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     for (final subscription in _streamSubscriptions) {
//       subscription.cancel();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//           child: Stack(
//         children: <Widget>[
//           Container(
//               alignment: Alignment.bottomCenter,
//               child: WaveWidget(
//                 config: CustomConfig(
//                   colors: [
//                     // tre onde dello stesso colore con trasparenza
//                     Colors.teal.withOpacity(0.3),
//                     Colors.teal.withOpacity(0.3),
//                     Colors.teal.withOpacity(0.3),
//                   ],
//                   durations: [4000, 5000, 7000], // durata delle onde in ms
//                   heightPercentages: [
//                     0.01,
//                     0.02,
//                     0.005
//                   ], // altezza in percentuale di ogni onda
//                   blur: const MaskFilter.blur(
//                       BlurStyle.solid, 3), // bordo dell'onda sfocato
//                 ),
//                 waveAmplitude: 10.00, //
//                 waveFrequency: 3, // number of curves in waves
//                 backgroundColor: Colors.white, // background colors
//                 size: Size(
//                   double.infinity,
//                   100 + (_data.isEmpty ? 0 : _data[0].valoreDouble * 200),
//                 ),
//               )),
//           Center(
//               child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: _data.isEmpty
//                 ? <Widget>[
//                     const CircularProgressIndicator(
//                       value: null,
//                       semanticsLabel: 'Circular progress indicator',
//                     ),
//                   ]
//                 : <Widget>[
//                     Text(_data[0].data,
//                         style: TextStyle(
//                             color: Colors.teal.shade700, fontSize: 30)),
//                     Text(_data[0].stazione,
//                         style: TextStyle(
//                             color: Colors.teal.shade700, fontSize: 30)),
//                     Text(_data[0].valore,
//                         style: TextStyle(
//                             color: Colors.teal.shade700, fontSize: 80)),
//                   ],
//           )),
//         ],
//       )),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _getData,
//         tooltip: 'Increment',
//         child: const Icon(Icons.arrow_downward),
//       ),
//     );
//   }
// }
