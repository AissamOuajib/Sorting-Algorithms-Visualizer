import 'package:flutter/material.dart';

class SortingAlgorithms extends ChangeNotifier {
  List<int> array;
  List<Color> colors;
  double speedSliderValue;

  SortingAlgorithms({this.array, this.colors, this.speedSliderValue});

  sort() async {
    for (int i = 0; i < this.array.length; i++)
      for (int j = i + 1; j < this.array.length; j++)
        if (this.array[i] > this.array[j]) await swap(i, j);
    this.colors = List<Color>.generate(50, (i) => Colors.green);
    notifyListeners();
  }

  swap(int i, int j) async {
    this.colors[i] = Colors.red;
    this.colors[j] = Colors.red;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: (10 + 190 * (1 - speedSliderValue)).round()), () {
      int temp = this.array[i];
      this.array[i] = this.array[j];
      this.array[j] = temp;
      this.colors[i] = Colors.purple;
      this.colors[j] = Colors.purple;
      notifyListeners();
    });
  }

  quickSort() async {
    await qckSort(0, this.array.length-1);
    this.colors = List<Color>.generate(50, (i) => Colors.green);
    notifyListeners();
  }

  qckSort(left, right) async {
    int index = await _partition(left, right);
    if (left < index - 1) await qckSort(left, index - 1);
    if (index < right) await qckSort(index, right);
  }

  _partition(left, right) async {
    int pivot = this.array[(right + left) ~/ 2];
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

  merge(int leftIndex, int middleIndex, int rightIndex) async {
    //here we calculate the size of left array and the right array.
    int leftSize = middleIndex - leftIndex + 1;
    int rightSize = rightIndex - middleIndex;

    //here we create a temporary array for each one of the left and right arrays.
    List leftList = new List(leftSize);
    List rightList = new List(rightSize);

    //Here we fill those temporary arrays.
    for (int i = 0; i < leftSize; i++) leftList[i] = this.array[leftIndex + i];
    for (int j = 0; j < rightSize; j++) rightList[j] = this.array[middleIndex + j + 1];
    
    //this is to loop over the left array.
    int i = 0;
    //this is to loop over the right array.
    int j = 0;
    //this is to loop over the principle array.
    int index = leftIndex;

    //Here we merge the two arrays into the principle array.
    while (i < leftSize && j < rightSize) {
      this.colors[index] = Colors.red;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 10 + 190 * (1 - speedSliderValue).round()), () {
        if (leftList[i] <= rightList[j]) {
          this.array[index] = leftList[i];
          i++;
          this.colors[index] = Colors.purple;
          notifyListeners();
        } else {
          this.array[index] = rightList[j];
          j++;
          this.colors[index] = Colors.purple;
          notifyListeners();
        }
        index++;
      });
    }

    //Here we copy whatever is left from each array.
    while (i < leftSize) {
      this.colors[index] = Colors.red;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 10 + 190 * (1 - speedSliderValue).round()), () {
        this.array[index] = leftList[i];
        i++;
        this.colors[index] = Colors.purple;
        index++;
        notifyListeners();
      });
    }
    while (j < rightSize) {
      this.colors[index] = Colors.red;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 10 + 190 * (1 - speedSliderValue).round()), () {
        this.array[index] = rightList[j];
        j++;
        this.colors[index] = Colors.purple;
        index++;
        notifyListeners();
      });
    }
  }

  mergeSort() async {
    await mrgSort(0, this.array.length - 1);
    this.colors = List<Color>.generate(50, (i) => Colors.green);
    notifyListeners();
  }

  mrgSort(int leftIndex, int rightIndex) async {
    if(leftIndex >= rightIndex) return;

    int middleIndex = (rightIndex + leftIndex) ~/ 2;

    await mrgSort(leftIndex, middleIndex);
    await mrgSort(middleIndex + 1, rightIndex);

    await merge(leftIndex, middleIndex, rightIndex);
  }
}
