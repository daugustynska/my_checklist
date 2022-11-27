import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
    required this.completed,
    required this.all,
  }) : super(key: key);

  final List completed;
  final List all;

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      width: MediaQuery.of(context).size.width - 90,
      lineHeight: 23,
      progressColor: Colors.blue,
      backgroundColor: Colors.grey.shade300,
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      leading: Container(
          width: 90,
          height: 23,
          decoration: const BoxDecoration(color: Colors.blue),
          child: const Center(
            child: Text(
              "PROGRESS",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          )),
      percent: completed.length / all.length,
      center:
          Text("${(completed.length / all.length * 100).toStringAsFixed(0)} %"),
    );
  }
}
