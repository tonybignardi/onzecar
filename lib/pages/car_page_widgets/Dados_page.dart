import 'package:appcarro/Componets/Image.dart';
import 'package:flutter/material.dart';

class CarDadosPage extends StatelessWidget {
  // recebe obrigatoriamente marca, ano, tipo, quilometragem, cambio, combustivel e placa
  const CarDadosPage({
    super.key,
    required this.marca,
    required this.ano,
    required this.tipo,
    required this.quilometragem,
    required this.cambio,
    required this.placa,
    required this.combustivel
  });
  // constante para tamanho do padding
  final double padd = 20;
  // construtores
  final String marca, ano, tipo, quilometragem, cambio, combustivel, placa;
  @override
  Widget build(BuildContext context) {
    return ListView(
      // Liste View para cada uma das infromações
      padding: EdgeInsets.all(padd),
      children: [
        // compente de imagem com o campo link para o endereço da imagem
        const Image_Wiget(link: 'https://imgs.search.brave.com/ORgcUSPj2ObSCMNjbolrObMJp2L1MGoDFuFxq_1AzUw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvODU5/Mzk0ODUwL3Bob3Rv/L2EtZmVycmFyaS1u/di1sYWZlcnJhcmkt/YXBlcnRhLXZlaGlj/bGUtc2l0cy1wYXJr/ZWQtaW4tZnJvbnQt/b2YtdGhlLW5ldy15/b3JrLXN0b2NrLWV4/Y2hhbmdlLWluLmpw/Zz9zPTYxMng2MTIm/dz0wJms9MjAmYz1O/OHhiNFFLQUt0WTkt/S1VFb0U4SURGanQ5/MDdnNlVWTWNLRVNE/LXQ1dENFPQ',),

        const SizedBox(
          height: 20,
        ),

        // Titulo da pagina
        Text(
          marca,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight(39)
          ),
        ),

        const SizedBox(
          height: 8,
        ),

        //card com cada umas das informações obrigatorias que foi pedido pela classe
        Card(
          elevation: 6,
          child: Column(
            children: [
              // ListTile para mostra as informações, util pois possibilita colocar inumeros outro elemetos do que um Text
              ListTile(
                title: const Text(
                  'Ano:'
                ),
                subtitle: Text(ano),
              ),
              ListTile(
                title: const Text(
                    'Tipo de Automóvel:'
                ),
                subtitle: Text(tipo),
              ),
              ListTile(
                title: const Text(
                    'Quilometragem:'
                ),
                subtitle: Text(quilometragem),
              ),
              ListTile(
                title: const Text(
                    'Tipo de cambio'
                ),
                subtitle: Text(cambio),
              ),
              ListTile(
                title: const Text(
                    'Tipo de combustivel'
                ),
                subtitle: Text(combustivel),
              ),
              ListTile(
                title: const Text(
                    'Placa'
                ),
                subtitle: Text(placa),
              ),
            ],
          ),
        )
      ],
    );
  }
}
