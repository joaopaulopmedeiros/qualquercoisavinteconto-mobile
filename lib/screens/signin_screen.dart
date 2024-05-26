import 'package:flutter/material.dart';
import 'package:qualquercoisavinteconto/constants/application.dart';
import 'package:qualquercoisavinteconto/constants/colors.dart';
import 'package:qualquercoisavinteconto/constants/fonts.dart';
import 'package:qualquercoisavinteconto/widgets/app_logo_widget.dart';
import 'package:qualquercoisavinteconto/widgets/background_widget.dart';
import 'package:qualquercoisavinteconto/widgets/custom_button.dart';
import 'package:qualquercoisavinteconto/widgets/custom_text_field.dart';
import 'package:velocity_x/velocity_x.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return backgroundWidget(
        child: Scaffold(
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            appLogoWidget(),
            10.heightBox,
            "Entre no $applicationName"
                .text
                .fontFamily(bold)
                .white
                .size(18)
                .make(),
            12.heightBox,
            Column(
              children: [
                customTextField(hint: "tester@admin.com", title: "Email"),
                customTextField(hint: "******", title: "Senha"),
                customButton(
                        color: redColor,
                        title: "Entrar",
                        textColor: whiteColor,
                        onPressed: () {})
                    .box
                    .width(context.screenWidth - 50)
                    .make(),
                10.heightBox,
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                    text: "Ainda não possui uma conta? ",
                    style: TextStyle(color: fontGrey),
                  ),
                  TextSpan(
                    text: "Clique aqui",
                    style: TextStyle(
                      color: redColor,
                      decoration: TextDecoration.underline,
                      decorationColor: redColor,
                    ),
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
