import 'package:flutter/material.dart';
import 'package:favora_app/core/theme/app_colors.dart';
import 'package:favora_app/core/theme/app_spacing.dart';

/// Shimmer loading placeholder with customizable shape.
class ShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerLoading({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius,
  });

  /// Creates a circular shimmer.
  const ShimmerLoading.circle({
    super.key,
    required double size,
  })  : width = size,
        height = size,
        borderRadius = null;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCircle = widget.width == widget.height && widget.borderRadius == null;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: isCircle
                ? null
                : widget.borderRadius ?? AppSpacing.borderRadiusMd,
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: const [
                AppColors.surfaceVariant,
                AppColors.borderLight,
                AppColors.surfaceVariant,
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Card-shaped shimmer for list loading states.
class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: AppSpacing.borderRadiusLg,
      ),
      child: Row(
        children: [
          const ShimmerLoading(width: 44, height: 44),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoading(
                  height: 14,
                  width: 160,
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
                const SizedBox(height: 8),
                ShimmerLoading(
                  height: 12,
                  width: 100,
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
              ],
            ),
          ),
          ShimmerLoading(
            height: 14,
            width: 50,
            borderRadius: AppSpacing.borderRadiusSm,
          ),
        ],
      ),
    );
  }
}

