import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:appcarro/pages/home_page.dart';
import 'package:appcarro/pages/category_page.dart';
import 'package:appcarro/pages/store_page.dart';
import 'package:appcarro/pages/car_page.dart';
import 'package:appcarro/pages/brand_page.dart';
import 'package:appcarro/pages/nickname_page.dart';
import 'package:appcarro/models.dart';

const supabaseUrl = 'https://jfunolmzqxubvxxzqzxm.supabase.co';
const supabasePublishableKey = 'sb_publishable_a5TsScC6FwjjR_RNsiDJiA_ufslFAlG';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, publishableKey: supabasePublishableKey);
  final preferences = await SharedPreferences.getInstance();
  final nickname = preferences.getString('nickname');
  runApp(MainApp(initialNickname: nickname));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, this.initialNickname});

  final String? initialNickname;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ElevenCar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AppHomeScreen(initialNickname: initialNickname),
    );
  }
}

class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({super.key, this.initialNickname});

  final String? initialNickname;

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  int _selectedIndex = 0;
  late String? _nickname = widget.initialNickname;
  final List<Category> _categories = [];
  final List<Brand> _brands = [];
  final List<Store> _stores = [];
  final List<Car> _cars = [];

  @override
  void initState() {
    super.initState();
    if (_nickname == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Defina o nickname do usuário para começar.')));
        }
      });
    }
  }

  List<String> get _titles => ['elevenCar', 'Categorias', 'Marcas', 'Lojas', 'Carros', 'Usuário'];

  List<Widget> get _pages => [
        const HomePage(),
        CategoryPage(categories: _categories, nickname: _nickname),
        BrandPage(brands: _brands, nickname: _nickname),
        StorePage(stores: _stores, nickname: _nickname),
        CarPage(cars: _cars, categories: _categories, brands: _brands, stores: _stores, nickname: _nickname),
        NicknamePage(nickname: _nickname, onSaved: (value) => setState(() => _nickname = value)),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'elevenCar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Cadastro de revenda de carros',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              selected: _selectedIndex == 0,
              onTap: () {
                setState(() => _selectedIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(_nickname == null ? 'Definir usuário' : 'Usuário: $_nickname'),
              selected: _selectedIndex == 5,
              onTap: () {
                setState(() => _selectedIndex = 5);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categoria'),
              selected: _selectedIndex == 1,
              onTap: () {
                setState(() => _selectedIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.sell),
              title: const Text('Marcas'),
              selected: _selectedIndex == 2,
              onTap: () {
                setState(() => _selectedIndex = 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Lojas'),
              selected: _selectedIndex == 3,
              onTap: () {
                setState(() => _selectedIndex = 3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text('Carros'),
              selected: _selectedIndex == 4,
              onTap: () {
                setState(() => _selectedIndex = 4);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
