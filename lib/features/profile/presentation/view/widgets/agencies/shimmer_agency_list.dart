import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAgencyList extends StatelessWidget {
  const ShimmerAgencyList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Simulating 5 shimmer items
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(top: 32, left: 24, right: 24),
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFD6D9E1)),
              borderRadius: BorderRadius.circular(16),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x0C000000),
                blurRadius: 16,
                offset: Offset(2, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildShimmerBox(height: 80, width: 80), // Agency image
              const SizedBox(height: 12),
              _buildShimmerRow(), // Agency name
              const SizedBox(height: 12),
              _buildShimmerRow(), // Issued date
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildShimmerBox(height: 24, width: 24), // Icon
                  const SizedBox(width: 8),
                  _buildShimmerBox(height: 16, width: 120), // Attachment text
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              _buildShimmerBox(
                  height: 40, width: double.infinity), // Action button
            ],
          ),
        );
      },
    );
  }

  Widget _buildShimmerRow() {
    return Row(
      children: [
        _buildShimmerBox(height: 16, width: 100), // Title
        const SizedBox(width: 4),
        _buildShimmerBox(height: 16, width: 150), // Description
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
