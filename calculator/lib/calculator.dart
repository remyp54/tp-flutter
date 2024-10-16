import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Operation { addition, subtraction, multiplication, division }

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.title});

  final String title;

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int _counter = 0;
  int _clickCount = 0;
  int _increment = 1;
  Operation _currentOperation = Operation.addition;
  final TextEditingController _incrementController =
      TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    _incrementController.addListener(_updateIncrement);
  }

  @override
  void dispose() {
    _incrementController.dispose();
    super.dispose();
  }

  void _updateIncrement() {
    int? newIncrement = int.tryParse(_incrementController.text);
    if (newIncrement != null) {
      if (newIncrement < 1) {
        _showZeroAlert();
        newIncrement = 1;
        _incrementController.text = '1';
      }
      setState(() {
        _increment = newIncrement!;
      });
    }
  }

  void _showZeroAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Attention'),
          content: const Text(
              'La valeur de l\'incrément ne doit pas être inférieure à 1'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _performOperation() {
    setState(() {
      switch (_currentOperation) {
        case Operation.addition:
          _counter += _increment;
          break;
        case Operation.subtraction:
          _counter -= _increment;
          break;
        case Operation.multiplication:
          _counter *= _increment;
          break;
        case Operation.division:
          if (_increment < 1) {
            _showZeroAlert();
          } else {
            _counter ~/= _increment;
          }
          break;
      }
      _clickCount++;
    });
  }

  String _getOperationSymbol() {
    switch (_currentOperation) {
      case Operation.addition:
        return '+';
      case Operation.subtraction:
        return '-';
      case Operation.multiplication:
        return '×';
      case Operation.division:
        return '÷';
    }
  }

  IconData _getOperationIcon() {
    switch (_currentOperation) {
      case Operation.addition:
        return Icons.add;
      case Operation.subtraction:
        return Icons.remove;
      case Operation.multiplication:
        return Icons.close;
      case Operation.division:
        return Icons.horizontal_rule;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<Operation>(
              value: _currentOperation,
              onChanged: (Operation? newValue) {
                setState(() {
                  _currentOperation = newValue!;
                });
              },
              items: Operation.values
                  .map<DropdownMenuItem<Operation>>((Operation value) {
                return DropdownMenuItem<Operation>(
                  value: value,
                  child: Text(_getOperationName(value)),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text(
              'Vous avez cliqué $_clickCount fois',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_counter ${_getOperationSymbol()} $_increment = ',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '${_performOperationPreview()}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _incrementController,
                decoration: const InputDecoration(
                  labelText: 'Valeur de l\'incrément',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty || int.parse(value) < 1) {
                    return 'La valeur doit être au moins 1';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.isNotEmpty && int.parse(value) < 1) {
                    _showZeroAlert();
                    _incrementController.text = '1';
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _performOperation,
        tooltip: 'Perform Operation',
        child: _currentOperation == Operation.division
            ? const Text(
                '/',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            : Icon(_getOperationIcon()),
      ),
    );
  }

  int _performOperationPreview() {
    switch (_currentOperation) {
      case Operation.addition:
        return _counter + _increment;
      case Operation.subtraction:
        return _counter - _increment;
      case Operation.multiplication:
        return _counter * _increment;
      case Operation.division:
        return _increment != 0 ? _counter ~/ _increment : _counter;
    }
  }

  String _getOperationName(Operation op) {
    switch (op) {
      case Operation.addition:
        return 'Addition';
      case Operation.subtraction:
        return 'Soustraction';
      case Operation.multiplication:
        return 'Multiplication';
      case Operation.division:
        return 'Division';
    }
  }
}
