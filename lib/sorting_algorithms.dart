import 'package:flutter/material.dart';

class SortingAlgorithms extends ChangeNotifier {
  List<int> array;
  List<Color> colors;
  double speedSliderValue;
  
  SortingAlgorithms({this.array, this.colors, this.speedSliderValue});

  sort() async{
    for(int i = 0; i < this.array.length; i++)
      for(int j = i+1; j < this.array.length; j++)
        if(this.array[i] > this.array[j]) await swap(i, j);
  }

  swap(int i, int j) async{
    this.colors[i] = Colors.red;
    this.colors[j] = Colors.red;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 40), (){
      int temp = this.array[i];
      this.array[i] = this.array[j];
      this.array[j] = temp;
      this.colors[i] = Colors.deepPurple;
      this.colors[j] = Colors.deepPurple;
      notifyListeners();
    });
  }
}