import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomme Poire Ananas',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Pomme Poire Ananas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final List<int> _fruits = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
      _fruits.add(_counter);
    });
  }

  bool isPrime(int number) {
    if (number <= 1) return false;
    if (number == 2) return true;
    if (number % 2 == 0) return false;
    for (int i = 3; i <= (number / 2).floor(); i += 2) {
      if (number % i == 0) return false;
    }
    return true;
  }

  String getNumberType(int number) {
    if (isPrime(number)) return "Nombre premier";
    if (number % 2 == 0) return "Nombre pair";
    return "Nombre impair";
  }

  Color getBackgroundColor(int number) {
    if (isPrime(number)) return Colors.orange;
    if (number % 2 == 0) return Colors.indigo;
    return Colors.cyan;
  }

  String getFruitImage(int number) {
    if (isPrime(number)) return 'images/ananas.png';
    if (number % 2 == 0) return 'images/poire.png';
    return 'images/pomme.png';
  }

  void showFruitDialog(BuildContext context, int fruit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: getBackgroundColor(fruit),
          title: Text(
            "${getNumberType(fruit)} : $fruit",
            style: const TextStyle(color: Colors.white),
          ),
          content: Image.asset(
            getFruitImage(fruit),
            width: 100,
            height: 100,
          ),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Fermer', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Supprimer',
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  _fruits.remove(fruit);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$_counter : ${getNumberType(_counter)}"),
      ),
      body: ListView.builder(
        itemCount: _fruits.length,
        itemBuilder: (context, index) {
          final fruit = _fruits[index];
          return Container(
            color: getBackgroundColor(fruit),
            child: ListTile(
              leading: const Icon(Icons.food_bank, color: Colors.white),
              title: Text('Fruit $fruit',
                  style: const TextStyle(color: Colors.white)),
              subtitle: Text('Ajouté en ${index + 1}e position',
                  style: const TextStyle(color: Colors.white)),
              trailing:
                  Image.asset(getFruitImage(fruit), width: 24, height: 24),
              onTap: () => showFruitDialog(context, fruit),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Ajouter un fruit',
        backgroundColor: getBackgroundColor(_counter + 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
