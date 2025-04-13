import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../models/product.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String selectedCategory = 'All';
  double minPrice = 0;
  double maxPrice = 2000;
  RangeValues priceRange = const RangeValues(0, 2000);

  List<String> get categories {
    final Set<String> uniqueCategories = {'All'};
    uniqueCategories.addAll(products.map((p) => p.category));
    return uniqueCategories.toList();
  }

  List<Product> get filteredProducts {
    return products.where((product) {
      final matchesCategory =
          selectedCategory == 'All' || product.category == selectedCategory;
      final matchesPrice =
          product.price >= priceRange.start && product.price <= priceRange.end;
      return matchesCategory && matchesPrice;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DropdownSearch<String>(
                  popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                  ),
                  items: (filter, cs) => categories,
                  selectedItem: selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value ?? 'All';
                    });
                  },
                  dropdownBuilder: (context, selectedItem) {
                    return Text(selectedItem ?? 'Select a category');
                  },
                ),
                const SizedBox(height: 16),
                RangeSlider(
                  values: priceRange,
                  min: minPrice,
                  max: maxPrice,
                  divisions: 20,
                  labels: RangeLabels(
                    '\$${priceRange.start.round()}',
                    '\$${priceRange.end.round()}',
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      priceRange = values;
                    });
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  'Price Range: \$${priceRange.start.round()} - \$${priceRange.end.round()}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        product.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(product.name),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(product.rating.toString()),
                      ],
                    ),
                    onTap: () {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.bottomSlide,
                        title: product.name,
                        desc: 'Price: \$${product.price.toStringAsFixed(2)}\n'
                            'Category: ${product.category}\n'
                            'Rating: ${product.rating}',
                        btnOkOnPress: () {},
                      ).show();
                    },
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
