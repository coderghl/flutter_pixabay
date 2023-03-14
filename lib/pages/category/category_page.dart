import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/category_label_entity.dart';
import 'package:flutter_pixabay/global.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<CategoryLabelEntity> categoryList = [
    CategoryLabelEntity(
        name: "backgrounds", assetsImage: "assets/images/c_backgrounds.jpg"),
    CategoryLabelEntity(
        name: "fashion", assetsImage: "assets/images/c_fashion.jpg"),
    CategoryLabelEntity(
        name: "nature", assetsImage: "assets/images/c_nature.jpg"),
    CategoryLabelEntity(
        name: "science", assetsImage: "assets/images/c_science.jpg"),
    CategoryLabelEntity(
        name: "education", assetsImage: "assets/images/c_education.jpg"),
    CategoryLabelEntity(
        name: "feelings", assetsImage: "assets/images/c_feelings.jpg"),
    CategoryLabelEntity(
        name: "health", assetsImage: "assets/images/c_health.jpg"),
    CategoryLabelEntity(
        name: "people", assetsImage: "assets/images/c_people.jpg"),
    CategoryLabelEntity(
        name: "religion", assetsImage: "assets/images/c_religion.jpg"),
    CategoryLabelEntity(
        name: "places", assetsImage: "assets/images/c_places.jpg"),
    CategoryLabelEntity(
        name: "animals", assetsImage: "assets/images/c_animals.jpg"),
    CategoryLabelEntity(
        name: "industry", assetsImage: "assets/images/c_industry.jpg"),
    CategoryLabelEntity(
        name: "computer", assetsImage: "assets/images/c_computer.jpg"),
    CategoryLabelEntity(name: "food", assetsImage: "assets/images/c_food.jpg"),
    CategoryLabelEntity(
        name: "sports", assetsImage: "assets/images/c_sports.jpg"),
    CategoryLabelEntity(
        name: "transportation",
        assetsImage: "assets/images/c_transportation.jpg"),
    CategoryLabelEntity(
        name: "travel", assetsImage: "assets/images/c_travel.jpg"),
    CategoryLabelEntity(
        name: "buildings", assetsImage: "assets/images/c_buildings.jpg"),
    CategoryLabelEntity(
        name: "business", assetsImage: "assets/images/c_business.jpg"),
    CategoryLabelEntity(
        name: "music", assetsImage: "assets/images/c_music.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: GridView.builder(
        itemCount: categoryList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 24,
          mainAxisExtent: 140,
        ),
        itemBuilder: (context, index) {
          CategoryLabelEntity item = categoryList[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(item.assetsImage),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black.withOpacity(.4),
              ),
              child: Center(
                child: Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
    ;
  }
}
