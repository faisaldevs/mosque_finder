import 'package:flutter/material.dart';
import 'package:mosque_finder_app/app/theme/app_colors.dart';

import '../../models/category_model.dart';

class CategoryChips extends StatelessWidget {
  final List<Category> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategoryChanged;

  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kCard,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: categories.map((cat) {
                final isSelected = cat.id == selectedCategory;
                return GestureDetector(
                  onTap: () => onCategoryChanged(cat.id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? cat.color : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isSelected ? cat.color : AppColors.kBorder,
                        width: isSelected ? 0 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(cat.emoji, style: const TextStyle(fontSize: 13)),
                        const SizedBox(width: 5),
                        Text(
                          cat.label,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.kSubText,
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const Divider(height: 1, color: AppColors.kBorder),
        ],
      ),
    );
  }
}
