import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTopBiddersList extends StatelessWidget {
  const ShimmerTopBiddersList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: 3, // Simulating 5 shimmer items
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _buildShimmerCard(context, index),
    );
  }

  Widget _buildShimmerCard(BuildContext context, int index) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            children: [
              _buildShimmerCircle(40), // Icon placeholder
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildShimmerBox(
                        height: 18, width: 150), // Name placeholder
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildShimmerBox(height: 18, width: 80), // Bid amount
                        const SizedBox(width: 4),
                        _buildShimmerCircle(20), // Currency icon
                      ],
                    ),
                  ],
                ),
              ),
              _buildShimmerBox(height: 14, width: 70), // Time placeholder
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerBox({required double height, required double width}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildShimmerCircle(double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }
}
