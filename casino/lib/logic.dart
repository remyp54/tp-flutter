import 'dart:math';

class BanditManchotLogic {
  final List<String> imagePaths = [
    'images/bar.png',
    'images/cerise.png',
    'images/cloche.png',
    'images/diamant.png',
    'images/fer-a-cheval.png',
    'images/pasteque.png',
    'images/sept.png'
  ];
  
  List<String> currentImages = List.filled(3, 'images/question.png');
  final Random _random = Random();

  void spin() {
    for (int i = 0; i < 3; i++) {
      currentImages[i] = imagePaths[_random.nextInt(imagePaths.length)];
    }
  }

  bool checkWin() {
    return currentImages[0] == currentImages[1] &&
        currentImages[1] == currentImages[2];
  }

  bool checkJackpot() {
    return currentImages[0] == 'images/sept.png' &&
        currentImages[1] == 'images/sept.png' &&
        currentImages[2] == 'images/sept.png';
  }
}
