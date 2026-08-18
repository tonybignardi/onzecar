// Importações de componentes locais da aplicação
import 'package:appcarro/Componets/Image.dart';
import 'package:appcarro/pages/car_page_widgets/Contato_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Widget sem estado (StatelessWidget) para exibição da imagem e preço do carro
class CarPrecoPage extends StatelessWidget {
  // Recebe obrigatoriamente a string com o preço do veículo via construtor
  const CarPrecoPage({super.key, required this.preco});

  // Espaçamento padrão reutilizado nos paddings
  final double padd = 26;

  // Parâmetro dinâmico para o valor do carro
  final String preco;

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Padding em volta de toda a lista de exibição
      padding: EdgeInsets.all(padd),
      children: [
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

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Centraliza os textos verticalmente
                    children: [
                      Text(
                        preco,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'valor à vista',
                        style: TextStyle(color: Colors.deepOrange),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 4), // Espaçamento horizontal entre as colunas

                // Lado direito: Botão de ação
                Expanded(
                  child: SizedBox(
                    height: 90, // Define uma altura customizada para o botão
                    child: FilledButton.icon(
                      onPressed: () {
                        // Navega para a página de formulário de contato
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CarContactPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.mail_sharp),
                      label: const Text(
                        'Garanta já o seu',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
