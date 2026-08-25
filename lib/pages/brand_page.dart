import 'package:flutter/material.dart';
import 'package:appcarro/models.dart';

class BrandPage extends StatefulWidget {
  const BrandPage({super.key, required this.brands});

  final List<Brand> brands;

  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _addBrand() {
    final name = _nameController.text.trim();
    final country = _countryController.text.trim();
    if (name.isEmpty || country.isEmpty) return;

    setState(() {
      widget.brands.add(Brand(name: name, country: country));
      _nameController.clear();
      _countryController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Cadastro de marca', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nome', border: OutlineInputBorder(), prefixIcon: Icon(Icons.sell))),
          const SizedBox(height: 12),
          TextField(controller: _countryController, decoration: const InputDecoration(labelText: 'País', border: OutlineInputBorder(), prefixIcon: Icon(Icons.public))),
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: _addBrand, icon: const Icon(Icons.add), label: const Text('Adicionar marca'))),
          const SizedBox(height: 20),
          const Text('Marcas cadastradas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Expanded(child: ListView.builder(itemCount: widget.brands.length, itemBuilder: (context, index) {
            final brand = widget.brands[index];
            return Card(child: ListTile(leading: const Icon(Icons.sell), title: Text(brand.name), subtitle: Text(brand.country)));
          })),
        ],
      ),
    );
  }
}