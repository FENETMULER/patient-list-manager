import 'package:flutter/material.dart';
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
        // TODO: Add image here
        SidebarTile(title: 'Home')
      ],
    );
  }
}
