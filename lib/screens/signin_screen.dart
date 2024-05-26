import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualquercoisavinteconto/constants/application.dart';
import 'package:qualquercoisavinteconto/constants/colors.dart';
import 'package:qualquercoisavinteconto/constants/fonts.dart';
import 'package:qualquercoisavinteconto/constants/forms.dart';
import 'package:qualquercoisavinteconto/constants/routes.dart';
import 'package:qualquercoisavinteconto/dtos/signin_request.dart';
import 'package:qualquercoisavinteconto/widgets/app_logo_widget.dart';
import 'package:qualquercoisavinteconto/widgets/background_widget.dart';
import 'package:qualquercoisavinteconto/widgets/custom_button.dart';
import 'package:qualquercoisavinteconto/widgets/custom_text_field.dart';
import 'package:velocity_x/velocity_x.dart';

import '../providers/auth_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> handleSubmit(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final loginData = SignInRequestDto(email: email, password: password);

    try {
      await Provider.of<AuthProvider>(context, listen: false).signIn(loginData);
      if (context.mounted) {
        Navigator.pushNamed(context, homeRoute);
      }
    } catch (e) {
      if (context.mounted) {
        const snackBar = SnackBar(content: Text('E-mail e/ou senha incorretos!'), backgroundColor: lightPrimaryColor);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

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
                customTextField(
                    hint: emailHint,
                    title: emailTitle,
                    controller: _emailController),
                customTextField(
                    hint: passwordHint,
                    title: passwordTitle,
                    controller: _passwordController,
                    obscureText: true
                    ),
                customButton(
                    color: primaryColor,
                    title: "Entrar",
                    textColor: whiteColor,
                    onPressed: () async {
                      await handleSubmit(context);
                    }).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                    text: "Ainda não possui uma conta? ",
                    style: TextStyle(color: fontGrey),
                  ),
                  TextSpan(
                    text: "Clique aqui",
                    style: const TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: primaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, signUpRoute);
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
