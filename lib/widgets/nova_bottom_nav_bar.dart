import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../theme/nova_colors.dart';

class NovaBottomNavigationBar extends StatelessWidget {
  final ProfileDestination currentDestination;
  final ValueChanged<ProfileDestination> onDestinationSelect;

  const NovaBottomNavigationBar({
    super.key,
    required this.currentDestination,
    required this.onDestinationSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: NovaColors.surfaceContainer,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 68,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ProfileDestination.values.map((destination) {
              final isSelected = destination == currentDestination;

              final iconData = switch (destination) {
                ProfileDestination.home => Icons.home_rounded,
                ProfileDestination.discover => Icons.explore_rounded,
                ProfileDestination.messages => Icons.chat_bubble_rounded,
                ProfileDestination.profile => Icons.person_rounded,
              };

              return Expanded(
                child: InkWell(
                  onTap: () => onDestinationSelect(destination),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: isSelected ? NovaColors.primary : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          iconData,
                          size: 22,
                          color: isSelected ? Colors.white : NovaColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        destination.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? NovaColors.onSurface : NovaColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
