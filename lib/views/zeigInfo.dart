import 'package:flutter/material.dart';

import 'package:myapp/model/filme.dart';

//---Tela que exibe os detalhes do filme selecionado------------------

class ZeigInfo extends StatelessWidget {
  final Filme filme;

  const ZeigInfo({super.key, required this.filme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(filme.url),
              ),
              const SizedBox(height: 16),
              Text(
                filme.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(filme.genre),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        color: index < filme.score ? Colors.amber : Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
              Text(
                'Ano: ${filme.year}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Duração: ${filme.duration}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                filme.description,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
