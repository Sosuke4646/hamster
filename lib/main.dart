import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: CarGacha(),
  ));
}

class CarGacha extends StatefulWidget {
  const CarGacha({super.key});

  @override
  State<CarGacha> createState() => _CarGachaState();
}

class _CarGachaState extends State<CarGacha> {
  int n = 0, e = 0;
  bool loading = false;

  final emojis = ['🏎️', '💨', '🚗', '✨'];

  final images = [
    'https://upload.wikimedia.org/wikipedia/commons/1/16/Ferrari458Italia.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/1/19/Lamborghini_Aventador.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/2/2e/McLaren_P1_1.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/8/87/Porsche_911.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/7/71/Bugatti_Veyron.jpg',
  ];

  Future<void> gacha() async {
    setState(() {
      loading = true;
    });

    for (int i = 0; i < 10; i++) {
      await Future.delayed(
        const Duration(milliseconds: 100),
      );

      if (!mounted) return;

      setState(() {
        e = (e + 1) % emojis.length;
      });
    }

    if (!mounted) return;

    setState(() {
      n = Random().nextInt(images.length);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🏎️ 高級車ガチャ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: loading
                  ? Center(
                      child: Text(
                        emojis[e],
                        style: const TextStyle(fontSize: 100),
                      ),
                    )
                  : Image.network(
                      images[n],
                      fit: BoxFit.cover,
                    ),
            ),

            const SizedBox(height: 30),

            const Text(
              '🏎️',
              style: TextStyle(fontSize: 72),
            ),

            ElevatedButton(
              onPressed: loading ? null : gacha,
              child: const Text('ガチャを回す！'),
            ),
          ],
        ),
      ),
    );
  }
}