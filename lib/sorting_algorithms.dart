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
    await Future.delayed(Duration(milliseconds: (10 + 190*(1 - speedSliderValue)).round()), (){
      int temp = this.array[i];
      this.array[i] = this.array[j];
      this.array[j] = temp;
      this.colors[i] = Colors.deepPurple;
      this.colors[j] = Colors.deepPurple;
      notifyListeners();
    });
  }

  quickSort(left, right) async{
    int index = await _partition(left, right);
    if (left < index - 1) await quickSort( left, index - 1);
    if (index < right) await quickSort(index, right);
  }

  _partition(left, right) async{
    int pivot = this.array[(right + left)~/2];
    int i = left;
    int j = right;
    while (i <= j) {
      while (this.array[i] < pivot) i++;
      while (this.array[j] > pivot) j--;
      if (i <= j) {
        await swap(i, j);
        i++;
        j--;
      }
    }
    return i;
  }
}