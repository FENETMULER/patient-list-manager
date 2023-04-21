import 'package:flutter/material.dart';

class SidebarTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final Function changePage;
  const SidebarTile(
      {required this.icon,
      required this.title,
      required this.isSelected,
      required this.changePage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all(Colors.black),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.hovered)) {
              return !isSelected
                  ? Theme.of(context).hoverColor
                  : Theme.of(context).primaryColor;
            }
            return isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).disabledColor;
          },
        ),
      ),
      onPressed: () {
        changePage(title == 'Home' ? 1 : 2);
      },
      child: Row(
        children: [
          Icon(icon,
              color: isSelected
                  ? Theme.of(context).textTheme.labelLarge!.color
                  : Colors.black),
          const SizedBox(width: 30),
          Text(
            title,
            style: isSelected
                ? Theme.of(context).textTheme.labelLarge
                : Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
