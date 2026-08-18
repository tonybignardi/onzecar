import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarDetalhePage extends StatelessWidget{
  // parametros requisitados para o funcionamento da tela estatica Stateless
  const CarDetalhePage({
    super.key,
    required this.estado,
    required this.acabamento,
    required this.acessorio,
    required this.proprietario,
    required this.troca,
    required this.infoOpiconal
  });
  // constante para o tamamho do padding
  final double padd = 20;
  // Construtures
  final String estado, acessorio,acabamento, proprietario, troca, infoOpiconal;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(padd),
      children: [
        // Titulo
        const Text(
          'Detalhes do automóvel',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        // Da o tamanho da caixa de Texto anterior
        SizedBox(
          height: padd,
        ),

        // Cartão flutuante que serve com uma area de informações
        Card(
          child: Column(
            children: [
              // Cada ListTile é uma campo que usa os contrutores da Classe
              ListTile(
                leading: const Icon(Icons.car_crash),
                title: const Text(
                  'Estado do veicúlo:'
                ),
                subtitle: Text(estado),
              ),

              ListTile(
                leading: const Icon(Icons.watch),
                title: const Text(
                    'Quais acessorios usa:'
                ),
                subtitle: Text(acessorio),
              ),
              ListTile(
                leading: const Icon(Icons.color_lens_sharp),
                title: const Text(
                    'Esteica ou Acabamento do Carro:'
                ),
                subtitle: Text(acabamento),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text(
                    'Proprietario:'
                ),
                subtitle: Text(proprietario),
              ),
              ListTile(
                leading: const Icon(Icons.airline_seat_recline_normal),
                title: const Text(
                    'Aceita troca:'
                ),
                subtitle: Text(troca),
              ),
              ListTile(
                leading: const Icon(Icons.text_fields),
                title: const Text(
                    'Infromações adicioanis:'
                ),
                // em caso do usuário não colocar infromações
                subtitle: Text(infoOpiconal == " " ? infoOpiconal : 'não possui'),
              )
            ],
          ),
        )
      ],
    );
  }
}
