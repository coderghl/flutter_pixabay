import 'package:flutter/material.dart';
import 'package:flutter_pixabay/global.dart';

class SelectThemeSeedColorWidget extends StatefulWidget {
  const SelectThemeSeedColorWidget({super.key});

  @override
  State<SelectThemeSeedColorWidget> createState() =>
      _SelectThemeSeedColorWidgetState();
}

class _SelectThemeSeedColorWidgetState
    extends State<SelectThemeSeedColorWidget> {
  @override
  Widget build(BuildContext context) {
    var colorSchemeSeedList = Global.appTheme.colorSchemeSeedList;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select color",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Wrap(
                alignment: WrapAlignment.start,
                children: List.generate(
                  colorSchemeSeedList.length,
                  (index) => _buildItem(index, colorSchemeSeedList, context),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(
    int index,
    List<Color> colorSchemeSeedList,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => setState(() {
        Global.appTheme.toggleThemeSeedColor(index);
      }),
      child: AnimatedContainer(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(
          top: 8,
          bottom: 8,
          right: 24,
          left: 14,
        ),
        duration: Duration(milliseconds: 400),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorSchemeSeedList[index],
          border: index == Global.appTheme.selColorSchemeSeed
              ? Border.all(
                  width: 4.0,
                  color: Theme.of(context).colorScheme.onBackground,
                )
              : null,
        ),
      ),
    );
  }
}
