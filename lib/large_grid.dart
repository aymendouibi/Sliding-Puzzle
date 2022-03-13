import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'GridButton.dart';

class LargeGrid extends StatelessWidget {
  var numbers = [];
  var size;
  Function clickGrid;

  LargeGrid(this.numbers, this.size, this.clickGrid);

  @override
  Widget build(BuildContext context) {
    var height = size.height;

    return SizedBox(
      width: size.width*0.44,
      height: height * 0.87,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  30),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
              childAspectRatio: 0.1,
    mainAxisExtent: 110,
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
