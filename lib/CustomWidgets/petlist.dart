import 'package:flutter/material.dart';
import 'package:pet_adoption_app/Colors/appcolors.dart';
import 'package:pet_adoption_app/Colors/darkcolors.dart';
import 'package:pet_adoption_app/Images/app_images.dart';
import 'package:provider/provider.dart';

import '../Dashboard/view_model/themeprovider.dart';

class PetList extends StatelessWidget {
  const PetList(
      {super.key,
      required this.name,
      required this.place,
      required this.gender,
      required this.image,
      required this.color,
      this.alreadyAdopted});

  final String name;
  final String place;
  final String gender;
  final String image;
  final Color color;
  final Positioned? alreadyAdopted;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color,
              boxShadow: [
                BoxShadow(
                    color: themeProvider.isDarkMode
                        ? DarkColors.black
                        : AppColors.chineseWhite,
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(-1, 4))
              ]),
          child: Row(
            children: [
              Image.asset(image),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: themeProvider.isDarkMode
                            ? DarkColors.white
                            : AppColors.davysGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Image.asset(Images.place),
                      Text(
                        place,
                        style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? DarkColors.white
                                : AppColors.davysGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Image.asset(gender),
                ],
              )
            ],
          ),
        ),
        alreadyAdopted ?? const Text('')
      ],
    );
  }
}
