import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_chef/models/food.dart';
import 'package:smart_chef/widgets/button_category.dart';
import 'package:smart_chef/widgets/food_item.dart';
import 'package:smart_chef/widgets/text_input.dart';
import 'package:smart_chef/pages/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currenctCategory = 'Semua';
  final _scrollController = ScrollController();

  List<Food> foodsByCategory = listFood;
  List<Food> newFoodList = listFood.where((food) => food.isNew).toList();
  List<String> listCategory = [
    'Semua',
    'Daging',
    'Ayam',
    'Sayuran',
    'Seafood',
    'Dessert',
  ];

  void handleSubmitted(String value) {
    if (value.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Search(search: value)),
      );
    }
  }

  void handleCategory(String category) {
    setState(() {
      currenctCategory = category;
      if (category == 'Semua') {
        foodsByCategory = listFood;
      } else {
        foodsByCategory = listFood
            .where((food) => food.category == currenctCategory)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 830),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// HEADER
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Halo Fajar',
                              style: GoogleFonts.poppins(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Masak apa hari ini?',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            'assets/images/profil_pic.jpg',
                            width: 50.0,
                            height: 50.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// SEARCH BAR
                  TextInput(
                    value: '',
                    onSubmitted: handleSubmitted,
                    clearWhenSubmitted: true,
                  ),

                  /// CATEGORY
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Row(
                        children: <Widget>[
                          for (String category in listCategory)
                            ButtonCategory(
                              title: category,
                              active: category == currenctCategory,
                              onPressed: () => handleCategory(category),
                            ),
                        ],
                      ),
                    ),
                  ),

                  /// FEATURED
                  Scrollbar(
                    controller: _scrollController,
                    child: SizedBox(
                      height: 230.0,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 20.0, right: 5.0),
                        itemCount: foodsByCategory.length,
                        itemBuilder: (context, index) {
                          return FoodItem(
                            food: foodsByCategory[index],
                            type: 'primary',
                          );
                        },
                      ),
                    ),
                  ),

                  /// NEW RECIPES
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 25.0, 0, 10.0),
                    child: Text(
                      'Resep Baru',
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Scrollbar(
                    controller: _scrollController,
                    child: SizedBox(
                      height: 170.0,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.fromLTRB(20.0, 0, 5.0, 20.0),
                        itemCount: newFoodList.length,
                        itemBuilder: (context, index) {
                          return FoodItem(
                            food: newFoodList[index],
                            type: 'secondary',
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
