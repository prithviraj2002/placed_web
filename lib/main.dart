import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:placed_web/modules/home_module/view/home.dart';
import 'package:placed_web/page_bindings/bindings.dart';
import 'page_bindings/page_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: pages,
      initialBinding: PageBindings(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}


