import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/Colors/appcolors.dart';
import 'package:pet_adoption_app/Colors/darkcolors.dart';
import 'package:pet_adoption_app/CustomWidgets/petlist.dart';
import 'package:pet_adoption_app/Dashboard/view_model/themeprovider.dart';
import 'package:pet_adoption_app/Images/app_images.dart';
import 'package:pet_adoption_app/Model/petmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<PetModel> adoptedPets = [];
  loadAdoptedPets() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? adoptedPetsJson = prefs.getStringList('adoptedPets');
    if (adoptedPetsJson != null) {
      setState(() {
        adoptedPets = adoptedPetsJson
            .map((petJson) => PetModel.fromJson(jsonDecode(petJson)))
            .toList();
      });
    }
  }

  @override
  void initState() {
    loadAdoptedPets();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        color:
            themeProvider.isDarkMode ? DarkColors.cultured : AppColors.cultured,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Adopted pets',
              style: TextStyle(
                  color: themeProvider.isDarkMode
                      ? DarkColors.white
                      : AppColors.davysGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            adoptedPets.isEmpty
                ? const Center(
                    child: Text(
                    'No pets adopted!',
                    style: TextStyle(color: AppColors.davysGrey),
                  ))
                : Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: adoptedPets.length,
                      itemBuilder: (context, index) {
                        return adoptedPets == []
                            ? const Text('No pets adopted')
                            : PetList(
                                name: adoptedPets[index].name,
                                place: adoptedPets[index].place,
                                gender: adoptedPets[index].gender == 'Female'
                                    ? Images.female
                                    : Images.male,
                                image: adoptedPets[index].image,
                                color: themeProvider.isDarkMode
                                    ? DarkColors.black
                                    : AppColors.white,
                              );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
