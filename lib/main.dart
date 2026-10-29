
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorit_provider.dart';
import 'keranjang_cubit.dart';
import 'pages/beranda_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritProvider(),
      child: BlocProvider(
        create: (context) => KeranjangCubit(),
        child: const EcomartApp(),
      ),
    ),
  );
}

class EcomartApp extends StatelessWidget {
  const EcomartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecomart',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const BerandaPage(),
    );
  }
}
