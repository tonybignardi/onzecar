import 'package:flutter/material.dart';
import 'package:appcarro/models.dart';
import 'package:appcarro/supabase_service.dart';

class CarPage extends StatefulWidget {
  const CarPage({
    super.key,
    required this.cars,
    required this.categories,
    required this.brands,
    required this.stores,
    required this.nickname,
  });

  final List<Car> cars;
  final List<Category> categories;
  final List<Brand> brands;
  final List<Store> stores;
  final String? nickname;

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _colorController = TextEditingController();
  final _priceController = TextEditingController();
  final _mileageController = TextEditingController();
  Category? _category;
  Brand? _brand;
  Store? _store;

  @override
  void initState() {
    super.initState();
    if (widget.nickname != null) _loadCars();
  }

  Future<void> _loadCars() async {
    try {
      final categories = await SupabaseService.categories(widget.nickname!);
      final brands = await SupabaseService.brands(widget.nickname!);
      final stores = await SupabaseService.stores(widget.nickname!);
      final cars = await SupabaseService.cars(widget.nickname!, categories, brands, stores);
      if (!mounted) return;
      setState(() {
        widget.categories..clear()..addAll(categories);
        widget.brands..clear()..addAll(brands);
        widget.stores..clear()..addAll(stores);
        widget.cars..clear()..addAll(cars);
      });
    } catch (error) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao carregar carros: $error')));
    }
  }

  @override
  void dispose() {
    _modelController.dispose();
    _yearController.dispose();
    _colorController.dispose();
    _priceController.dispose();
    _mileageController.dispose();
    super.dispose();
  }

  void _saveCar() {
    if (widget.nickname == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Defina o nickname do usuário primeiro.')));
      return;
    }
    final year = int.tryParse(_yearController.text.trim());
    final price = double.tryParse(_priceController.text.trim().replaceAll(',', '.'));
    final mileage = int.tryParse(_mileageController.text.trim());
    if (_modelController.text.trim().isEmpty ||
        _colorController.text.trim().isEmpty ||
        year == null ||
        price == null ||
        mileage == null ||
        _category == null ||
        _brand == null ||
        _store == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Preencha todos os campos do carro.')));
      return;
    }
    if (_category!.id == null || _brand!.id == null || _store!.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cadastre categoria, marca e loja no banco antes de cadastrar o carro.')));
      return;
    }

    final car = Car(
        model: _modelController.text.trim(),
        year: year,
        color: _colorController.text.trim(),
        price: price,
        mileage: mileage,
        category: _category!,
        brand: _brand!,
        store: _store!,
      );
    SupabaseService.addCar(widget.nickname!, car).then((_) {
      if (!mounted) return;
      setState(() {
        widget.cars.add(car);
        _modelController.clear();
        _yearController.clear();
        _colorController.clear();
        _priceController.clear();
        _mileageController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Carro cadastrado com sucesso!')));
    }).catchError((error) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao salvar carro: $error')));
    });
  }

  InputDecoration _decoration(String label, IconData icon) => InputDecoration(labelText: label, border: const OutlineInputBorder(), prefixIcon: Icon(icon));

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(children: [
        const TabBar(tabs: [Tab(text: 'Principal'), Tab(text: 'Detalhes'), Tab(text: 'Preços')]),
        Expanded(child: TabBarView(children: [
          ListView(padding: const EdgeInsets.all(16), children: [
            TextField(controller: _modelController, decoration: _decoration('Modelo', Icons.directions_car)),
            const SizedBox(height: 12),
            TextField(controller: _yearController, keyboardType: TextInputType.number, decoration: _decoration('Ano', Icons.calendar_today)),
            const SizedBox(height: 12),
            TextField(controller: _colorController, decoration: _decoration('Cor', Icons.color_lens)),
            const SizedBox(height: 12),
            DropdownButtonFormField<Category>(value: _category, decoration: _decoration('Categoria', Icons.category), items: widget.categories.map((item) => DropdownMenuItem(value: item, child: Text(item.name))).toList(), onChanged: (value) => setState(() => _category = value)),
          ]),
          ListView(padding: const EdgeInsets.all(16), children: [
            DropdownButtonFormField<Brand>(value: _brand, decoration: _decoration('Marca', Icons.sell), items: widget.brands.map((item) => DropdownMenuItem(value: item, child: Text(item.name))).toList(), onChanged: (value) => setState(() => _brand = value)),
            const SizedBox(height: 12),
            DropdownButtonFormField<Store>(value: _store, decoration: _decoration('Loja', Icons.store), items: widget.stores.map((item) => DropdownMenuItem(value: item, child: Text(item.name))).toList(), onChanged: (value) => setState(() => _store = value)),
            const SizedBox(height: 12),
            TextField(controller: _mileageController, keyboardType: TextInputType.number, decoration: _decoration('Quilometragem', Icons.speed)),
          ]),
          ListView(padding: const EdgeInsets.all(16), children: [
            TextField(controller: _priceController, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: _decoration('Preço', Icons.attach_money)),
            const SizedBox(height: 16),
            ElevatedButton.icon(onPressed: _saveCar, icon: const Icon(Icons.save), label: const Text('Cadastrar carro')),
            const SizedBox(height: 24),
            const Text('Carros cadastrados', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ...widget.cars.map((car) => Card(child: ListTile(title: Text(car.model), subtitle: Text('${car.brand.name} - ${car.year} | ${car.store.name}\nR\$ ${car.price.toStringAsFixed(2)} | ${car.mileage} km')))),
          ]),
        ])),
      ]),
    );
  }
}