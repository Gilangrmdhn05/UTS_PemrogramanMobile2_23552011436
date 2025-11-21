import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/cart_cubit.dart';
import 'pages/cart_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(create: (_) => CartCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Cart App",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: CartHomePage(),
      ),
    );
  }
}
