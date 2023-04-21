// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './sidebar_tile.dart';

class Sidebar extends StatelessWidget {
  final Function changePage;
  final int pageToDisplay;
  const Sidebar({required this.changePage, required this.pageToDisplay});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Image(image: AssetImage('images/app_logo.png')),
          SidebarTile(
              isSelected: pageToDisplay == 1 ? true : false,
              icon: FontAwesomeIcons.house,
              title: 'Home',
              changePage: changePage),
          SidebarTile(
              isSelected: pageToDisplay == 2 ? true : false,
              icon: FontAwesomeIcons.person,
              title: 'Patient List',
              changePage: changePage),

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
      ),
    );
  }
}
