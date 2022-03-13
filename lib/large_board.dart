// @dart=2.9
// ignore_for_file: prefer_conditional_assignment
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import 'large_grid.dart';

class LargeBoard extends StatefulWidget {
  @override
  _LargeBoardState createState() => _LargeBoardState();
}

class _LargeBoardState extends State<LargeBoard> {
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
              width: size.width,
              height: size.height,
              color: value,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
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
                          style: TextStyle(
                              color: value,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              fontFamily: 'Satisfy'),
                        );
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Align(
                        child: LargeGrid(numbers, size, clickGrid),
                        alignment: Alignment.topLeft,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: MirrorAnimation<Color>(
                              curve: Curves.easeInOut,
                              tween: ColorTween(
                                  end: Colors.black,
                                  begin: Colors.white), // define tween
                              duration:
                                  const Duration(seconds: 6), // define duration
                              builder: (context, child, value) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 170,
                                      height: 60,
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(primary: value),
                                        icon: Icon(Icons.hourglass_bottom,color: Colors.brown,),
                                          onPressed: () {},
                                          label: Text("Time Passed: "+secondsPassed.toString(),style: TextStyle(color: Colors.brown,fontFamily: 'Roboto',fontWeight: FontWeight.bold),)),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Container(
                                      width: 170,
                                      height: 60,
                                      child: ElevatedButton.icon(
                                        icon: Icon(Icons.replay,color: Colors.brown,),
                                        style: ElevatedButton.styleFrom(primary: value),
                                          onPressed: () {
                                            reset();
                                          },
                                          label: Text('Reset the game',style: TextStyle(color: Colors.brown,fontFamily: 'Roboto',fontWeight: FontWeight.bold),)),
                                    )
                                  ],
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        width: size.width*0.25,
                      )
                    ],
                  ),
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
                      Text(
                        "You Win!!",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 220.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Close",
                            style: TextStyle(color: Colors.white),
                          ),
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
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
