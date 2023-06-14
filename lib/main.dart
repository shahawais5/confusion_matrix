import 'package:flutter/material.dart';

class ConfusionMatrix {
  int truePositive;
  int trueNegative;
  int falsePositive;
  int falseNegative;

  ConfusionMatrix()
      : truePositive = 0,
        trueNegative = 0,
        falsePositive = 0,
        falseNegative = 0;

  void addPrediction(bool actual, bool predicted) {
    if (actual && predicted) {
      truePositive++;
    } else if (!actual && !predicted) {
      trueNegative++;
    } else if (!actual && predicted) {
      falsePositive++;
    } else {
      falseNegative++;
    }
  }

  int get totalObservations =>
      truePositive + trueNegative + falsePositive + falseNegative;

  double get accuracy =>
      (truePositive + trueNegative) / totalObservations.toDouble();

  double get precision =>
      truePositive / (truePositive + falsePositive).toDouble();

  double get recall =>
      truePositive / (truePositive + falseNegative).toDouble();

  double get f1Score => 2 * (precision * recall) / (precision + recall);
}

void main() {
  List<bool> actual = [true, false, true, true, false, false, true, false];
  List<bool> predicted = [true, true, false, true, false, true, true, false];

  ConfusionMatrix confusionMatrix = ConfusionMatrix();

  for (int i = 0; i < actual.length; i++) {
    confusionMatrix.addPrediction(actual[i], predicted[i]);
  }

  runApp(MyApp(confusionMatrix: confusionMatrix));
}

class MyApp extends StatelessWidget {
  final ConfusionMatrix confusionMatrix;

  MyApp({required this.confusionMatrix});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Confusion Matrix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Confusion Matrix'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Confusion Matrix:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: IntrinsicColumnWidth(),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          'Predicted',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TableCell(
                        child: Text(''),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          'Positive',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          'Negative',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          'Actual',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TableCell(
                        child: Center(child: Text(confusionMatrix.truePositive.toString())),
                      ),
                      TableCell(
                        child: Center(child: Text(confusionMatrix.falseNegative.toString())),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Text(
                          '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TableCell(
                        child: Center(child: Text(confusionMatrix.falsePositive.toString())),
                      ),
                      TableCell(
                        child: Center(child: Text(confusionMatrix.trueNegative.toString())),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Accuracy: ${confusionMatrix.accuracy.toStringAsFixed(4)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Precision: ${confusionMatrix.precision.toStringAsFixed(4)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Recall: ${confusionMatrix.recall.toStringAsFixed(4)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'F1-Score: ${confusionMatrix.f1Score.toStringAsFixed(4)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
