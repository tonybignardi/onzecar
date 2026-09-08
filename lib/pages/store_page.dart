import 'package:flutter/material.dart';
import 'package:appcarro/models.dart';
import 'package:appcarro/supabase_service.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key, required this.stores, required this.nickname});

  final List<Store> stores;
  final String? nickname;

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.nickname != null) _loadStores();
  }

  @override
  void didUpdateWidget(covariant StorePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.nickname != oldWidget.nickname && widget.nickname != null) {
      _loadStores();
    }
  }

  Future<void> _loadStores() async {
    try {
      final items = await SupabaseService.stores(widget.nickname!);
      if (mounted) setState(() { widget.stores..clear()..addAll(items); });
    } catch (error) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao carregar lojas: $error')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _addStore() {
    if (widget.nickname == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Defina o nickname do usuário primeiro.')));
      return;
    }
    final name = _nameController.text.trim();
    final city = _cityController.text.trim();
    final address = _addressController.text.trim();
    final phone = _phoneController.text.trim();
    if ([name, city, address, phone].any((value) => value.isEmpty)) return;

    final store = Store(name: name, city: city, address: address, phone: phone);
    SupabaseService.addStore(widget.nickname!, store).then((savedStore) {
      if (!mounted) return;
      setState(() {
        widget.stores.add(savedStore);
      _nameController.clear();
      _cityController.clear();
      _addressController.clear();
      _phoneController.clear();
      });
    }).catchError((error) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar loja: $error')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Cadastro de loja', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nome', border: OutlineInputBorder(), prefixIcon: Icon(Icons.store))),
        const SizedBox(height: 12),
        TextField(controller: _cityController, decoration: const InputDecoration(labelText: 'Cidade', border: OutlineInputBorder(), prefixIcon: Icon(Icons.location_city))),
        const SizedBox(height: 12),
        TextField(controller: _addressController, decoration: const InputDecoration(labelText: 'Endereço', border: OutlineInputBorder(), prefixIcon: Icon(Icons.location_on))),
        const SizedBox(height: 12),
        TextField(controller: _phoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Telefone', border: OutlineInputBorder(), prefixIcon: Icon(Icons.phone))),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: _addStore, icon: const Icon(Icons.add), label: const Text('Adicionar loja'))),
        const SizedBox(height: 20),
        const Text('Lojas cadastradas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Expanded(child: ListView.builder(itemCount: widget.stores.length, itemBuilder: (context, index) {
          final store = widget.stores[index];
          return Card(child: ListTile(leading: const Icon(Icons.store), title: Text(store.name), subtitle: Text('${store.city} - ${store.address}\n${store.phone}')));
        })),
      ]),
    );
  }
}