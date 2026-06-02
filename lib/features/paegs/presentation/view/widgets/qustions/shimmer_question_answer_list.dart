import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerQuestionAnswerList extends StatelessWidget {
  const ShimmerQuestionAnswerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Simulating 5 shimmer items
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _buildShimmerQuestion(),
    );
  }

  Widget _buildShimmerQuestion() {
    return Card(
      color: Colors.white,
      shadowColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildShimmerBox(
                    height: 20, width: 250), // Question Placeholder
                _buildShimmerBox(height: 24, width: 24), // Icon Placeholder
              ],
            ),
            const SizedBox(height: 12),
            _buildShimmerBox(
                height: 16, width: double.infinity), // Answer line 1
            const SizedBox(height: 8),
            _buildShimmerBox(height: 16, width: 200), // Answer line 2
            const SizedBox(height: 24),
            Divider(color: Colors.grey[300]), // Divider
          ],
        ),
      ),
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
