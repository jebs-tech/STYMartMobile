import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../widgets/left_drawer.dart';
import 'menu.dart';
import '../utils/constants.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  double _price = 0;
  String _description = "";
  String? _thumbnail;
  String _category = "";
  bool _promo = false;
  bool _isFeatured = false;
  int _stock = 0;
  String? _color;
  String? _size;

  final List<String> _sizeOptions = ['S', 'M', 'L', 'XL', 'tidak ada'];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Produk Baru"),
        backgroundColor: Colors.blue,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NAMA PRODUK
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nama Produk",
                  hintText: "Masukkan nama produk",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama produk tidak boleh kosong!";
                  }
                  if (value.length < 3) {
                    return "Nama produk minimal 3 karakter!";
                  }
                  if (value.length > 100) {
                    return "Nama produk maksimal 100 karakter!";
                  }
                  return null;
                },
                onChanged: (value) => _name = value,
              ),
              const SizedBox(height: 16),

              // HARGA
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Harga (Rp)",
                  hintText: "Masukkan harga produk",
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Harga tidak boleh kosong!";
                  }
                  final number = double.tryParse(value);
                  if (number == null) {
                    return "Harga harus berupa angka!";
                  }
                  if (number < 0) {
                    return "Harga tidak boleh negatif!";
                  }
                  return null;
                },
                onChanged: (value) => _price = double.tryParse(value) ?? 0,
              ),
              const SizedBox(height: 16),

              // STOK
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Stok Produk",
                  hintText: "Masukkan jumlah stok produk",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Stok tidak boleh kosong!";
                  }
                  final number = int.tryParse(value);
                  if (number == null) {
                    return "Stok harus berupa angka!";
                  }
                  if (number < 0) {
                    return "Stok tidak boleh negatif!";
                  }
                  return null;
                },
                onChanged: (value) => _stock = int.tryParse(value) ?? 0,
              ),
              const SizedBox(height: 16),

              // DESKRIPSI
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Deskripsi Produk",
                  hintText: "Masukkan deskripsi produk",
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
                  }
                  if (value.length < 10) {
                    return "Deskripsi minimal 10 karakter!";
                  }
                  if (value.length > 500) {
                    return "Deskripsi terlalu panjang (maks 500 karakter)!";
                  }
                  return null;
                },
                onChanged: (value) => _description = value,
              ),
              const SizedBox(height: 16),

              // KATEGORI
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Kategori Produk",
                  hintText: "Masukkan kategori produk",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Kategori tidak boleh kosong!";
                  }
                  if (value.length > 50) {
                    return "Kategori maksimal 50 karakter!";
                  }
                  return null;
                },
                onChanged: (value) => _category = value,
              ),
              const SizedBox(height: 16),

              // THUMBNAIL
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "URL Thumbnail (opsional)",
                  hintText: "Masukkan link gambar produk (http/https)",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  final urlPattern =
                      r'^(http|https):\/\/([\w\-]+(\.[\w\-]+)+)([\w\-,@?^=%&:/~+#]*[\w\-,@?^=%&/~+#])?$';
                  if (!RegExp(urlPattern).hasMatch(value)) {
                    return "Masukkan URL yang valid (http/https)!";
                  }
                  return null;
                },
                onChanged: (value) => _thumbnail = value,
              ),
              const SizedBox(height: 16),

              // WARNA
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Warna Produk (opsional)",
                  hintText: "Masukkan warna produk",
                ),
                validator: (value) {
                  if (value != null && value.length > 30) {
                    return "Nama warna maksimal 30 karakter!";
                  }
                  return null;
                },
                onChanged: (value) => _color = value,
              ),
              const SizedBox(height: 16),

              // SIZE DROPDOWN
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Ukuran Produk",
                ),
                items: _sizeOptions
                    .map((size) =>
                        DropdownMenuItem(value: size, child: Text(size)))
                    .toList(),
                value: _size,
                onChanged: (value) {
                  setState(() {
                    _size = value;
                  });
                },
                validator: (value) =>
                    value == null ? "Pilih ukuran produk!" : null,
              ),
              const SizedBox(height: 16),

              // PROMO SWITCH
              SwitchListTile(
                title: const Text("Produk Promo"),
                value: _promo,
                onChanged: (bool value) {
                  setState(() {
                    _promo = value;
                  });
                },
              ),
              const SizedBox(height: 8),

              // FEATURED SWITCH
              SwitchListTile(
                title: const Text("Produk Unggulan (Featured)"),
                value: _isFeatured,
                onChanged: (bool value) {
                  setState(() {
                    _isFeatured = value;
                  });
                },
              ),
              const SizedBox(height: 24),

              // TOMBOL SAVE
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                     final response = await request.postJson(
                       ApiConfig.createProductUrl,
                       jsonEncode({
                        "name": _name,
                        "price": _price,
                        "description": _description,
                        "thumbnail": _thumbnail ?? "",
                        "category": _category,
                        "promo": _promo,
                        "is_featured": _isFeatured,
                        "stock": _stock,
                        "color": _color ?? "",
                        "size": _size ?? "",
                      }),
                    );

                    if (!context.mounted) return;

                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Produk berhasil disimpan!"),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            response['message'] ??
                                "Terdapat kesalahan, silakan coba lagi.",
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}