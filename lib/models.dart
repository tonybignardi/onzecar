class Category {
  Category({this.id, required this.name, required this.description});

  final int? id;
  final String name;
  final String description;
}

class Brand {
  Brand({this.id, required this.name, required this.country});

  final int? id;
  final String name;
  final String country;
}

class Store {
  Store({
    this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.phone,
  });

  final int? id;
  final String name;
  final String city;
  final String address;
  final String phone;
}

class Car {
  Car({
    this.id,
    required this.model,
    required this.year,
    required this.color,
    required this.price,
    required this.mileage,
    required this.category,
    required this.brand,
    required this.store,
  });

  final int? id;
  final String model;
  final int year;
  final String color;
  final double price;
  final int mileage;
  final Category category;
  final Brand brand;
  final Store store;
}
