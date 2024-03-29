import 'package:flutter/material.dart';
import 'package:flutter_pixabay/entity/category_label_entity.dart';
import 'package:flutter_pixabay/pages/category_details/category_details_page.dart';
import 'package:flutter_pixabay/utils/extended.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          const SliverAppBar(
            title: Text("Category"),
            centerTitle: false,
          ),
        ];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
            return _buildItem(item, context);
          },
        ),
      ),
    );
  }

  Widget _buildItem(CategoryLabelEntity item, BuildContext context) {
    return GestureDetector(
      onTap: () => _handelItemOnTap(item.name),
      child: Container(
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
      ),
    );
  }

  void _handelItemOnTap(String categoryTitle) =>
      context.push(CategoryDetailsPage(categoryTitle: categoryTitle));
}
