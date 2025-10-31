import 'package:flutter/material.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int _selectedIndex = 0;

  final List<IconData> icons = [
    Icons.home_rounded,
    Icons.search_rounded,
    Icons.bookmark_border_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A2143),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (index) {
          final isSelected = _selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isSelected)
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFFF3E4C).withOpacity(0.5),
                          Colors.transparent,
                        ],
                        radius: 0.8,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                Icon(
                  icons[index],
                  color: isSelected
                      ? const Color(0xFFFF3E4C)
                      : Colors.white,
                  size: 28,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
