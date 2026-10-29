
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../favorit_provider.dart';
import 'katalog_page.dart';
import 'lokasi_page.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ecomart'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.eco,
                size: 100,
                color: Colors.green,
              ),
              const SizedBox(height: 20),
              const Text(
                'Ecomart-Produk Daur Ulang',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Ecomart menghasilkan berbagai produk '
                'Untuk membantu pemasaran produk tersebut '
                'Temukan produk favoritmu dan belanja dengan mudah!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              // Jumlah favorit menggunakan Provider
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Consumer<FavoritProvider>(
                    builder: (context, favorit, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Total Favorit: ${favorit.jumlahFavorit}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Navigasi ke katalog
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KatalogPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_bag),
                  label: const Text('Lihat Katalog'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Navigasi ke Google Maps
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LokasiPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.location_on),
                  label: const Text('Lokasi Komunitas'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
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
