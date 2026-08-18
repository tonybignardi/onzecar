import 'package:appcarro/Componets/Image.dart';
import 'package:flutter/material.dart';

class CarDadosPage extends StatelessWidget {
  const CarDadosPage({
    super.key,
    required this.marca,
    required this.ano,
    required this.tipo,
    required this.quilometragem,
    required this.cambio,
    required this.placa,
    required this.combustivel,
  });

  final double padd = 16.0;
  final String marca, ano, tipo, quilometragem, cambio, combustivel, placa;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(padd),
      children: [
        // Titulo da pagina
        Text(
          marca,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(
            height: 16
        ),

        // Card estilizado conforme a imagem
        Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Imagem à esquerda com tamanho fixo
                const Image_Wiget(
                    link: 'https://imgs.search.brave.com/JhkU4NwajUebh55LA9XfZHWORnhwJCMyBSeOV6s1GYk/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvODU5/Mzk0ODUwL3Bob3Rv/L2EtZmVycmFyaS1u/di1sYWZlcnJhcmkt/YXBlcnRhLXZlaGlj/bGUtc2l0cy1wYXJr/ZWQtaW4tZnJvbnQt/b2YtdGhlLW5ldy15/b3JrLXN0b2NrLWV4/Y2hhbmdlLWluLmpw/Zz9zPTYxMng2MTIm/dz0wJms9MjAmYz1O/OHhiNFFLQUt0WTkt/S1VFb0U4SURGanQ5/MDdnNlVWTWNLRVNE/LXQ1dENFPQ',
                ),

                const SizedBox(width: 16),

                // 2. Coluna 1 de textos
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextItem('Ano', ano),
                      const SizedBox(height: 12),
                      _buildTextItem('Câmbio', cambio),
                      const SizedBox(height: 12),
                      _buildTextItem('Placa', placa),
                    ],
                  ),
                ),

                // 3. Coluna 2 de textos
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextItem('Tipo', tipo),
                      const SizedBox(height: 12),
                      _buildTextItem('KM', quilometragem),
                      const SizedBox(height: 12),
                      _buildTextItem('Combustível', combustivel),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper Widget para formatar cada par de título/valor de forma padronizada
  Widget _buildTextItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
