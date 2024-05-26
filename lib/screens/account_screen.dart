import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualquercoisavinteconto/constants/colors.dart';
import 'package:qualquercoisavinteconto/constants/fonts.dart';
import 'package:qualquercoisavinteconto/constants/routes.dart';
import 'package:qualquercoisavinteconto/models/user.dart';
import 'package:qualquercoisavinteconto/providers/auth_provider.dart';
import 'package:qualquercoisavinteconto/widgets/background_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileButton {
  String name;
  String route;

  ProfileButton({required this.name, required this.route});
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  List<ProfileButton> createProfileButtons(User? currentUser) {
    List<ProfileButton> buttons = [];

    buttons
        .add(ProfileButton(name: 'Meus Endereços', route: manageAddressRoute));

    if (currentUser != null && currentUser.isAdmin()) {
      buttons.add(
          ProfileButton(name: 'Gerenciar Produtos', route: manageProductRoute));
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final profileButtonsList = createProfileButtons(provider.getCurrentUser());
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
                          Navigator.pushNamed(context, buttonText.route);
                        },
                        child: ListTile(
                          title: Text(
                            buttonText.name,
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
