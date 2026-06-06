import 'package:flutter/material.dart';
import 'package:wathiq/config/routes/app_routes.dart';
import 'package:wathiq/core/utils/media_query_values.dart';

import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_strings.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/features/auth/presentation/view/widgets/contact_us_auth_widget.dart';

class SalesAgentIntroScreen extends StatelessWidget {
  const SalesAgentIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const ContactUsAuthWidget(),
        appBar: CoustomAppBarWidget(title: 'وكيل بيع'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.primary(context).withOpacity(0.15),
                          width: 20,
                        ),
                      ),
                    ),
                    child: Text(
                      'كن وكيلاً للبيع',
                      style: AppStyles.styleBold32(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                AppStrings.salesAgentIntroText,
                style: AppStyles.styleMedium16(context).copyWith(
                  color: AppColors.typographySubTitle(context),
                ),
              ),
              const SizedBox(
                height: 44,
              ),
              ElevatedButton(
                onPressed: () {
                  context.navigateTo(Routes.addSalesAgent);
                },
                child: Text(
                  'انضم إلينا',
                  style: AppStyles.styleMedium18(context).copyWith(
                    color: AppColors.white(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
