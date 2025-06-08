import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_chef/utils/helpers.dart';
import 'package:smart_chef/models/food.dart';

class Detail extends StatelessWidget {
  final Food food;
  final String id;

  const Detail({super.key, required this.food, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.black),
        ),
        title: Text(
          truncateText(food.name, 15),
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 10.0),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth > 800) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 20.0),
                            HeroImage(
                              heroId: id,
                              image: food.image,
                              rate: food.rate,
                              time: food.time,
                            ),
                            FoodName(name: food.name, reviews: food.reviews),
                            ChefProfile(
                              chefName: food.chefName,
                              chefPhoto: food.chefPhoto,
                              chefAddress: food.chefAddress,
                            ),
                            FoodDescription(desc: food.desc),
                          ],
                        ),
                      ),
                      const SizedBox(width: 30.0),
                      Expanded(
                        flex: 2,
                        child: FoodRecipe(
                          portion: food.portion,
                          ingredients: food.ingredients,
                          procedures: food.procedures,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      HeroImage(
                        heroId: id,
                        image: food.image,
                        rate: food.rate,
                        time: food.time,
                      ),
                      FoodName(name: food.name, reviews: food.reviews),
                      ChefProfile(
                        chefName: food.chefName,
                        chefPhoto: food.chefPhoto,
                        chefAddress: food.chefAddress,
                      ),
                      FoodDescription(desc: food.desc),
                      FoodRecipe(
                        portion: food.portion,
                        ingredients: food.ingredients,
                        procedures: food.procedures,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class HeroImage extends StatelessWidget {
  final String heroId;
  final String image;
  final double rate;
  final int time;

  const HeroImage({
    super.key,
    required this.heroId,
    required this.image,
    required this.rate,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Hero(
      tag: heroId + image,
      child: Container(
        width: double.infinity,
        height: screenWidth > 800 ? 275.0 : 200.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        ),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: const LinearGradient(
              colors: [Colors.transparent, Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 3.0,
                  horizontal: 10.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE1B3),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SvgPicture.asset('assets/vectors/ic_star.svg'),
                    const SizedBox(width: 3.0),
                    Text(
                      rate.toString(),
                      style: GoogleFonts.poppins(fontSize: 11),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SvgPicture.asset('assets/vectors/ic_timer.svg', width: 24),
                  const SizedBox(width: 5.0),
                  Text(
                    '$time mnt',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodName extends StatelessWidget {
  final String name;
  final int reviews;

  const FoodName({super.key, required this.name, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Text(
              name,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              '($reviews Ulasan)',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class ChefProfile extends StatelessWidget {
  final String chefName;
  final String chefPhoto;
  final String chefAddress;

  const ChefProfile({
    super.key,
    required this.chefName,
    required this.chefPhoto,
    required this.chefAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(chefPhoto),
            radius: 25.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              chefName,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: <Widget>[
                SvgPicture.asset('assets/vectors/ic_location.svg'),
                Text(
                  chefAddress,
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class FoodDescription extends StatefulWidget {
  final String desc;

  const FoodDescription({super.key, required this.desc});

  @override
  State<FoodDescription> createState() => _FoodDescriptionState();
}

class _FoodDescriptionState extends State<FoodDescription> {
  bool isReadMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
          child: Text(
            'Deskripsi',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          widget.desc,
          textAlign: TextAlign.justify,
          maxLines: isReadMore ? 20 : 5,
          overflow: isReadMore ? TextOverflow.visible : TextOverflow.ellipsis,
          style: GoogleFonts.poppins(fontSize: 14.0, color: Colors.black),
        ),
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  isReadMore = !isReadMore;
                });
              },
              child: Text(
                isReadMore ? 'Baca lebih sedikit' : 'Baca selengkapnya',
                style: GoogleFonts.poppins(fontSize: 14.0, color: Colors.blue),
              ),
            ),
            Icon(
              isReadMore ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
              color: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }
}

class FoodRecipe extends StatefulWidget {
  final int portion;
  final List<String> ingredients;
  final List<String> procedures;

  const FoodRecipe({
    super.key,
    required this.portion,
    required this.ingredients,
    required this.procedures,
  });

  @override
  State<FoodRecipe> createState() => _FoodRecipeState();
}

class _FoodRecipeState extends State<FoodRecipe> {
  String currentButton = 'ingredients';
  List<String> list = [];

  @override
  void initState() {
    list = widget.ingredients;
    super.initState();
  }

  void handleButton(value) {
    setState(() {
      currentButton = value;
      if (value == 'procedures') {
        list = widget.procedures;
      } else {
        list = widget.ingredients;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
          child: Text(
            'Proses Pembuatan',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            SvgPicture.asset('assets/vectors/ic_food.svg', width: 24.0),
            const SizedBox(width: 5.0),
            Text('Untuk ${widget.portion} Porsi'),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            children: <Widget>[
              Button(
                title: 'Bahan',
                isActive: currentButton == 'ingredients',
                onPressed: () => handleButton('ingredients'),
              ),
              Button(
                title: 'Langkah-langkah',
                isActive: currentButton == 'procedures',
                onPressed: () => handleButton('procedures'),
              ),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            for (int i = 0; i < list.length; i++)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text.rich(
                  TextSpan(
                    text: list[i].split('_')[0],
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF129575),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' ${list[i].split('_')[1]}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final String title;
  final bool isActive;
  final void Function() onPressed;

  const Button({
    super.key,
    required this.title,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size.fromHeight(0),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          backgroundColor: isActive
              ? const Color(0xFF129575)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : const Color(0xFF129575),
          ),
        ),
      ),
    );
  }
}
