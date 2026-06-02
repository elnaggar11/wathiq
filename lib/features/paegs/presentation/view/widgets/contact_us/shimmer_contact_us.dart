import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContactUs extends StatelessWidget {
  const ShimmerContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildShimmerCard(), // Call Us
        const SizedBox(height: 16),
        _buildShimmerCard(), // Live Chat
        const SizedBox(height: 16),
        _buildShimmerCard(), // Email
        const SizedBox(height: 16),
        _buildShimmerCard(), // Social Media
        const SizedBox(height: 16),
        _buildShimmerCard(), // Address
        const SizedBox(height: 16),
        _buildDashedDivider(context),
      ],
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 60,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            _buildShimmerBox(height: 40, width: 40), // Icon
            const SizedBox(width: 12),
            _buildShimmerBox(height: 16, width: 150), // Text
          ],
        ),
      ),
    );
  }

  Widget _buildDashedDivider(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: _buildShimmerBox(
                height: 1, width: double.infinity)), // Left Line
        const SizedBox(width: 16),
        _buildShimmerBox(
            height: 16, width: 100), // "أو عن طريق" text placeholder
        const SizedBox(width: 16),
        Expanded(
            child: _buildShimmerBox(
                height: 1, width: double.infinity)), // Right Line
      ],
    );
  }

  Widget _buildShimmerBox({required double height, required double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
