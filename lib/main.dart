import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualquercoisavinteconto/constants/application.dart';
import 'package:qualquercoisavinteconto/constants/fonts.dart';
import 'package:qualquercoisavinteconto/constants/routes.dart';
import 'package:qualquercoisavinteconto/providers/auth_provider.dart';
import 'package:qualquercoisavinteconto/providers/catalog_provider.dart';
import 'package:qualquercoisavinteconto/screens/home_screen.dart';
import 'package:qualquercoisavinteconto/screens/signin_screen.dart';
import 'package:qualquercoisavinteconto/screens/signup_screen.dart';
import 'package:qualquercoisavinteconto/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CatalogProvider()),
          ChangeNotifierProvider(create: (context) => AuthProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: applicationName,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.transparent,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
            ),
            fontFamily: regular,
            useMaterial3: true,
          ),
          home: const SplashScreen(),
          routes: {
            signInRoute: (ctx) => const SignInScreen(),
            signUpRoute: (ctx) => const SignUpScreen(),
            homeRoute: (ctx) => const HomeScreen()
          },
        ));
  }
}
