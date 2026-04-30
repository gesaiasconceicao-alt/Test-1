import 'package:flutter/material.dart';

void main() {
  runApp(const GiguApp());
}

class GiguApp extends StatelessWidget {
  const GiguApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GIGU Auto Pilot Pro',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final valor = TextEditingController();
  final buscar = TextEditingController();
  final corrida = TextEditingController();

  String resultado = 'Aguardando cálculo';
  double meta = 300;
  double ganhos = 0;

  void calcular() {
    double v = double.tryParse(valor.text) ?? 0;
    double b = double.tryParse(buscar.text) ?? 0;
    double c = double.tryParse(corrida.text) ?? 0;

    double total = b + c;
    if (total <= 0) return;

    double r = v / total;

    String status = '🔴 RECUSAR';
    if (r >= 2.2) {
      status = '🟢 ACEITAR';
    } else if (r >= 1.7) {
      status = '🟡 ANALISAR';
    }

    setState(() {
      resultado = 'R\$ ${r.toStringAsFixed(2)}/km | $status';
      ganhos += v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GIGU Auto Pilot Pro'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: calcular,
        child: const Icon(Icons.bubble_chart),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Meta diária: R\$ ${meta.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 18),
            ),
            Text('Ganhos: R\$ ${ganhos.toStringAsFixed(2)}'),

            const SizedBox(height: 20),

            TextField(
              controller: valor,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor corrida (R\$)',
              ),
            ),

            TextField(
              controller: buscar,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Km até passageiro',
              ),
            ),

            TextField(
              controller: corrida,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Km corrida',
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: calcular,
              child: const Text('CALCULAR SCORE'),
            ),

            const SizedBox(height: 20),

            Text(
              resultado,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
