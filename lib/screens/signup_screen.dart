import 'package:flutter/material.dart';
import 'package:qualquercoisavinteconto/constants/colors.dart';
import 'package:qualquercoisavinteconto/constants/fonts.dart';
import 'package:qualquercoisavinteconto/constants/forms.dart';
import 'package:qualquercoisavinteconto/constants/routes.dart';
import 'package:qualquercoisavinteconto/widgets/app_logo_widget.dart';
import 'package:qualquercoisavinteconto/widgets/background_widget.dart';
import 'package:qualquercoisavinteconto/widgets/custom_button.dart';
import 'package:qualquercoisavinteconto/widgets/custom_text_field.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
            "Primeiro Acesso".text.fontFamily(bold).white.size(18).make(),
            12.heightBox,
            Column(
              children: [
                customTextField(hint: nameHint, title: nameTitle),
                customTextField(hint: emailHint, title: emailTitle),
                customTextField(hint: passwordHint, title: passwordTitle),
                customButton(
                        color: redColor,
                        title: "Finalizar",
                        textColor: whiteColor,
                        onPressed: () {
                          Navigator.pushNamed(context, catalogRoute);
                        })
                    .box
                    .width(context.screenWidth - 50)
                    .make(),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: "Voltar".text.color(fontGrey).make(),
                  ),
                )
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
