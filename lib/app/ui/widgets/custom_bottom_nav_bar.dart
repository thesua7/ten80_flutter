import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavBar extends StatelessWidget {
  final RxInt selectedIndex;
  final Function(int) onTabSelected;
  final List<CustomBottomNavBarItem> items;
  final bool showLabels; // Add this parameter to toggle labels

  final Color backgroundColor;

  final Color selectedIconColor;
  final Color unselectedIconColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;

  const CustomBottomNavBar({super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.items,
    this.backgroundColor = Colors.black,
    this.showLabels = true, // Default is to show labels
    this.selectedIconColor = Colors.blue,
    this.unselectedIconColor = Colors.grey,
    this.selectedTextColor = Colors.blue,
    this.unselectedTextColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      decoration: BoxDecoration(
        color:backgroundColor, // Semi-transparent background
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = selectedIndex.value == index;
          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  item.icon,
                  color: isSelected ? selectedIconColor : unselectedIconColor,
                ),
                if (showLabels && item.label != null) // Check if labels are enabled
                  Text(
                    item.label!,
                    style: TextStyle(
                      color: isSelected ? selectedTextColor : unselectedTextColor,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class CustomBottomNavBarItem {
  final IconData icon;
  final String? label;

  CustomBottomNavBarItem({required this.icon, this.label});
}