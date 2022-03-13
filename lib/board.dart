// @dart=2.9
// ignore_for_file: prefer_conditional_assignment
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import 'Grid.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  int move = 0;
  var color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer timer;

  @override
  void initState() {
    super.initState();
    numbers.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        startTime();
      });
    }

    return SafeArea(
      child: MirrorAnimation<Color>(
          curve: Curves.easeInOut,
          tween: ColorTween(
              begin: Colors.black, end: Colors.white), // define tween
          duration: const Duration(seconds: 6), // define duration
          builder: (context, child, value) {
            return Container(
              height: size.height,
              color: value,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  MirrorAnimation<Color>(
                      curve: Curves.easeInOut,
                      tween: ColorTween(
                          end: Colors.black,
                          begin: Colors.white), // define tween
                      duration: const Duration(seconds: 6), // define duration
                      builder: (context, child, value) {
                        return Text(
                          'Black  and  White',
                          style: TextStyle(color: value,fontWeight: FontWeight.bold,fontSize: 33,fontFamily: 'Satisfy'),
                        );
                      }),
                  SizedBox(
                    height: 25,
                  ),
                  Grid(numbers, size, clickGrid),
                  MirrorAnimation<Color>(
                      curve: Curves.easeInOut,
                      tween: ColorTween(
                          end: Colors.black,
                          begin: Colors.white), // define tween
                      duration:
                          const Duration(seconds: 6), // define duration
                      builder: (context, child, value) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 50,
                              width: size.width*0.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(primary: value),
                                  icon: Icon(Icons.hourglass_bottom,color: Colors.brown,),
                                    onPressed: () {},
                                    label: Text("Time Passed: "+secondsPassed.toString(),style: TextStyle(color: Colors.brown,fontFamily: 'Roboto',fontWeight: FontWeight.bold),)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                              
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                                       height: 50,
                                                       width:size.width*0.5,
                                child: ElevatedButton.icon(
                                  icon: Icon(Icons.replay,color: Colors.brown,),
                                  style: ElevatedButton.styleFrom(primary: value),
                                    onPressed: () {
                                      reset();
                                    },
                                    label: Text('Reset the Game',style: TextStyle(color: Colors.brown,fontFamily: 'Roboto',fontWeight: FontWeight.bold),)),
                              ),
                            )
                          ],
                        );
                      }),
                ],
              ),
            );
          }),
    );
  }

 
  void clickGrid(index) {
    if (secondsPassed == 0) {
      isActive = true;
    }
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % 4 != 0 ||
        index + 1 < 16 && numbers[index + 1] == 0 && (index + 1) % 4 != 0 ||
        (index - 4 >= 0 && numbers[index - 4] == 0) ||
        (index + 4 < 16 && numbers[index + 4] == 0)) {
      setState(() {
        move++;
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
        //color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
      });
    }
    checkWin();
  }

  void startTime() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  void reset() {
    setState(() {
      numbers.shuffle();
      move = 0;
      secondsPassed = 0;
      isActive = false;
    });
  }

  bool isSorted(List list) {
    int prev = list.first;
    for (var i = 1; i < list.length - 1; i++) {
      int next = list[i];
      if (prev > next) return false;
      prev = next;
    }
    return true;
  }

  void checkWin() {
    if (isSorted(numbers)) {
      isActive = false;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "You Win !!",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        width: 220.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              "Close",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(primary: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
