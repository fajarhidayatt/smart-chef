import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_chef/models/food.dart';
import 'package:smart_chef/widgets/food_item.dart';
import 'package:smart_chef/widgets/text_input.dart';

class Search extends StatefulWidget {
  final String search;

  const Search({super.key, required this.search});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String text = '';
  List<Food> listResult = [];

  @override
  void initState() {
    super.initState();
    text = widget.search;
    listResult = listFood
      .where((food) => food.name.toLowerCase().contains(text.toLowerCase()))
      .toList();
  }

  void handleSubmitted(String value){
    if(value.isNotEmpty){
      setState(() {
        text = value;
        listResult = listFood
          .where((food) => food.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
        title: Text('Cari Resep',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 768),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextInput(
                value: text,
                onSubmitted: handleSubmitted, 
                clearWhenSubmitted: false,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Hasil pencarian "$text"',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              listResult.isNotEmpty
                ? Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                      crossAxisCount: screenWidth < 456 
                        ? 2 : screenWidth < 576
                        ? 3 : 4,
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                      children: <FoodItem>[
                        for(Food food in listResult) FoodItem(food: food, type: 'tertiary'),
                      ],
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text('Resep tidak ditemukan \n😔',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

