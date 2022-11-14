import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'model.dart';

class DetailPage extends StatelessWidget {
  final Data info;
  const DetailPage({super.key, required this.info});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(info.stazione),
        ),
        body: Center(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage((MediaQuery.of(context).orientation ==
                              Orientation.portrait)
                          ? "assets/bg_portrait.jpg"
                          : "assets/bg_landscape.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.45), BlendMode.dstATop)),
                ),
                alignment: Alignment.bottomCenter,
                child: WaveWidget(
                  config: CustomConfig(colors: [
                    Colors.blue.withAlpha(75),
                    Colors.blue.withAlpha(75),
                    Colors.blue.withAlpha(75),
                  ], durations: [
                    8000,
                    5000,
                    12000
                  ], heightPercentages: [
                    0.01,
                    0.02,
                    0.03
                  ], blur: const MaskFilter.blur(BlurStyle.solid, 3)),
                  waveAmplitude: 20,
                  size: Size(
                      double.infinity,
                      info.valoreDouble *
                          (MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 300
                              : 150)),
                  // waveAmplitude: 0,
                ),
              ),
              Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text(info.stazione,
                        style: Theme.of(context).textTheme.headlineMedium),
                    Text(info.data,
                        style: Theme.of(context).textTheme.headlineSmall),
                    Text(info.valore,
                        style: Theme.of(context).textTheme.displayMedium),
                  ])),
            ],
          ),
        ));
  }
}
