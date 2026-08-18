import 'package:flutter/material.dart';

class CarCadastroPage extends StatefulWidget {
  const CarCadastroPage({super.key});

  @override
  State<CarCadastroPage> createState() => _CarCadastroPageState();
}

class _CarCadastroPageState extends State<CarCadastroPage> {
  // Chave do formulário
  final _formchave = GlobalKey<FormState>();

  // =========================
  // CONTROLE DE ETAPAS
  // =========================
  int _etapaAtual = 0;
  final int _totalEtapas = 3;

  // =========================
  // DADOS DO CARRO
  // =========================
  final marcaController = TextEditingController();
  final anoController = TextEditingController();
  final tipoController = TextEditingController();
  final quilometragemController = TextEditingController();
  final cambioController = TextEditingController();
  final placaController = TextEditingController();
  final combustivelController = TextEditingController();
  final estadoController = TextEditingController();
  final acabamentoController = TextEditingController();
  final acessorioController = TextEditingController();
  final proprietarioController = TextEditingController();
  final trocaController = TextEditingController();
  final infoOpicionalController = TextEditingController();
  final precoController = TextEditingController();

  // =========================
  // PROPOSTA
  // =========================
  final mensagemController = TextEditingController();
  bool enviado = false;
  final double padd = 20;

  // Validação dos campos obrigatórios
  String? validacao(String? v, String mensagem) {
    if (v == null || v.trim().isEmpty) {
      return mensagem;
    }
    return null;
  }

  // Avançar para a próxima etapa
  void _proximaEtapa() {
    if (_formchave.currentState!.validate()) {
      if (_etapaAtual < _totalEtapas - 1) {
        setState(() {
          _etapaAtual++;
        });
      } else {
        enviarFormulario();
      }
    }
  }

  // Voltar para a etapa anterior
  void _etapaAnterior() {
    if (_etapaAtual > 0) {
      setState(() {
        _etapaAtual--;
      });
    }
  }

  // Envio do formulário final
  void enviarFormulario() {
    setState(() {
      enviado = true;
    });

    // Aqui futuramente você pode enviar os dados para sua API.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Carro cadastrado com sucesso!')),
    );
  }

  @override
  void dispose() {
    marcaController.dispose();
    anoController.dispose();
    tipoController.dispose();
    quilometragemController.dispose();
    cambioController.dispose();
    placaController.dispose();
    combustivelController.dispose();
    estadoController.dispose();
    acabamentoController.dispose();
    acessorioController.dispose();
    proprietarioController.dispose();
    trocaController.dispose();
    infoOpicionalController.dispose();
    precoController.dispose();
    mensagemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Garante que a etapa nunca passe dos limites visuais
    final etapaExibida = (_etapaAtual + 1).clamp(1, _totalEtapas);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Carros (Etapa $etapaExibida de $_totalEtapas)'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formchave,
                child: Column(
                  children: [
                    // Barra de progresso segura
                    LinearProgressIndicator(
                      value: etapaExibida / _totalEtapas,
                      backgroundColor: Colors.grey[300],
                    ),
                    const SizedBox(height: 20),

                    // Conteúdo dinâmico da etapa atual
                    Expanded(
                      child: SingleChildScrollView(
                        child: _construirEtapaAtual(),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Botões de navegação
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_etapaAtual > 0)
                          OutlinedButton(
                            onPressed: _etapaAnterior,
                            child: const Text('Voltar'),
                          )
                        else
                          const SizedBox.shrink(),

                        FilledButton(
                          onPressed: enviado ? null : _proximaEtapa,
                          child: Text(
                            enviado
                                ? 'Enviado'
                                : (_etapaAtual == _totalEtapas - 1
                                    ? 'Enviar'
                                    : 'Avançar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  // Método que separa os campos por etapa
  Widget _construirEtapaAtual() {
    switch (_etapaAtual) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Identificação do Veículo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: marcaController,
              decoration: const InputDecoration(labelText: 'Marca *'),
              validator: (v) => validacao(v, 'Digite a marca'),
            ),
            SizedBox(height: padd),
            TextFormField(
              controller: anoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Ano *'),
              validator: (v) => validacao(v, 'Digite o ano'),
            ),
            SizedBox(height: padd),
            TextFormField(
              controller: tipoController,
              decoration: const InputDecoration(labelText: 'Tipo *'),
              validator: (v) => validacao(v, 'Digite o tipo do veículo'),
            ),
            SizedBox(height: padd),
            TextFormField(
              controller: placaController,
              decoration: const InputDecoration(labelText: 'Placa *'),
              validator: (v) => validacao(v, 'Digite a placa'),
            ),
          ],
        );

      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Especificações e Detalhes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: quilometragemController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quilometragem *'),
              validator: (v) => validacao(v, 'Digite a quilometragem'),
            ),
            SizedBox(height: padd),
            TextFormField(
              controller: cambioController,
              decoration: const InputDecoration(labelText: 'Câmbio *'),
              validator: (v) => validacao(v, 'Digite o câmbio'),
            ),
            SizedBox(height: padd),
            TextFormField(
              controller: combustivelController,
              decoration: const InputDecoration(labelText: 'Combustível *'),
              validator: (v) => validacao(v, 'Digite o combustível'),
            ),
            SizedBox(height: padd),
            TextFormField(
              controller: estadoController,
              decoration: const InputDecoration(labelText: 'Estado *'),
              validator: (v) => validacao(v, 'Digite o estado'),
            ),
            SizedBox(height: padd),
            TextFormField(
              controller: acabamentoController,
              decoration: const InputDecoration(labelText: 'Acabamento *'),
              validator: (v) => validacao(v, 'Digite o acabamento'),
            ),
          ],
        );

      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Opcionais, Preço e Finalização',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: acessorioController,
              decoration: const InputDecoration(labelText: 'Acessório *'),
              validator: (v) => validacao(v, 'Digite os acessórios'),
            ),
            SizedBox(height: padd),
            TextFormField(
              controller: proprietarioController,
              decoration: const InputDecoration(labelText: 'Proprietário *'),
              validator: (v) => validacao(v, 'Digite o proprietário'),
            ),
            SizedBox(height: padd),
            TextFormField(
              controller: trocaController,
              decoration: const InputDecoration(labelText: 'Troca *'),
              validator: (v) => validacao(v, 'Informe se aceita troca'),
            ),
            SizedBox(height: padd),
            TextFormField(
              controller: infoOpicionalController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Informações opcionais',
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: padd),
            TextFormField(
              controller: precoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Preço *',
                prefixText: 'R\$ ',
              ),
              validator: (v) => validacao(v, 'Digite o preço'),
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
