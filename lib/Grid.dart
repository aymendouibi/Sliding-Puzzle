import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'GridButton.dart';

class Grid extends StatelessWidget {
  var numbers = [];
  var size;
  Function clickGrid;

  Grid(this.numbers, this.size, this.clickGrid);

  @override
  Widget build(BuildContext context) {
    var height = size.height;

    return Container(
      height: height * 0.60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return numbers[index] != 0
                ? AnimationConfiguration.staggeredList(
                  position: index,
            duration: const Duration(milliseconds: 100),
                  child: SlideAnimation(
                    child: ScaleAnimation(
                      child: GridButton("${numbers[index]}", () {
                            clickGrid(index);
                          }),
                    ),
                  ),
                )
                : SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
