import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NicknamePage extends StatefulWidget {
  const NicknamePage({super.key, required this.nickname, required this.onSaved});

  final String? nickname;
  final ValueChanged<String> onSaved;

  @override
  State<NicknamePage> createState() => _NicknamePageState();
}

class _NicknamePageState extends State<NicknamePage> {
  late final TextEditingController _controller = TextEditingController(text: widget.nickname ?? '');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final nickname = _controller.text.trim();
    if (nickname.isEmpty || nickname.contains(RegExp(r'\s'))) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Informe um nickname sem espaços.')));
      return;
    }
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('nickname', nickname);
    widget.onSaved(nickname);
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Usuário salvo.')));
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Usuário', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(controller: _controller, decoration: const InputDecoration(labelText: 'Nickname', helperText: 'Use apenas um nome sem espaços.', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person))),
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: _save, icon: const Icon(Icons.save), label: const Text('Salvar usuário'))),
        ]),
      );
}