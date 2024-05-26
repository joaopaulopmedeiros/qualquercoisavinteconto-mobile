import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualquercoisavinteconto/constants/colors.dart';
import 'package:qualquercoisavinteconto/constants/fonts.dart';
import 'package:qualquercoisavinteconto/constants/forms.dart';
import 'package:qualquercoisavinteconto/constants/routes.dart';
import 'package:qualquercoisavinteconto/dtos/signup_request.dart';
import 'package:qualquercoisavinteconto/providers/auth_provider.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> handleSubmit(BuildContext context) async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final signUpData = SignUpRequestDto(name: name, email: email, password: password);

    try {
      await Provider.of<AuthProvider>(context, listen: false).signUp(signUpData);
      if (context.mounted) {
        Navigator.pushNamed(context, homeRoute);
      }
    } catch (e) {
      if (context.mounted) {
        const snackBar = SnackBar(content: Text('Cadastro inválido!'), backgroundColor: lightPrimaryColor);
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
            "Primeiro Acesso".text.fontFamily(bold).white.size(18).make(),
            12.heightBox,
            Column(
              children: [
                customTextField(
                    hint: nameHint,
                    title: nameTitle,
                    controller: _nameController),
                customTextField(
                    hint: emailHint,
                    title: emailTitle,
                    controller: _emailController),
                customTextField(
                    hint: passwordHint,
                    title: passwordTitle,
                    controller: _passwordController,
                    obscureText: true),
                customButton(
                    color: primaryColor,
                    title: "Finalizar",
                    textColor: whiteColor,
                    onPressed: () async {
                      await handleSubmit(context);
                    }).box.width(context.screenWidth - 50).make(),
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
