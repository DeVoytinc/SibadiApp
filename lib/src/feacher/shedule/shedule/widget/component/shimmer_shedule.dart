import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerShedule extends StatelessWidget {
  const ShimmerShedule({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
    Shimmer.fromColors(
      baseColor: Theme.of(context).canvasColor,
      highlightColor: const Color.fromARGB(55, 27, 24, 36),
      child: Container(
        margin: const EdgeInsets.only(
            top: 10, left: 10, right: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topRight,
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).canvasColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).canvasColor,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    Shimmer.fromColors(
      baseColor: Theme.of(context).canvasColor,
      highlightColor: const Color.fromARGB(55, 27, 24, 36),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).canvasColor,
          ),
        ),
      ),
    ),
    Shimmer.fromColors(
      baseColor: Theme.of(context).canvasColor,
      highlightColor: const Color.fromARGB(55, 27, 24, 36),
      child: Container(
        margin: const EdgeInsets.only(
            top: 10, left: 10, right: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topRight,
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).canvasColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).canvasColor,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    Shimmer.fromColors(
      baseColor: Theme.of(context).canvasColor,
      highlightColor: const Color.fromARGB(55, 27, 24, 36),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).canvasColor,
          ),
        ),
      ),
    ),
    Shimmer.fromColors(
      baseColor: Theme.of(context).canvasColor,
      highlightColor: const Color.fromARGB(55, 27, 24, 36),
      child: Container(
        margin: const EdgeInsets.only(
            top: 10, left: 10, right: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topRight,
              width: 50,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).canvasColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).canvasColor,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    Shimmer.fromColors(
      baseColor: Theme.of(context).canvasColor,
      highlightColor: const Color.fromARGB(55, 27, 24, 36),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).canvasColor,
          ),
        ),
      ),
    ),
  ]);
}