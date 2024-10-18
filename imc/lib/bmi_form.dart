import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'body_mass_index.dart';

class BMIForm extends StatefulWidget {
  final Function(double) onBMICalculated;

  const BMIForm({super.key, required this.onBMICalculated});

  @override
  _BMIFormState createState() => _BMIFormState();
}

class _BMIFormState extends State<BMIForm> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String _result = '';
  final bool _autoValidate = false;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    if (_formKey.currentState!.validate()) {
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text);

      BodyMassIndex bmi = BodyMassIndex(weightKg: weight, heightCm: height);
      double bmiValue = bmi.calculateBMI();
      String category = bmi.getCategory();

      setState(() {
        _result = 'Votre IMC est ${bmiValue.toStringAsFixed(2)}. '
            'Catégorie : $category';
      });

      widget.onBMICalculated(bmiValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode:
          _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _weightController,
            decoration: const InputDecoration(
              labelText: 'Poids (kg)',
              hintText: 'Entrez votre poids en kilogrammes',
            ),
            keyboardType: TextInputType.number,
            maxLength: 3,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre poids';
              }
              int? weight = int.tryParse(value);
              if (weight == null || weight <= 0 || weight > 300) {
                return 'Veuillez entrer un poids valide (1-300 kg)';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _heightController,
            decoration: const InputDecoration(
              labelText: 'Taille (cm)',
              hintText: 'Entrez votre taille en centimètres',
            ),
            keyboardType: TextInputType.number,
            maxLength: 3,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre taille';
              }
              int? height = int.tryParse(value);
              if (height == null || height <= 0 || height > 300) {
                return 'Veuillez entrer une taille valide (1-300 cm)';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _calculateBMI,
            child: const Text('Calculer l\'IMC'),
          ),
          const SizedBox(height: 24),
          Text(
            _result,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
