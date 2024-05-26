import 'package:flutter/material.dart';
import 'package:qualquercoisavinteconto/constants/application.dart';
import 'package:qualquercoisavinteconto/constants/colors.dart';
import 'package:qualquercoisavinteconto/constants/routes.dart';
import 'package:qualquercoisavinteconto/screens/account_screen.dart';
import 'package:qualquercoisavinteconto/screens/catalog_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int paginaAtual = 0;
  PageController pc = PageController(initialPage: 0);

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(applicationName,
            style: TextStyle(
                color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(signInRoute);
              },
              icon: const Icon(Icons.logout, color: lightGrey)),
        ],
      ),
      body: Container(
        color: Colors.grey[200],
        child: PageView(
          controller: pc,
          onPageChanged: setPaginaAtual,
          children: const [CatalogScreen(), AccountScreen()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        currentIndex: paginaAtual,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Minha Conta'),
        ],
        onTap: (pagina) {
          pc.animateToPage(
            pagina,
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}
