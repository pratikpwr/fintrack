import 'package:flutter/material.dart';
import '../theme/theme.dart';

/// A shimmer loading animation widget
class LoadingShimmer extends StatefulWidget {
  const LoadingShimmer({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
  });

  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  @override
  State<LoadingShimmer> createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<LoadingShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? AppRadius.radiusSm,
            gradient: LinearGradient(
              begin: Alignment(_animation.value - 1, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: const [
                AppColors.surfaceLight,
                AppColors.surfaceLighter,
                AppColors.surfaceLight,
              ],
            ),
          ),
        );
      },
    );
  }
}

/// A loading shimmer card placeholder
class LoadingShimmerCard extends StatelessWidget {
  const LoadingShimmerCard({
    super.key,
    this.height = 120,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: AppSpacing.cardPadding,
      decoration: AppDecorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const LoadingShimmer(width: 40, height: 40),
              AppSpacing.hGapMd,
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoadingShimmer(width: 100, height: 14),
                    SizedBox(height: 8),
                    LoadingShimmer(width: 60, height: 12),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          const LoadingShimmer(height: 24),
        ],
      ),
    );
  }
}

/// A loading shimmer list item placeholder
class LoadingShimmerListItem extends StatelessWidget {
  const LoadingShimmerListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.listItemPadding,
      child: Row(
        children: [
          const LoadingShimmer(
            width: 44,
            height: 44,
            borderRadius: AppRadius.radiusMd,
          ),
          AppSpacing.hGapMd,
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadingShimmer(width: 140, height: 16),
                SizedBox(height: 8),
                LoadingShimmer(width: 80, height: 12),
              ],
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              LoadingShimmer(width: 80, height: 16),
              SizedBox(height: 8),
              LoadingShimmer(width: 50, height: 12),
            ],
          ),
        ],
      ),
    );
  }
}

