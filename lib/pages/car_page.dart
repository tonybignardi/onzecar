import 'package:flutter/material.dart';

class CarPage extends StatefulWidget {
  const CarPage({super.key});

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  final TextEditingController _valorCarro = TextEditingController();
  final TextEditingController _condPagamento = TextEditingController();
  final TextEditingController _condDocumentos = TextEditingController();

  String precoCarro = '';
  String pagamento = '';
  String documentacao = '';

  void _salvarDados() {
    setState(() {
      precoCarro = _valorCarro.text;
      pagamento = _condPagamento.text;
      documentacao = _condDocumentos.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dados salvos com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
              labelColor: Color(0xFF3074FF),
              unselectedLabelColor: Color(0xFF3074FF),
              indicatorColor: Color(0xFF3074FF),
              tabs: [
                Tab(text: 'Principal'),
                Tab(text: 'Detalhes'),
                Tab(
                  text: 'Preços',
                )
              ]),
          Expanded(
              child: TabBarView(children: [
            const Text('1-TELA PRINCIPAL'),
            const Text('2-TELA DETALHES'),
            Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text('Valor de venda do anúncio:',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: _valorCarro,
                    cursorColor: const Color(0xFF5B8DFF),
                    keyboardType: const TextInputType.numberWithOptions(),
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF5B8DFF))),
                      hintText: 'R\$ 0.00',
                      prefixIcon: Icon(Icons.attach_money_outlined),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text('Condições de pagamento:',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: _condPagamento,
                    cursorColor: const Color(0xFF5B8DFF),
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF5B8DFF))),
                      hintText: 'aceita troca/financiamento',
                      prefixIcon: Icon(Icons.payment),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text('Situação dos documentos:',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: _condDocumentos,
                    cursorColor: const Color(0xFF5B8DFF),
                    maxLines: 1,
                    decoration: const InputDecoration(  
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF5B8DFF))),
                      hintText: 'IPVA pago',
                      prefixIcon: Icon(Icons.edit_document),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5B8DFF)),
                          onPressed: _salvarDados,
                          child: const Text(
                            'Salvar',
                            style: TextStyle(color: Color(0xFFEFF3F9)),
                          ))),
                )
              ],
            )
          ]))
        ],
      ),
    );
  }
}