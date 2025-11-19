import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../models/product_entry.dart';
import '../utils/constants.dart';
import '../widgets/left_drawer.dart';
import '../widgets/product_entry_card.dart';
import 'product_detail.dart';

enum ProductFilter { all, mine }

extension ProductFilterLabel on ProductFilter {
  String get label => switch (this) {
        ProductFilter.all => 'Semua',
        ProductFilter.mine => 'Punya Saya',
      };

  IconData get icon => switch (this) {
        ProductFilter.all => Icons.public,
        ProductFilter.mine => Icons.person,
      };
}

class ProductListPage extends StatefulWidget {
  final ProductFilter initialFilter;

  const ProductListPage({super.key, this.initialFilter = ProductFilter.all});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductFilter _selectedFilter;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter;
  }

  Future<List<ProductEntry>> fetchProducts(
      CookieRequest request, ProductFilter filter) async {
    final url = filter == ProductFilter.all
        ? ApiConfig.productsUrl
        : ApiConfig.myProductsUrl;

    final response = await request.get(url);

    if (response is List) {
      return response.map((item) => ProductEntry.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat produk. Pastikan Anda sudah login.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      drawer: const LeftDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: SegmentedButton<ProductFilter>(
              segments: ProductFilter.values
                  .map(
                    (filter) => ButtonSegment<ProductFilter>(
                      value: filter,
                      label: Text(filter.label),
                      icon: Icon(filter.icon),
                    ),
                  )
                  .toList(),
              selected: <ProductFilter>{_selectedFilter},
              showSelectedIcon: false,
              onSelectionChanged: (selection) {
                setState(() {
                  _selectedFilter = selection.first;
                });
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: FutureBuilder<List<ProductEntry>>(
                future: fetchProducts(request, _selectedFilter),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          snapshot.error.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  }

                  final products = snapshot.data ?? [];

                  if (products.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text(
                          'Belum ada produk untuk filter ini.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff59A5D8),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (_, index) => ProductEntryCard(
                      product: products[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(product: products[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}