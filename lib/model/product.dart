class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rate;
  final int rating_count;

  Product(
      {this.id = 0,
      this.title = '',
      this.price = 0,
      this.description = '',
      this.category = '',
      this.image = '',
      this.rate = 0,
      this.rating_count = 0});

  factory Product.fromJson(Map<String, dynamic> json) {
    var responseRating = json['rating'] ?? [];
    return Product(
        id: json['id'],
        title: json['title'] ?? '',
        price: json['price'].toDouble() ?? 0,
        description: json['description'] ?? '',
        category: json['category'] ?? '',
        image: json['image'] ?? '',
        rate: json['rate'] != null
            ? json['rate'].toDouble()
            : responseRating['rate'].toDouble() ?? 0,
        rating_count: json['rating_count'] != null
            ? json['rating_count']
            : responseRating['count'] ?? 0);
  }

  Map<String, dynamic> toJson(Product product) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = product.id;
    data['title'] = product.title;
    data['price'] = product.price;
    data['description'] = product.description;
    data['category'] = product.category;
    data['image'] = product.image;
    data['rate'] = product.rate;
    data['rating_count'] = product.rating_count;

    return data;
  }
}
