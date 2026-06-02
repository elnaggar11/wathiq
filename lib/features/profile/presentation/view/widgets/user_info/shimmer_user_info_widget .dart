import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUserInfoWidget extends StatelessWidget {
  const ShimmerUserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildShimmerProfileImage(),
            const SizedBox(height: 44),
            _buildShimmerField(),
            const SizedBox(height: 24),
            _buildShimmerField(),
            const SizedBox(height: 24),
            _buildShimmerField(),
            const SizedBox(height: 24),
            _buildShimmerField(),
            const SizedBox(height: 24),
            _buildShimmerField(),
            const SizedBox(height: 24),
            _buildShimmerField(),
            const SizedBox(height: 24),
            _buildShimmerField(),
            const SizedBox(height: 24),
            _buildShimmerField(),
            const SizedBox(height: 44),
            _buildShimmerDeleteButton(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerProfileImage() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Stack(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
          ),
          PositionedDirectional(
            end: 0,
            bottom: 0,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerField() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
        ),
      ),
    );
  }

  Widget _buildShimmerDeleteButton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[300],
        ),
      ),
    );
  }
}
