import 'package:flutter/material.dart';

import 'sorting_visualizer.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.white),
    home: SortingVisualizer(),
  )
);