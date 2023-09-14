import 'package:ecommerce_app/cart/bloc/carton_bloc.dart';
import 'package:ecommerce_app/home/home_page.dart';
import 'package:ecommerce_app/injector.dart';
import 'package:ecommerce_app/login/bloc/login_bloc.dart';
import 'package:ecommerce_app/login/ui/login_screen.dart';
import 'package:ecommerce_app/order/bloc/order_bloc.dart';
import 'package:ecommerce_app/search/bloc/search_bloc.dart';
// import 'package:ecommerce_app/products/ui/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([setupLocator()]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(),
          ),
          BlocProvider(
            create: (context) => SearchBloc(),
          ),
          BlocProvider(
            create: (context) => CartonBloc(),
          ),
          BlocProvider(
            create: (context) => OrderBloc(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'OpenSans'),
          home: token == null ? LoginScreen() : Home(),
        )),
  );
}

// class MyApp extends StatelessWidget {
//   final String? token;
//   const MyApp({super.key, this.token});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(fontFamily: 'OpenSans'),
//       home: MultiBlocProvider(
//         providers: [
//           BlocProvider(
//             create: (context) => LoginBloc(),
//           ),
//         ],
//         child: LoginScreen(),
//       ),
//     );
//   }
// }
