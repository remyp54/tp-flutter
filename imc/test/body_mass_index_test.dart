import 'package:flutter_test/flutter_test.dart';
import 'package:imc/body_mass_index.dart';

void main() {
  group('BodyMassIndex', () {
    test('calculateBMI should return correct value', () {
      final bmi = BodyMassIndex(weightKg: 70, heightCm: 170);
      expect(bmi.calculateBMI(), closeTo(24.22, 0.01));
    });

    test('getCategory should return correct category for underweight', () {
      final bmi = BodyMassIndex(weightKg: 50, heightCm: 170);
      expect(bmi.getCategory(), 'underweight');
    });

    test('getCategory should return correct category for normal weight', () {
      final bmi = BodyMassIndex(weightKg: 70, heightCm: 170);
      expect(bmi.getCategory(), 'normal');
    });

    test('getCategory should return correct category for overweight', () {
      final bmi = BodyMassIndex(weightKg: 80, heightCm: 175);
      bmi.calculateBMI();
      expect(bmi.getCategory(), 'overweight');
    });

    test('getCategory should return correct category for obesity', () {
      final bmi = BodyMassIndex(weightKg: 110, heightCm: 170);
      expect(bmi.getCategory(), 'obesity');
    });

    test('getCategory should correctly handle BMI at category boundaries', () {
      expect(BodyMassIndex(weightKg: 53.4, heightCm: 170).getCategory(), 'underweight');
      expect(BodyMassIndex(weightKg: 53.5, heightCm: 170).getCategory(), 'normal');
      expect(BodyMassIndex(weightKg: 72.0, heightCm: 170).getCategory(), 'normal');
      expect(BodyMassIndex(weightKg: 72.3, heightCm: 170).getCategory(), 'overweight');
      expect(BodyMassIndex(weightKg: 86.5, heightCm: 170).getCategory(), 'overweight');
      expect(BodyMassIndex(weightKg: 86.7, heightCm: 170).getCategory(), 'obesity');
    });
  });
}
