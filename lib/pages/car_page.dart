import 'package:appcarro/pages/car_page_widgets/Dados_page.dart';
import 'package:appcarro/pages/car_page_widgets/Detalhe_page.dart';
import 'package:appcarro/pages/car_page_widgets/Preco_page.dart';
import 'package:flutter/material.dart';

class CarPage extends StatelessWidget {
  const CarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(tabs: [
              Tab(text: 'Dados'),
              Tab(text: "Detelhes"),
              Tab(text: 'Preço')
            ]),
            Expanded(
                child: TabBarView(children: [
                  //Pagina de Dados com seus devidos paremetros
                    CarDadosPage(
                        marca: "Ferrari",
                        ano: "2026",
                        tipo: "Eletronico",
                        quilometragem: "0 Km",
                        cambio: "Automatico",
                        placa: "xl44r8",
                        combustivel: "flex"
                    ),
                    // Tela de Detalhe com seus devidos paremetros
                    CarDetalhePage(
                        estado: "Com um pequeno arranhado no parabrisa",
                        acabamento: "Bancos feitos a couro de jabuti",
                        acessorio: "Boneco funco pop colado no painel",
                        proprietario: "Jorge Amaral",
                        troca: "Sim",
                        infoOpiconal: "As vezes da umas engasgadas na hora de ligar"
                    ),
                    // Tela de Preço com seu parematros
                    CarPrecoPage(preco: "R\$3999")
                  /// TODOS OS PAREMATROS SÃO OBRIGATORIOS
                  ]
                )
            ),
          ],
        )
    );
  }
}

