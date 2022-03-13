// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'board.dart';
import 'large_board.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(SlidingPuzzle());
}

class SlidingPuzzle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.dark,
    primaryColor: Colors.black,


    ),
      title: "Sliding Puzzle",
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: LayoutBuilder(
        
        builder: (context, constraints) {
           if (constraints.maxWidth < 700) {
            return Board();
          } else {
            return LargeBoard();
          }
          
        }
      )),
    );
  }
}