import 'package:flutter/material.dart';
import 'package:pet_adoption_app/Colors/appcolors.dart';
import 'package:pet_adoption_app/Colors/darkcolors.dart';
import 'package:pet_adoption_app/CustomWidgets/customcard.dart';
import 'package:pet_adoption_app/Dashboard/view_model/themeprovider.dart';
import 'package:pet_adoption_app/Images/app_images.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.place,
    required this.gender,
    required this.color,
    required this.breed,
    required this.age,
    required this.isAdopted,
    required this.id,
  });

  final int id;
  final String image;
  final String name;
  final String price;
  final String place;
  final String gender;
  final String color;
  final String breed;
  final String age;
  final bool isAdopted;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isAdopted = false;
  loadAdoptionState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isAdopted = prefs.getBool('${widget.id}_adopted') ?? false;
    });
  }

  toggleAdoption() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${widget.id}_adopted', !isAdopted);
    setState(() {
      isAdopted = !isAdopted;
    });
  }

  @override
  void initState() {
    loadAdoptionState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            themeProvider.isDarkMode ? DarkColors.dark : AppColors.white,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: Text(
          'About Me',
          style: TextStyle(
              color: themeProvider.isDarkMode
                  ? DarkColors.white
                  : AppColors.davysGrey),
        ),
      ),
      body: Opacity(
        opacity: isAdopted ? 0.5 : 1,
        child: Stack(
          children: [
            Column(
              children: [
                Center(
                  child: InteractiveViewer(
                    scaleEnabled: true,
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: themeProvider.isDarkMode
                      ? DarkColors.cultured
                      : AppColors.white,
                ),
                height: 380,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? DarkColors.white
                                  : AppColors.davysGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          widget.price,
                          style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? DarkColors.white
                                  : AppColors.davysGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Image.asset(Images.place),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          widget.place,
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? AppColors.rhythm
                                : AppColors.davysGrey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomCard(
                          heading: widget.gender,
                          subHeading: 'Gender',
                        ),
                        CustomCard(
                          heading: widget.color,
                          subHeading: 'Color',
                        ),
                        CustomCard(
                          heading: widget.breed,
                          subHeading: 'Breed',
                        ),
                        CustomCard(
                          heading: widget.age,
                          subHeading: 'Age',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    // isAdopted
                    //     ? const Text('')
                    //     :
                    InkWell(
                      onTap: () {
                        toggleAdoption();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: themeProvider.isDarkMode
                                  ? DarkColors.cultured
                                  : AppColors.lightSilver,
                              title: Text(
                                'Adoption Confirmation',
                                style: TextStyle(
                                    color: themeProvider.isDarkMode
                                        ? DarkColors.white
                                        : AppColors.davysGrey),
                              ),
                              content: Text(
                                'You have now adopted ${widget.name}!',
                                style: TextStyle(
                                    color: themeProvider.isDarkMode
                                        ? DarkColors.white
                                        : AppColors.black),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                        color: themeProvider.isDarkMode
                                            ? DarkColors.white
                                            : DarkColors.rhythm),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: AppColors.rhythm,
                        ),
                        child: const Center(
                          child: Text(
                            'Adopt Me',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
