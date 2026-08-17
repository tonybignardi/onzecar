import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Widget com estado (StatefulWidget) para a página de contato/proposta do carro
class CarContactPage extends StatefulWidget {
  const CarContactPage({
    super.key
  });

  @override
  State<CarContactPage> createState() => _CarContactPageState();
}

class _CarContactPageState extends State<CarContactPage> {
  // Chave global necessária para identificar e validar o estado do formulário
  final _formchave = GlobalKey<FormState>();

  // Controladores de texto para capturar as entradas do usuário
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final cepController = TextEditingController();
  final telefoneController = TextEditingController();
  final mensagemController = TextEditingController();

  // Flag para controlar se o formulário já foi submetido (evita múltiplos envios)
  bool enviado = false;

  // Altura padrão de espaçamento entre os campos
  final double padd = 20;

  // Função para reaproveitar a lógica de validação de campos obrigatórios
  String? validacao(dynamic v, String mensagem) {
    if (v == null || v.isEmpty) {
      return mensagem; // Retorna mensagem de erro se o campo estiver vazio
    }
    return null; // Retorna null indicando que é valido
  }

  // Função responsável pelo envio do formulário
  void enviarFormulario() {
    // Dispara as validações do Form, se algum campo for inválido e interrompe o envio
    if (!_formchave.currentState!.validate()) {
      return;
    }

    // Atualiza o estado da tela definindo 'enviado' como true
    setState(() {
      enviado = true;
    });
  }

  // Descarte dos controladores da memória quando a tela for fechada (evita vazamento de memória)
  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    cepController.dispose();
    telefoneController.dispose();
    mensagemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entre em contato'),
      ),
      // Agrupando os campos para permitir validação global
      body: Form(
        key: _formchave,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Campo de nome obrigatório
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                    labelText: 'Nome *'
                ),
                validator: (v) => validacao(v, "Digite seu nome"),
              ),

              const SizedBox(height: 20),

              // Campo de email obrigatório
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: 'Email *'
                ),
                validator: (v) => validacao(v, "Digite seu Email"),
              ),

              SizedBox(height: padd),

              // Campo de telefone opcional
              TextFormField(
                controller: telefoneController,
                decoration: const InputDecoration(
                    labelText: 'Telefone'
                ),
              ),

              SizedBox(height: padd),

              // Campo de CEP opcional
              TextFormField(
                controller: cepController,
                decoration: const InputDecoration(
                    labelText: 'Cep'
                ),
              ),

              SizedBox(height: padd),

              // Campo de proposta (Obrigatório)
              TextFormField(
                controller: mensagemController,
                maxLines: 10,
                decoration: const InputDecoration(
                    labelText: 'Sua proposta *'
                ),
                validator: (v) => validacao(v, "Digite sua proposta"),
              ),

              const SizedBox(height: 24),

              // Botão de Envio (desabilitado quando 'enviado' for true)
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: enviado ? null : enviarFormulario,
                  child: Text(
                      enviado ? 'Enviado' : 'Enviar Proposta'
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
