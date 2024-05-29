import 'package:flutter/material.dart';
import 'package:pet_adoption_app/Colors/appcolors.dart';
import 'package:pet_adoption_app/Colors/darkcolors.dart';
import 'package:pet_adoption_app/Dashboard/view_model/themeprovider.dart';
import 'package:pet_adoption_app/History/historypage.dart';
import 'package:pet_adoption_app/Home/homepage.dart';
import 'package:pet_adoption_app/Images/app_images.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isDarkMode = false;
  int currentIndex = 0;
  final List<Widget> screens = [
    const HomePage(),
    const HistoryPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            themeProvider.isDarkMode ? DarkColors.dark : AppColors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CircleAvatar(
            child: Image.asset(Images.profile),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SHERAL DSOUZA',
                  style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? DarkColors.white
                          : AppColors.rhythm,
                      fontSize: 20),
                ),
                Row(
                  children: [
                    Image.asset(Images.location),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      'Udupi',
                      style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? DarkColors.white
                              : AppColors.rhythm,
                          fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
              return Switch(
                  activeColor: themeProvider.isDarkMode
                      ? DarkColors.white
                      : AppColors.black,
                  inactiveThumbColor: AppColors.silverFoil,
                  inactiveTrackColor: AppColors.white,
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleDarkMode(value);
                  });
            })
          ],
        ),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor:
                themeProvider.isDarkMode ? DarkColors.dark : AppColors.white,
            icon: Image.asset(Images.homeInactiveIcon),
            activeIcon: Image.asset(Images.homeActiveIcon),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor:
                themeProvider.isDarkMode ? DarkColors.dark : AppColors.white,
            icon: Image.asset(Images.historyInactiveIcon),
            activeIcon: Image.asset(Images.historyActiveIcon),
            label: '',
          ),
        ],
      ),
    );
  }
}
