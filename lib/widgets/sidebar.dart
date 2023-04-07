// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './sidebar_tile.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage('images/app_logo.png')),
        SidebarTile(
            isSelected: true, icon: FontAwesomeIcons.house, title: 'Home'),
        SidebarTile(
            isSelected: false,
            icon: FontAwesomeIcons.person,
            title: 'Patient List'),

        // Version
        Expanded(
          child: Container(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'version 1.0.0',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        )
      ],
    );
  }
}
