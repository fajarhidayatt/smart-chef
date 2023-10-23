import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_chef/helpers/helpers.dart';
import 'package:smart_chef/models/food.dart';
import 'package:smart_chef/screens/detail.dart';

class FoodItem extends StatelessWidget {
  final Food food;
  final String type;

  const FoodItem({
    super.key, 
    required this.food, 
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return type == 'primary' 
      ? Primary(food: food) 
      : type == 'secondary'
      ? Secondary(food: food)
      : Tertiary(food: food);
  }
}

class Primary extends StatelessWidget {
  final Food food;

  const Primary({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(food: food, id: 'pr',))
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15.0),
        width: 150.0,
        height: 230.0,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              width: 150.0,
              height: 175.0,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 60.0),
                  Center(
                    child: Text(food.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text('Waktu',
                    style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      color: const Color(0xFFA9A9A9),
                    ),
                  ),
                  Text('${food.time} Mnt',
                    style: GoogleFonts.poppins(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Hero(
              tag: 'pr${food.image}',
              child: Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(food.image),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 25.0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 7.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE1B3),
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SvgPicture.asset('assets/vectors/ic_star.svg'),
                    const SizedBox(width: 3.0),
                    Text(food.rate.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Secondary extends StatelessWidget {
  final Food food;

  const Secondary({super.key, required this.food});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(food: food, id: 'sc'))
        );
      },
      child: Container(
        width: 255.0,
        height: 150.0,
        margin: const EdgeInsets.only(right: 15.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: 115.0,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(1, 1)
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(truncateText(food.name, 13),
                    style: GoogleFonts.poppins(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      for(int i = 1; i <= 5; i++) SvgPicture.asset('assets/vectors/ic_star.svg'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(food.chefPhoto),
                        radius: 20.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text('by ${food.chefName}',
                        style: GoogleFonts.poppins(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset('assets/vectors/ic_timer.svg'),
                      const SizedBox(width: 5.0),
                      Text('${food.time} mnt',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 10,
              child: Hero(
                tag: 'sc${food.image}',
                child: CircleAvatar(
                  backgroundImage: NetworkImage(food.image),
                  radius: 45.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tertiary extends StatelessWidget {
  final Food food;

  const Tertiary({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(food: food, id: 'tr'))
        );
      },
      child: Hero(
        tag: 'tr${food.image}',
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            image: DecorationImage(
              image: NetworkImage(food.image),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
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
                  padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE1B3),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SvgPicture.asset('assets/vectors/ic_star.svg'),
                      const SizedBox(width: 3.0),
                      Text(food.rate.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(food.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text('By ${food.chefName}',
                        style: GoogleFonts.poppins(
                          fontSize: 10.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}