import 'package:flutter/material.dart';
import 'package:appcarro/models.dart';
import 'package:appcarro/supabase_service.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.categories, required this.nickname});

  final List<Category> categories;
  final String? nickname;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.nickname != null) _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      final items = await SupabaseService.categories(widget.nickname!);
      if (mounted) setState(() { widget.categories..clear()..addAll(items); });
    } catch (error) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao carregar categorias: $error')));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _addCategory() {
    if (widget.nickname == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Defina o nickname do usuário primeiro.')));
      return;
    }
    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim();
    if (name.isEmpty || description.isEmpty) {
      return;
    }

    final category = Category(name: name, description: description);
    SupabaseService.addCategory(widget.nickname!, category).then((_) {
      if (!mounted) return;
      setState(() {
        widget.categories.add(category);
        _nameController.clear();
        _descriptionController.clear();
      });
    }).catchError((error) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar categoria: $error')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cadastro de categoria',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nome da categoria',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.category),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Descrição',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _addCategory,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar categoria'),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Categorias cadastradas',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.label_important),
                    title: Text(widget.categories[index].name),
                    subtitle: Text(widget.categories[index].description),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
