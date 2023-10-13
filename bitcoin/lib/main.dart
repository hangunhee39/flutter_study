import 'dart:convert';

import 'package:bitcoin/widget/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:live_background/live_background.dart';
import 'package:live_background/object/particle_shape_type.dart';
import 'package:live_background/widget/live_background_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:web_socket_channel/io.dart';

import 'widget/animated_number_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MainScreenState();
}

class MainScreenState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitcoin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //WebSocket  받기
  final wsUrl = Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@trade');
  late final channel = IOWebSocketChannel.connect(wsUrl);
  late final Stream<dynamic> stream;

  String text = "Loading";
  final List<double> priceList = [];

  final intervalDuration = 1.seconds;
  DateTime lastUpdatedTime = DateTime.now();

  @override
  void initState() {
    stream = channel.stream;
    stream.listen((event) {
      //Map 으로 반환
      final obj = json.decode(event);
      final double price = double.parse(obj['p']); //string -> double
      //1초에 한번 text 바꾸기
      if (DateTime.now().difference(lastUpdatedTime) > intervalDuration) {
        lastUpdatedTime = DateTime.now();
        //UI 바꾸기
        setState(() {
          priceList.add(price);
          text = price.toDoubleStringAsFixed();
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          const LiveBackgroundWidget(
            shape:ParticleShapeType.square,
            velocityY: -7,
            particleMinSize: 5,
            particleMaxSize: 20,
            particleCount: 2000,
            palette: Palette(
              colors:[
                Color(0xffd3ff8c),
                Color(0xffffcc37)

              ]
            ),
          ),

          SafeArea(
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedNumberText(
                  text,
                  textStyle:
                      const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  duration: 50.milliseconds,
                ),
                LineChartWidget(priceList, priceList[0]),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
