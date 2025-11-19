import 'package:flutter/material.dart';
import '../models/product_entry.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final fields = product.fields;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             // Display product image if available
             if (fields.thumbnail.isNotEmpty)
               Image.network(
                 fields.thumbnail,
                 width: double.infinity,
                 height: 250,
                 fit: BoxFit.cover,
                 errorBuilder: (context, error, stackTrace) => Container(
                   height: 250,
                   color: Colors.grey[300],
                   child: const Center(
                     child: Icon(Icons.broken_image, size: 50),
                   ),
                 ),
               ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      // Featured and Promo Chips
                      if (fields.isFeatured)
                        _StatusChip(
                          label: 'Featured',
                          icon: Icons.star,
                          color: Colors.amber.shade700,
                        ),
                      if (fields.promo)
                        _StatusChip(
                          label: 'Promo',
                          icon: Icons.local_offer,
                          color: Colors.pink.shade400,
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    fields.name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Rp ${fields.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow('Kategori', fields.category),
                  _buildDetailRow('Stok', '${fields.stock} unit'),
                  _buildDetailRow('Pemilik', 'Pengguna #${fields.user}'),
                  _buildDetailRow('Promo', fields.promo ? 'Ya' : 'Tidak'),
                  _buildDetailRow('Featured', fields.isFeatured ? 'Ya' : 'Tidak'),
                  if (fields.color.isNotEmpty)
                    _buildDetailRow('Warna', fields.color),
                  if (fields.size.isNotEmpty)
                    _buildDetailRow('Ukuran', fields.size),
                  const Divider(height: 32),
                  const Text(
                    'Deskripsi Produk',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    fields.description,
                    style: const TextStyle(
                      fontSize: 16.0,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Kembali ke Daftar Produk'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _StatusChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }
}