import 'package:flutter/material.dart';
import 'package:recook/theme.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  CustomBottomNavigationBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        // Gunakan onItemTapped untuk menavigasi berdasarkan indeks yang dipilih
        onItemTapped(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Cari Resep',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'AI',
        ),
      ],
      selectedItemColor: primaryColor,
    );
  }
}
