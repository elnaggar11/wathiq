import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/widgets/error_app_widget.dart';
import 'package:wathiq/features/home/presentation/view_model/home/home_cubit.dart';

import '../../../../../core/widgets/coustom_app_bar_widget.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().privacyPolicy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(title: 'الشروط و الاحكام'),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            switch (state.privacyPolicyRequestState) {
              case RequestState.loading:
              case RequestState.ideal:
                return ShimmerPolicyContent();
              case RequestState.loaded:
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Html(
                          data: state.privacyPolicyModel!.data.content,
                          style: {
                            "body": Style(
                              fontFamily: 'Lama Sans',
                              // fontSize: FontSize(16),
                              // fontWeight: FontWeight.w500,
                              lineHeight: LineHeight(1.7),
                            ),
                          },
                        ),
                      ],
                    ),
                  ),
                );
              case RequestState.error:
                return ErrorAppWidget(
                  text: 'حدث شئ ما خأ',
                  onTap: () {
                    homeCubit.privacyPolicy();
                  },
                );
            }
          },
        ),
      ),
    );
  }
}

class ShimmerPolicyContent extends StatelessWidget {
  const ShimmerPolicyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShimmerBox(height: 20, width: 200), // Title placeholder
          const SizedBox(height: 16),
          _buildShimmerBox(height: 16, width: double.infinity), // Line 1
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: double.infinity), // Line 2
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: double.infinity), // Line 3
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: 250), // Shorter line
          const SizedBox(height: 16),
          _buildShimmerBox(height: 16, width: double.infinity), // Paragraph
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: double.infinity),
          const SizedBox(height: 16), // Paragraph
          _buildShimmerBox(height: 16, width: double.infinity), // Line 1
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: double.infinity), // Line 2
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: double.infinity), // Line 3
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: 250), // Shorter line
          const SizedBox(height: 16),
          _buildShimmerBox(height: 16, width: double.infinity), // Paragraph
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: double.infinity), // Paragraph
        ],
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
