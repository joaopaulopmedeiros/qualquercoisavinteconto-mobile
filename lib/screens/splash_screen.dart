import 'package:flutter/material.dart';
import 'package:qualquercoisavinteconto/constants/application.dart';
import 'package:qualquercoisavinteconto/constants/colors.dart';
import 'package:qualquercoisavinteconto/constants/fonts.dart';
import 'package:qualquercoisavinteconto/constants/images.dart';
import 'package:qualquercoisavinteconto/widgets/app_logo_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(alignment: Alignment.center, child: Image.asset(iconSplashBackgroundSource, width: 300)),
            20.heightBox,
            appLogoWidget(),
            10.heightBox,
            applicationName.text.fontFamily(bold).size(24).white.make(),
            5.heightBox,
            applicationVersion.text.white.make(),
            const Spacer(),
            applicationTeam.text.white.fontFamily(semiBold).make(),
            30.heightBox
          ],
        ),
      ),
    );
  }
}