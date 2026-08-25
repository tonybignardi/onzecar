class Category {
  Category({required this.name, required this.description});

  final String name;
  final String description;
}

class Brand {
  Brand({required this.name, required this.country});

  final String name;
  final String country;
}

class Store {
  Store({
    required this.name,
    required this.city,
    required this.address,
    required this.phone,
  });

  final String name;
  final String city;
  final String address;
  final String phone;
}

class Car {
  Car({
    required this.model,
    required this.year,
    required this.color,
    required this.price,
    required this.mileage,
    required this.category,
    required this.brand,
    required this.store,
  });

  final String model;
  final int year;
  final String color;
  final double price;
  final int mileage;
  final Category category;
  final Brand brand;
  final Store store;
}
