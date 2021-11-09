import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roadzen/models/familymodel.dart';
import '../../../constants.dart';

class Categories extends StatefulWidget {
  final Function(FamilyModel?)? familyCallback;
  const Categories({
    Key? key,
    this.familyCallback
  }) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: kDefaultPadding),
      child: SizedBox(
        height: 35,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: familyList.length,
            itemBuilder: (BuildContext context, int index) {
              FamilyModel currentFamily = familyList[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  widget.familyCallback!(currentFamily);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: selectedIndex == index ? Colors.orangeAccent : Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.8),
                  margin: EdgeInsets.only(right: kDefaultPadding * 0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(currentFamily.icon!),

                      SizedBox(width: 5),

                      Text(
                        currentFamily.name!,
                        style: TextStyle(
                            fontSize: 16,
                            color: kPrimaryColor,
                            fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.w300
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}