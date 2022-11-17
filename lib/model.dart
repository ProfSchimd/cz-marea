import 'dart:convert';
import 'package:http/http.dart' as http;

var url = Uri.parse(
    'http://dati.venezia.it/sites/default/files/dataset/opendata/livello.json');

Future<List<Data>> fetchDataList() async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);
    return parsed.map<Data>((json) => Data.fromJson(json)).toList();
  } else {
    throw Exception('Failed to get Data');
  }
}

class Data {
  final String ordine;
  final String idStazione;
  final String stazione;
  final String nomeAbbr;
  final String latDMSN;
  final String lonDMSE;
  final String latDDN;
  final String lonDDE;
  final String data;
  final String valore;

  Data(
      {required this.ordine,
      required this.idStazione,
      required this.stazione,
      required this.nomeAbbr,
      required this.latDMSN,
      required this.lonDMSE,
      required this.latDDN,
      required this.lonDDE,
      required this.data,
      required this.valore});

  // getter
  double get valoreDouble => double.parse(valore.split(' ')[0]);

  // a factory named constructor
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        ordine: json['ordine'] as String,
        idStazione: json['ID_stazione'] as String,
        stazione: json['stazione'] as String,
        nomeAbbr: json['nome_abbr'] as String,
        latDMSN: json['latDMSN'] as String,
        lonDMSE: json['lonDMSE'] as String,
        latDDN: json['latDDN'] as String,
        lonDDE: json['lonDDE'] as String,
        data: json['data'] as String,
        valore: json['valore'] as String);
  }
}
