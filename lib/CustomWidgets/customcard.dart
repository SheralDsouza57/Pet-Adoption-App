import 'package:flutter/material.dart';
import 'package:pet_adoption_app/Colors/appcolors.dart';
import 'package:pet_adoption_app/Colors/darkcolors.dart';
import 'package:pet_adoption_app/Dashboard/view_model/themeprovider.dart';
import 'package:provider/provider.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.heading,
    required this.subHeading,
  });

  final String heading;
  final String subHeading;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: themeProvider.isDarkMode ? DarkColors.black : AppColors.white,
          boxShadow: [
            BoxShadow(
                color: themeProvider.isDarkMode
                    ? DarkColors.black
                    : AppColors.chineseWhite,
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(-1, 4))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            heading,
            style: const TextStyle(
              color: AppColors.rhythm,
              fontSize: 14,
            ),
          ),
          Text(
            subHeading,
            style: const TextStyle(
              color: AppColors.silverFoil,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
