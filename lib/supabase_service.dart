import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:appcarro/models.dart';

class SupabaseService {
  SupabaseService._();

  static final client = Supabase.instance.client;

  static Future<List<Category>> categories(String user) async {
    final rows = await client.from('categorias').select().eq('usuario', user).order('nome');
    return rows.map((row) => Category(id: row['id'] as int?, name: row['nome'] as String, description: row['descricao'] as String)).toList();
  }

  static Future<void> addCategory(String user, Category item) async {
    await client.from('categorias').insert({'nome': item.name, 'descricao': item.description, 'usuario': user});
  }

  static Future<List<Brand>> brands(String user) async {
    final rows = await client.from('marcas').select().eq('usuario', user).order('nome');
    return rows.map((row) => Brand(id: row['id'] as int?, name: row['nome'] as String, country: row['pais'] as String)).toList();
  }

  static Future<void> addBrand(String user, Brand item) async {
    await client.from('marcas').insert({'nome': item.name, 'pais': item.country, 'usuario': user});
  }

  static Future<List<Store>> stores(String user) async {
    final rows = await client.from('lojas').select().eq('usuario', user).order('nome');
    return rows.map((row) => Store(id: row['id'] as int?, name: row['nome'] as String, city: row['cidade'] as String, address: row['endereco'] as String, phone: row['telefone'] as String)).toList();
  }

  static Future<void> addStore(String user, Store item) async {
    await client.from('lojas').insert({'nome': item.name, 'cidade': item.city, 'endereco': item.address, 'telefone': item.phone, 'usuario': user});
  }

  static Future<void> addCar(String user, Car item) async {
    await client.from('carros').insert({
      'modelo': item.model,
      'ano': item.year,
      'cor': item.color,
      'preco': item.price,
      'quilometragem': item.mileage,
      'categoria_id': item.category.id,
      'marca_id': item.brand.id,
      'loja_id': item.store.id,
      'usuario': user,
    });
  }

  static Future<List<Car>> cars(
    String user,
    List<Category> categories,
    List<Brand> brands,
    List<Store> stores,
  ) async {
    final rows = await client.from('carros').select().eq('usuario', user).order('modelo');
    return rows.map((row) {
      final category = categories.firstWhere((item) => item.id == row['categoria_id']);
      final brand = brands.firstWhere((item) => item.id == row['marca_id']);
      final store = stores.firstWhere((item) => item.id == row['loja_id']);
      return Car(
        id: row['id'] as int?,
        model: row['modelo'] as String,
        year: row['ano'] as int,
        color: row['cor'] as String,
        price: (row['preco'] as num).toDouble(),
        mileage: row['quilometragem'] as int,
        category: category,
        brand: brand,
        store: store,
      );
    }).toList();
  }
}