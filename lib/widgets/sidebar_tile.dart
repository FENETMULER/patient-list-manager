import 'package:flutter/material.dart';
import '../styles.dart';

class SidebarTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  const SidebarTile(
      {required this.icon, required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all(Colors.black),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.hovered)) {
              return !isSelected
                  ? sideBarTileBackgroundColorHover
                  : sideBarTileBackgroundColorSelected;
            }
            return isSelected
                ? sideBarTileBackgroundColorSelected
                : sideBarTileBackgroundColorUnselected;
          },
        ),
      ),
      onPressed: () {},
      child: Row(
        children: [
          Icon(icon,
              color: isSelected
                  ? sideBarTileTextColorSelected
                  : sideBarTileTextColorUnselected),
          SizedBox(width: 30),
          Text(title,
              style: isSelected
                  ? sideBarTileTextStyleSelected
                  : sideBarTileTextStyleUnselected),
        ],
      ),
    );
  }
}
