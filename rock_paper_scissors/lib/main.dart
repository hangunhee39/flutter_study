import 'package:flutter/material.dart';

import 'game/game_body.dart';

void main() {
  runApp(const RSPApp());
}

class RSPApp extends StatelessWidget {
  const RSPApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Rock Scissors Paper!'),
        ),
        body: const GameBody(),
      ),
    );
  }
}
