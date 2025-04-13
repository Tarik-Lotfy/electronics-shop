class Product {
  final String name;
  final double price;
  final String category;
  final double rating;
  final String image;

  Product({
    required this.name,
    required this.price,
    required this.category,
    required this.rating,
    required this.image,
  });
}

// Sample product data
List<Product> products = [
  Product(
    name: "MacBook Pro M2",
    price: 1299.99,
    category: "Laptops",
    rating: 4.8,
    image: "assets/images/macbook.png",
  ),
  Product(
    name: "iPhone 15 Pro",
    price: 999.99,
    category: "Phones",
    rating: 4.7,
    image: "assets/images/iphone.png",
  ),
  Product(
    name: "iPad Pro 12.9",
    price: 1099.99,
    category: "Tablets",
    rating: 4.6,
    image: "assets/images/ipad.png",
  ),
  Product(
    name: "Samsung Galaxy S23 Ultra",
    price: 1199.99,
    category: "Phones",
    rating: 4.7,
    image: "assets/images/samsung.png",
  ),
  Product(
    name: "Dell XPS 15",
    price: 1499.99,
    category: "Laptops",
    rating: 4.8,
    image: "assets/images/dell.png",
  ),
  Product(
    name: "Lenovo IdeaPad Gaming 3",
    price: 1299.99,
    category: "Laptops",
    rating: 4.5,
    image: "assets/images/ideapad.png",
  ),
  Product(
    name: "Google Pixel 8 Pro",
    price: 899.99,
    category: "Phones",
    rating: 4.6,
    image: "assets/images/pixel.png",
  ),
  Product(
    name: "Lenovo ThinkPad X1 Carbon",
    price: 1399.99,
    category: "Laptops",
    rating: 4.7,
    image: "assets/images/lenovo.png",
  ),
];

// Get all unique categories
List<String> getAllCategories() {
  return products.map((product) => product.category).toSet().toList();
}
