import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualquercoisavinteconto/constants/colors.dart';
import 'package:qualquercoisavinteconto/constants/fonts.dart';
import 'package:qualquercoisavinteconto/constants/routes.dart';
import 'package:qualquercoisavinteconto/providers/auth_provider.dart';
import 'package:qualquercoisavinteconto/widgets/background_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const profileButtonsList = ["Meus Endereços", "Meus Pedidos", "Outros"];
    final provider = Provider.of<AuthProvider>(context, listen: false);
    return backgroundWidget(
        child: Scaffold(
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.05).heightBox,
            10.heightBox,
            "Olá, ${provider.getCurrentUser()?.name}"
                .text
                .fontFamily(bold)
                .white
                .size(18)
                .make(),
            50.heightBox,
            Column(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const Divider(color: lightGrey);
                    },
                    itemCount: profileButtonsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final buttonText = profileButtonsList[index];
                      return GestureDetector(
                        onTap: () {
                          if (index == 0) Navigator.pushNamed(context, manageAddressRoute);
                          Navigator.pushNamed(context, homeRoute);
                        },
                        child: ListTile(
                          title: Text(
                            buttonText,
                          ),
                        ),
                      );
                    }).box.white.rounded.make()
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 50)
                .make()
          ],
        ),
      ),
    ));
  }
}
