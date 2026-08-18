import 'package:flutter/material.dart';

class CarCadastroPage extends StatefulWidget {
  const CarCadastroPage({
    super.key,
  });

  @override
  State<CarCadastroPage> createState() => _CarCadastroPageState();
}

class _CarCadastroPageState extends State<CarCadastroPage> {
  // Chave do formulário
  final _formchave = GlobalKey<FormState>();

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

  // Envio do formulário
  void enviarFormulario() {
    if (!_formchave.currentState!.validate()) {
      return;
    }

    setState(() {
      enviado = true;
    });

    // Aqui futuramente você pode enviar os dados para sua API.
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entre em contato'),
      ),

      body: Form(
        key: _formchave,

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [

              // =========================
              // DADOS DO CARRO
              // =========================

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Dados do veículo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Marca
              TextFormField(
                controller: marcaController,
                decoration: const InputDecoration(
                  labelText: 'Marca *',
                ),
                validator: (v) =>
                    validacao(v, 'Digite a marca'),
              ),

              SizedBox(height: padd),

              // Ano
              TextFormField(
                controller: anoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Ano *',
                ),
                validator: (v) =>
                    validacao(v, 'Digite o ano'),
              ),

              SizedBox(height: padd),

              // Tipo
              TextFormField(
                controller: tipoController,
                decoration: const InputDecoration(
                  labelText: 'Tipo *',
                ),
                validator: (v) =>
                    validacao(v, 'Digite o tipo do veículo'),
              ),

              SizedBox(height: padd),

              // Quilometragem
              TextFormField(
                controller: quilometragemController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quilometragem *',
                ),
                validator: (v) =>
                    validacao(v, 'Digite a quilometragem'),
              ),

              SizedBox(height: padd),

              // Câmbio
              TextFormField(
                controller: cambioController,
                decoration: const InputDecoration(
                  labelText: 'Câmbio *',
                ),
                validator: (v) =>
                    validacao(v, 'Digite o câmbio'),
              ),

              SizedBox(height: padd),

              // Placa
              TextFormField(
                controller: placaController,
                decoration: const InputDecoration(
                  labelText: 'Placa *',
                ),
                validator: (v) =>
                    validacao(v, 'Digite a placa'),
              ),

              SizedBox(height: padd),

              // Combustível
              TextFormField(
                controller: combustivelController,
                decoration: const InputDecoration(
                  labelText: 'Combustível *',
                ),
                validator: (v) =>
                    validacao(v, 'Digite o combustível'),
              ),

              SizedBox(height: padd),

              // Estado
              TextFormField(
                controller: estadoController,
                decoration: const InputDecoration(
                  labelText: 'Estado *',
                ),
                validator: (v) =>
                    validacao(v, 'Digite o estado'),
              ),

              SizedBox(height: padd),

              // Acabamento
              TextFormField(
                controller: acabamentoController,
                decoration: const InputDecoration(
                  labelText: 'Acabamento *',
                ),
                validator: (v) =>
                    validacao(v, 'Digite o acabamento'),
              ),

              SizedBox(height: padd),

              // Acessório
              TextFormField(
                controller: acessorioController,
                decoration: const InputDecoration(
                  labelText: 'Acessório *',
                ),
                validator: (v) =>
                    validacao(v, 'Digite os acessórios'),
              ),

              SizedBox(height: padd),

              // Proprietário
              TextFormField(
                controller: proprietarioController,
                decoration: const InputDecoration(
                  labelText: 'Proprietário *',
                ),
                validator: (v) =>
                    validacao(v, 'Digite o proprietário'),
              ),

              SizedBox(height: padd),

              // Troca
              TextFormField(
                controller: trocaController,
                decoration: const InputDecoration(
                  labelText: 'Troca *',
                ),
                validator: (v) =>
                    validacao(v, 'Informe se aceita troca'),
              ),

              SizedBox(height: padd),

              // Informações opcionais
              TextFormField(
                controller: infoOpicionalController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Informações opcionais',
                  alignLabelWithHint: true,
                ),
              ),

              SizedBox(height: padd),

              // Preço
              TextFormField(
                controller: precoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Preço *',
                  prefixText: 'R\$ ',
                ),
                validator: (v) =>
                    validacao(v, 'Digite o preço'),
              ),

              const SizedBox(height: 30),

              // =========================
              // PROPOSTA
              // =========================

              TextFormField(
                controller: mensagemController,
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: 'Sua proposta *',
                  alignLabelWithHint: true,
                ),
                validator: (v) =>
                    validacao(v, 'Digite sua proposta'),
              ),

              const SizedBox(height: 24),

              // Botão de envio
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: enviado ? null : enviarFormulario,
                  child: Text(
                    enviado
                        ? 'Enviado'
                        : 'Enviar Proposta',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
