import 'package:flutter/material.dart';

class SortingAlgorithms extends ChangeNotifier {
  List<int> array;
  List<Color> colors;
  double speedSliderValue;
  bool isSorting;

  SortingAlgorithms({this.array, this.colors, this.speedSliderValue, isSorting = false});

  normalSort() async {
    for (int i = 0; i < this.array.length; i++)
      for (int j = i + 1; j < this.array.length; j++)
        if (this.array[i] > this.array[j]) await _swap(i, j);
    _onSorted();
  }

  _swap(int i, int j) async {
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
    await _quickSort(0, this.array.length-1);
    _onSorted();
  }

  _quickSort(int left, int right) async {
    int index = await _partition(left, right);
    if (left < index - 1) await _quickSort(left, index - 1);
    if (index < right) await _quickSort(index, right);
  }

  _partition(int left, int right) async {
    int pivot = this.array[(right + left) ~/ 2];
    while (left <= right) {
      while (this.array[left] < pivot) left++;
      while (this.array[right] > pivot) right--;
      if (left <= right) {
        await _swap(left, right);
        left++;
        right--;
      }
    }
    return left;
  }

  _merge(int leftIndex, int middleIndex, int rightIndex) async {
    //here we calculate the size of left array and the right array.
    int leftSize = middleIndex - leftIndex + 1;
    int rightSize = rightIndex - middleIndex;

    //here we create a temporary array for each one of the left and right arrays.
    List<int> leftList = new List<int>(leftSize);
    List<int> rightList = new List<int>(rightSize);

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
    await _copyWhatIsLeft(i, index, leftSize, leftList);
    await _copyWhatIsLeft(j, index, rightSize, rightList);
  }

  _copyWhatIsLeft(int i, int index, int size, List<int> list) async {
    while (i < size) {
      this.colors[index] = Colors.red;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 10 + 190 * (1 - speedSliderValue).round()), () {
        this.array[index] = list[i];
        i++;
        this.colors[index] = Colors.purple;
        index++;
        notifyListeners();
      });
    }

  }

  mergeSort() async {
    await _mergeSort(0, this.array.length - 1);
    _onSorted();
  }

  _mergeSort(int leftIndex, int rightIndex) async {
    if(leftIndex >= rightIndex) return;

    int middleIndex = (rightIndex + leftIndex) ~/ 2;

    await _mergeSort(leftIndex, middleIndex);
    await _mergeSort(middleIndex + 1, rightIndex);

    await _merge(leftIndex, middleIndex, rightIndex);
  }

  _onSorted() {
    this.colors = List<Color>.generate(this.array.length, (i) => Colors.green);
    notifyListeners();
  }
}
