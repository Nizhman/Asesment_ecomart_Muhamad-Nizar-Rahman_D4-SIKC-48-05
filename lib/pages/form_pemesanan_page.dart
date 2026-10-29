
import 'package:flutter/material.dart';

class FormPemesananPage extends StatefulWidget {
  const FormPemesananPage({super.key});

  @override
  State<FormPemesananPage> createState() =>
      _FormPemesananPageState();
}

class _FormPemesananPageState extends State<FormPemesananPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController namaController =
      TextEditingController();

  final TextEditingController alamatController =
      TextEditingController();

  String metodePengiriman = 'Diantar';
  bool setuju = false;

  @override
  void dispose() {
    namaController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  void kirimPesanan() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!setuju) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Silakan setujui syarat pemesanan terlebih dahulu.',
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Pesanan berhasil dibuat',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pemesanan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Icon(
                  Icons.receipt_long,
                  size: 70,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Data Pemesanan',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Nama Pembeli',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama pemesan wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              const Text(
                'alamat pengiriman',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: alamatController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan Alamat',
                  prefixIcon: Icon(Icons.map),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Alamat wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              const Text(
                'Metode Pengiriman',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              RadioListTile<String>(
                title: const Text('Diantar'),
                value: 'Diantar',
                groupValue: metodePengiriman,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    metodePengiriman = value!;
                  });
                },
              ),

              RadioListTile<String>(
                title: const Text('Ambil di Tempat'),
                value: 'Ambil di Tempat',
                groupValue: metodePengiriman,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    metodePengiriman = value!;
                  });
                },
              ),

              const SizedBox(height: 12),

              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'Saya menyetujui pemesanan ini.',
                ),
                value: setuju,
                activeColor: Colors.green,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    setuju = value ?? false;
                  });
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: kirimPesanan,
                  icon: const Icon(Icons.send),
                  label: const Text('Pesan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
