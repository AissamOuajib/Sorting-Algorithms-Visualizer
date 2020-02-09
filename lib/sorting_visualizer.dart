import 'dart:math';

import 'package:flutter/material.dart';

import 'sorting_algorithms.dart';

class SortingVisualizer extends StatefulWidget {
  @override
  _SortingVisualizerState createState() => _SortingVisualizerState();
}

class _SortingVisualizerState extends State<SortingVisualizer> {
  double lenghtSliderValue = 0.5;
  String sortType = 'Normal Sort';
  List<String> sortTypes = [
    'Normal Sort',
    'Merge Sort',
    'Quick Sort',
    'Heap Sort',
    'Bubble Sort',
  ];
  bool isSorting = false;
  SortingAlgorithms sortingAlgorithms;
  @override
  void initState() {
    super.initState();
    sortingAlgorithms = SortingAlgorithms(
      array: List<int>.generate(50, (i) => Random().nextInt(90) + 10),
      colors: List<Color>.generate(50, (i) => Colors.deepPurple),
      speedSliderValue: .5,
    );
    sortingAlgorithms.addListener(() => setState(() {}));
  }

  _sort() {
    if (sortType == 'Normal Sort')
      sortingAlgorithms.normalSort();
    else if (sortType == 'Quick Sort')
      sortingAlgorithms.quickSort();
    else if (sortType == 'Merge Sort') sortingAlgorithms.mergeSort();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sorting Visualizer'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(135),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(width: 120, child: Text('Array Lenght : ')),
                    Expanded(
                      child: Slider.adaptive(
                        activeColor: Colors.black,
                        value: lenghtSliderValue,
                        onChanged: (newValue) {
                          isSorting = false;
                          setState(() {
                            lenghtSliderValue = newValue;
                            sortingAlgorithms.array.length = (newValue * 120 + 10).toInt();
                            sortingAlgorithms.array = List<int>.generate(sortingAlgorithms.array.length, (i) => Random().nextInt(90) + 10);
                            sortingAlgorithms.colors = List<Color>.generate(sortingAlgorithms.array.length, (i) => Colors.deepPurple);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(width: 120, child: Text('Sorting Speed : ')),
                    Expanded(
                      child: Slider.adaptive(
                        activeColor: Colors.black,
                        value: sortingAlgorithms.speedSliderValue,
                        onChanged: (newValue) {
                          setState(() {
                            sortingAlgorithms.speedSliderValue = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(width: 120, child: Text('Sorting Alog : ')),
                    Expanded(
                      child: DropdownButton<String>(
                        disabledHint: Text(sortType),
                        isExpanded: true,
                        value: sortType,
                        onChanged: !isSorting
                            ? (String newValue) =>
                                setState(() => sortType = newValue)
                            : null,
                        items: sortTypes
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          sortingAlgorithms.array.length,
          (i) => Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: .6),
              child: Container(
                height: 3.0 * sortingAlgorithms.array[i],
                color: sortingAlgorithms.colors[i],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sort,
        child: Icon(Icons.sort),
      ),
    );
  }
}
