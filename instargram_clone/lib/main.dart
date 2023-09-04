import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const InstaCloneApp());
}

class InstaCloneApp extends StatelessWidget {
  const InstaCloneApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const InstaCloneHome(),
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Colors.white,
            secondary: Colors.black,
          ),
          useMaterial3: true),
    );
  }
}

class InstaCloneHome extends StatelessWidget {
  const InstaCloneHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Instagram',
          style: GoogleFonts.lobsterTwo(color: Colors.black, fontSize: 32),
        ),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {
                print('tab favorite');
              },
              icon: const Icon(Icons.favorite_outline, size: 32,)),
          IconButton(
              onPressed: () {
                print('tab paperplane');
              },
              icon: const Icon(CupertinoIcons.paperplane, size: 32,))
        ],
      ),
      body: InstaBody(),
    );
  }
}
