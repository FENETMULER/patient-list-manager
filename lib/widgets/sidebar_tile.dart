import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SidebarTile extends StatelessWidget {
  final String title;
  const SidebarTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Icon(FontAwesomeIcons.house), Text('Home')],
    );
  }
}
