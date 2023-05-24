import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter com Código de Nativos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _a = 0;
  int _b = 0;
  int _sum = 0;

  Future<void> _calcSum() async {

    const channel = MethodChannel('techstack.dev.br/nativo');

    try{
      final sum = await channel.invokeMethod('calcSum', {"a": _a, "b": _b});
      setState(() {
        _sum = sum;
      });
    } on PlatformException{
      setState(() {
        _sum = 9999999;
      });
    }

    setState(() {
      _sum = _a + _b;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Nativo"),
      ),
      body: Center(
        child: Padding(padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Soma... $_sum",
            style: TextStyle(
              fontSize: 30,
            ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _a = int.tryParse(value) ?? 0;
                });
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _b = int.tryParse(value) ?? 0;
                });
              },
            ),
            TextButton(
              child: Text('Somar'),
              onPressed: _calcSum,
              ),
          ],
        ),
        ),
      ),
    );
  }
}
