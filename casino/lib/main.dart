import 'package:flutter/material.dart';
import 'logic.dart';

void main() {
  runApp(const BanditManchotApp());
}

class BanditManchotApp extends StatelessWidget {
  const BanditManchotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bandit Manchot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BanditManchotGame(),
    );
  }
}

class BanditManchotGame extends StatefulWidget {
  const BanditManchotGame({super.key});

  @override
  State<BanditManchotGame> createState() => _BanditManchotGameState();
}

class _BanditManchotGameState extends State<BanditManchotGame>
    with TickerProviderStateMixin {
  final BanditManchotLogic _gameLogic = BanditManchotLogic();
  late AnimationController _jackpotController;
  late Animation<double> _jackpotAnimation;

  @override
  void initState() {
    super.initState();
    _jackpotController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _jackpotAnimation = CurvedAnimation(
      parent: _jackpotController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _jackpotController.dispose();
    super.dispose();
  }

  void _spin() {
    setState(() {
      _gameLogic.spin();
      if (_gameLogic.checkJackpot()) {
        _showJackpotAnimation();
      } else if (_gameLogic.checkWin()) {
        _showWinMessage();
      }
    });
  }

  void _showJackpotAnimation() {
    _jackpotController.forward(from: 0.0);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('JACKPOT!'),
          content: ScaleTransition(
            scale: _jackpotAnimation,
            child: Image.asset('images/sept.png', width: 100, height: 100),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Continuer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showWinMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Jackpot')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bandit Manchot')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                3,
                (index) => Image.asset(
                  _gameLogic.currentImages[index],
                  width: 64,
                  height: 64,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: _spin,
              child: const Text('Tourner'),
            ),
          ],
        ),
      ),
    );
  }
}
