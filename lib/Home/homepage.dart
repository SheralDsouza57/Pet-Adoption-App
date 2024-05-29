import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/Colors/appcolors.dart';
import 'package:pet_adoption_app/Colors/darkcolors.dart';
import 'package:pet_adoption_app/CustomWidgets/petlist.dart';
import 'package:pet_adoption_app/Dashboard/view_model/themeprovider.dart';
import 'package:pet_adoption_app/Detail/detailscreen.dart';
import 'package:pet_adoption_app/Images/app_images.dart';
import 'package:pet_adoption_app/Model/petmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  loadAdoptionState() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> adoptedPets = []; // List to hold adopted pets data
    setState(() {
      for (int i = 0; i <= pets.length - 1; i++) {
        pets[i].isAdopted = prefs.getBool('${pets[i].id}_adopted') ?? false;
        if (pets[i].isAdopted) {
          // Add pet to adopted list if it is adopted
          adoptedPets.add(jsonEncode(pets[i].toJson()));
        }
        // Saving the list of adopted pets to SharedPreferences
        prefs.setStringList('adoptedPets', adoptedPets);
      }
    });
  }

  List<PetModel> pets = [
    PetModel(
        name: 'Parshu',
        place: 'Udupi (2.5 km)',
        gender: 'Male',
        image: Images.one,
        price: 'Rs. 20,000',
        colour: 'Orange',
        breed: 'Persian',
        age: '2',
        bigImage: Images.pet1,
        id: 1,
        isAdopted: false),
    PetModel(
        name: 'Bella',
        place: 'Marathahalli (14 km)',
        gender: 'Female',
        image: Images.six,
        price: 'Rs. 30,000',
        colour: 'Beige',
        breed: 'Retriever',
        age: '6',
        bigImage: Images.pet6,
        id: 2,
        isAdopted: false),
    PetModel(
        name: 'Archie',
        place: 'BTM Layout (11.2 km)',
        gender: 'Male',
        image: Images.seven,
        price: 'Rs. 46,000',
        colour: 'Brown',
        breed: 'German',
        age: '2',
        bigImage: Images.pet7,
        id: 3,
        isAdopted: false),
    PetModel(
        name: 'Tuna',
        place: 'Basavanagudi (18.5 km)',
        gender: 'Male',
        image: Images.two,
        price: 'Rs. 13,000',
        colour: 'Grey',
        breed: 'Shorthair',
        age: '4',
        bigImage: Images.pet2,
        id: 4,
        isAdopted: false),
    PetModel(
        name: 'Milo',
        place: 'Rajajinagar (25 km)',
        gender: 'Female',
        image: Images.three,
        price: 'Rs. 25,000',
        colour: 'Brown',
        breed: 'Burmese',
        age: '1',
        bigImage: Images.pet3,
        id: 5,
        isAdopted: false),
    PetModel(
        name: 'Annie',
        place: 'Basavanagudi (2.6 km)',
        gender: 'Female',
        image: Images.eight,
        price: 'Rs. 15,000',
        colour: 'White',
        breed: 'Eskimo',
        age: '1',
        bigImage: Images.pet8,
        id: 6,
        isAdopted: false),
    PetModel(
        name: 'Lily',
        place: 'HSR Layout (1.6 km)',
        gender: 'Female',
        image: Images.four,
        price: 'Rs. 2,000',
        colour: 'Beige',
        breed: 'Sphynx',
        age: '5',
        bigImage: Images.pet4,
        id: 7,
        isAdopted: false),
    PetModel(
        name: 'Oreo',
        place: 'Ulsoor (10.6 km)',
        gender: 'Female',
        image: Images.nine,
        price: 'Rs. 3,300',
        colour: 'Black',
        breed: 'Terrier',
        age: '7',
        bigImage: Images.pet9,
        id: 8,
        isAdopted: false),
    PetModel(
        name: 'Max',
        place: 'Cubbon Park (11 km)',
        gender: 'Male',
        image: Images.ten,
        price: 'Rs. 7,700',
        colour: 'Brown',
        breed: 'Basset',
        age: '5',
        bigImage: Images.pet10,
        id: 9,
        isAdopted: false),
    PetModel(
        name: 'Charlie',
        place: 'Jayanagar (2.7 km)',
        gender: 'Male',
        image: Images.five,
        price: 'Rs. 27,000',
        colour: 'Multicolor',
        breed: 'Bobtail',
        age: '3',
        bigImage: Images.pet5,
        id: 10,
        isAdopted: false),
    PetModel(
        name: 'Carlos',
        place: 'Italy',
        gender: 'Male',
        image: Images.eleven,
        price: 'Rs. 12,000',
        colour: 'Beige',
        breed: 'Maltipoo',
        age: '5',
        bigImage: Images.pet11,
        id: 11,
        isAdopted: false),
    PetModel(
        name: 'Bailey',
        place: 'Marathahalli (14 km)',
        gender: 'Female',
        image: Images.twelve,
        price: 'Rs. 22,000',
        colour: 'Beige',
        breed: 'Corgi',
        age: '7',
        bigImage: Images.pet12,
        id: 12,
        isAdopted: false)
  ];
  List<PetModel> filteredPets = []; // List to hold filtered pets
  @override
  void initState() {
    loadDarkMode();
    filteredPets = pets;
    loadAdoptionState();
    super.initState();
  }

  void filterPets() {
    List<PetModel> results = [];
    if (searchController.text.isEmpty) {
      results = pets;
    } else {
      results = pets
          .where((pet) => pet.name
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredPets = results;
    });
  }

  bool isDarkMode = false;
  loadDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
            Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: themeProvider.isDarkMode
                    ? DarkColors.black
                    : AppColors.lightSilver,
              ),
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 11,
                        ),
                        hintText: "Search Pets...",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.white,
                            fontSize: 16),
                      ),
                      controller: searchController,
                      obscureText: false,
                      onChanged: (value) {
                        filterPets();
                      },
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: Image.asset(Images.search)),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Image.asset(
              Images.banner,
              width: double.infinity,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Adopt pet',
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
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: filteredPets.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      //  filteredPets[index].isAdopted
                      //     ? null
                      //     :
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            image: filteredPets[index].bigImage,
                            name: filteredPets[index].name,
                            price: filteredPets[index].price,
                            place: filteredPets[index].place,
                            gender: filteredPets[index].gender,
                            color: filteredPets[index].colour,
                            breed: filteredPets[index].breed,
                            age: filteredPets[index].age,
                            id: filteredPets[index].id,
                            isAdopted: filteredPets[index].isAdopted,
                          ),
                        ),
                      ).then((value) {
                        loadAdoptionState();
                      });
                    },
                    child: Opacity(
                      opacity: filteredPets[index].isAdopted ? 0.3 : 1,
                      child: PetList(
                        name: filteredPets[index].name,
                        place: filteredPets[index].place,
                        gender: filteredPets[index].gender == 'Female'
                            ? Images.female
                            : Images.male,
                        image: filteredPets[index].image,
                        color: filteredPets[index].isAdopted
                            ? themeProvider.isDarkMode
                                ? DarkColors.black
                                : AppColors.americanSilver
                            : themeProvider.isDarkMode
                                ? DarkColors.black
                                : AppColors.white,
                        alreadyAdopted: filteredPets[index].isAdopted
                            ? Positioned(
                                bottom: 15,
                                right: 20,
                                child: Text(
                                  'Already Adopted',
                                  style: TextStyle(
                                      fontSize: 11.5,
                                      color: themeProvider.isDarkMode
                                          ? DarkColors.white
                                          : AppColors.rhythm,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            : null,
                      ),
                    ),
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
