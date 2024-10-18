class BodyMassIndex {
  final double weightKg;
  final double heightCm;

  BodyMassIndex({required this.weightKg, required this.heightCm});

  double calculateBMI() {
    return weightKg / ((heightCm / 100) * (heightCm / 100));
  }

  String getCategory() {
    double bmi = calculateBMI();
    if (bmi < 18.5) {
      return 'underweight';
    } else if (bmi < 25.0) {
      return 'normal';
    } else if (bmi < 30.0) {
      return 'overweight';
    } else {
      return 'obesity';
    }
  }
}
