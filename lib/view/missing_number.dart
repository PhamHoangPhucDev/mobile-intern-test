import 'package:flutter/material.dart';

class MissingNumberScreen extends StatelessWidget {
  MissingNumberScreen({super.key});

  int findMissingNumber(List<int> nums) {
    int n = nums.length;
    int expectedSum = (n + 1) * (n + 2) ~/ 2;
    int actualSum = nums.reduce((a, b) => a + b);

    return expectedSum - actualSum;
  }
List<int> numbers = [1, 2, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Missing Number'),leading: IconButton(icon: Icon(Icons.arrow_back_ios_new_rounded),onPressed: () => Navigator.pop(context),),),
      body: Text('The missing number is: ${findMissingNumber(numbers)}'),
    );
  }
}