import 'package:flutter/material.dart';
import 'bmi_form.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculateur IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _bmiValue = 22.0;

  void updateBMI(double newBMI) {
    setState(() {
      _bmiValue = newBMI;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculateur IMC'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BMIForm(onBMICalculated: updateBMI),
            const SizedBox(height: 20),
            Gauge(bmiValue: _bmiValue),
          ],
        ),
      ),
    );
  }
}

class Gauge extends StatelessWidget {
  final double bmiValue;

  const Gauge({super.key, required this.bmiValue});

  @override
  Widget build(BuildContext context) {
    return _getRadialGauge();
  }

  Widget _getRadialGauge() {
    return SfRadialGauge(
      title: const GaugeTitle(
        text: 'IMC',
        textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 40,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 18.5,
              color: Colors.blue,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 18.5,
              endValue: 25,
              color: Colors.green,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 25,
              endValue: 30,
              color: Colors.orange,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 30,
              endValue: 40,
              color: Colors.red,
              startWidth: 10,
              endWidth: 10,
            ),
          ],
          pointers: <GaugePointer>[NeedlePointer(value: bmiValue)],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Text(
                bmiValue.toStringAsFixed(1),
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              angle: 90,
              positionFactor: 0.5,
            )
          ],
        )
      ],
    );
  }
}
