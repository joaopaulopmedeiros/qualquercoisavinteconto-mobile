import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qualquercoisavinteconto/constants/application.dart';
import 'package:qualquercoisavinteconto/constants/colors.dart';
import 'package:qualquercoisavinteconto/constants/fonts.dart';
import 'package:qualquercoisavinteconto/constants/routes.dart';
import 'package:qualquercoisavinteconto/widgets/app_logo_widget.dart';
import 'package:qualquercoisavinteconto/widgets/background_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return backgroundWidget(
        child: Scaffold(
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.05).heightBox,
            appLogoWidget(),
            10.heightBox,
            "Minha Conta".text.fontFamily(bold).white.size(18).make(),
            50.heightBox,
            Column(
              children: [
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                    text: "",
                    style: TextStyle(color: fontGrey),
                  ),
                  TextSpan(
                    text: "Gerenciar meus endereços",
                    style: const TextStyle(
                      color: primaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, homeRoute);
                      },
                  ),
                ])),
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
