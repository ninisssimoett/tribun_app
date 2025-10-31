import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFF3E4C) // warna merah seperti gambar kiri
              : Colors.transparent, // biar yang nggak dipilih warnanya transparan
          borderRadius: BorderRadius.circular(20),
          
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.w400 : FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
