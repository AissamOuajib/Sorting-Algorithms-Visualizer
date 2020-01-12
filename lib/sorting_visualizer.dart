import 'dart:math';

import 'package:flutter/material.dart';

import 'sorting_algorithms.dart';

class SortingVisualizer extends StatefulWidget {
  @override
  _SortingVisualizerState createState() => _SortingVisualizerState();
}

class _SortingVisualizerState extends State<SortingVisualizer> {
  SortingAlgorithms sortingAlgorithms;
  @override
  void initState() {
    super.initState();
    // timer.addListener(() => setState((){}));
    sortingAlgorithms = SortingAlgorithms(
      array: List<int>.generate(50, (i) => Random().nextInt(90)+10),
      colors: List<Color>.generate(50, (i) => Colors.deepPurple),
    );
    sortingAlgorithms.addListener(() => setState((){}));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sorting Visualizer'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(sortingAlgorithms.array.length, (i) => 
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: .6),
              child: Container(
                height: 3.0*sortingAlgorithms.array[i], 
                color: sortingAlgorithms.colors[i],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sortingAlgorithms.sort(),
        child: Icon(Icons.sort),
      ),
    );
  }
}