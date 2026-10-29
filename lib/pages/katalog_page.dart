
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../favorit_provider.dart';
import '../keranjang_cubit.dart';
import 'form_pemesanan_page.dart';

class KatalogPage extends StatefulWidget {
  const KatalogPage({super.key});

  @override
  State<KatalogPage> createState() => _KatalogPageState();
}

class _KatalogPageState extends State<KatalogPage> {
  final List<Map<String, dynamic>> produk = [
    {
      'nama': 'Pupuk Kompos Organik',
      'deskripsi': 'Pupuk untuk numbuhin tumbuhanmu',
      'harga': 15000,
      'jumlah': 1,
      'ikon': Icons.local_florist,
    },
    {
      'nama': 'Pot Tanaman Daur Ulang',
      'deskripsi': 'Pot sederhana untuk tanaman kesayanganmu.',
      'harga': 25000,
      'jumlah': 1,
      'ikon': Icons.yard,
    },
    {
      'nama': 'Tas Kemasan Daur Ulang',
      'deskripsi': 'Tas kemasan untuk daur ulang',
      'harga': 35000,
      'jumlah': 1,
      'ikon': Icons.shopping_bag,
    },
  ];

  String formatRupiah(int harga) {
    return 'Rp${harga.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        )}';
  }

  void tambahKeKeranjang(Map<String, dynamic> item) {
    final int jumlah = item['jumlah'] as int;

    for (int i = 0; i < jumlah; i++) {
      context.read<KeranjangCubit>().tambahKeranjang();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$jumlah ${item['nama']} ditambahkan ke keranjang',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Produk'),
        actions: [
          Consumer<FavoritProvider>(
            builder: (context, favorit, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${favorit.jumlahFavorit}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: produk.length,
        itemBuilder: (context, index) {
          final item = produk[index];

          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.green.shade100,
                        child: Icon(
                          item['ikon'] as IconData,
                          size: 32,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['nama'] as String,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(item['deskripsi'] as String),
                            const SizedBox(height: 8),
                            Text(
                              formatRupiah(item['harga'] as int),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 28),

                  // Mengatur jumlah produk
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Jumlah produk',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (item['jumlah'] > 1) {
                                  item['jumlah']--;
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline,
                            ),
                            color: Colors.red,
                          ),
                          Text(
                            '${item['jumlah']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                item['jumlah']++;
                              });
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                            ),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Menambahkan produk ke favorit
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context
                            .read<FavoritProvider>()
                            .tambahFavorit();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${item['nama']} ditambahkan ke favorit',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: const Icon(Icons.favorite),
                      label: const Text('Tambah Favorit'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Menambahkan produk ke keranjang
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => tambahKeKeranjang(item),
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('Tambah ke Keranjang'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // Ringkasan keranjang menggunakan Cubit
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<KeranjangCubit, int>(
                builder: (context, jumlahBarang) {
                  return Card(
                    color: Colors.green.shade50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.shopping_cart,
                            color: Colors.green,
                            size: 28,
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Keranjang Belanja',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: jumlahBarang > 0
                                ? () {
                                    context
                                        .read<KeranjangCubit>()
                                        .kurangiKeranjang();
                                  }
                                : null,
                            icon: const Icon(
                              Icons.remove_circle_outline,
                            ),
                            color: Colors.red,
                          ),
                          Text(
                            '$jumlahBarang',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<KeranjangCubit>()
                                  .tambahKeranjang();
                            },
                            icon: const Icon(Icons.add_circle),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),

              // Menuju halaman pemesanan
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const FormPemesananPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.receipt_long),
                  label: const Text('Form Pemesanan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
