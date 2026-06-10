import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/core/utils/enums.dart';
import 'package:wathiq/core/utils/images.dart';
import 'package:wathiq/core/widgets/coustom_app_bar_widget.dart';
import 'package:wathiq/features/paegs/presentation/view_model/pages_cubit.dart';

import 'package:wathiq/core/functions/url_luncher.dart';
import 'package:wathiq/core/widgets/error_app_widget.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/contact_us/contact_us_card_widget.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/contact_us/contact_us_form_widget.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/contact_us/our_office_wrap_widget.dart';
import 'package:wathiq/features/paegs/presentation/view/widgets/contact_us/shimmer_contact_us.dart';
import 'package:animate_do/animate_do.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    context.read<PagesCubit>().getSocial();
    context.read<PagesCubit>().getUserCashedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primarySurface(context),
        appBar: CoustomAppBarWidget(title: 'تواصل معنا'),
        body: Form(
          key: context.read<PagesCubit>().ContactFormKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  FadeInDown(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      'نسعد بتواصلكم معنا ونرحب بمقترحاتكم والإجابة على استفساراتكم',
                      textAlign: TextAlign.start,
                      style: AppStyles.styleMedium16(context)
                          .copyWith(color: AppColors.typographyBody(context)),
                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 400),
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                  BlocBuilder<PagesCubit, PagesState>(
                    builder: (context, state) {
                      switch (state.getsocialRequestState) {
                        case RequestState.loading:
                        case RequestState.ideal:
                          return const ShimmerContactUs();
                        case RequestState.error:
                          return ErrorAppWidget(
                            text: state.socialError!.message,
                            onTap: () {
                              context.read<PagesCubit>().getSocial();
                            },
                          );
                        case RequestState.loaded:
                          return Container(
                            padding: const EdgeInsets.all(40),
                            decoration: ShapeDecoration(
                              color: Colors
                                  .white /* Background-background-white */,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 1,
                                  color: Color(
                                      0xFFE1E1E2) /* Borders-primary */,
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Column(
                              children: [
                                ContactUsCardWidget(
                                  text: 'إتصل بنا',
                                  subText:
                                      '966${state.socialModel?.data?.phoneNumber?.number ?? ''}+',
                                  subtextIcon: AppAssets.app_imagesCopy,
                                  icon: AppAssets.app_imagesPhoneNum,
                                  onTap: () {
                                    String phoneNumber = (state.socialModel?.data?.phoneNumber?.key ?? '') +
                                        (state.socialModel?.data?.phoneNumber?.number ?? '');
                                    if (phoneNumber.isNotEmpty) {
                                      callPhoneNumber(phoneNumber);
                                    }
                                  },
                                ),
                                const SizedBox(height: 16),
                                ContactUsCardWidget(
                                  text: 'المحادثة المباشرة',
                                  icon: AppAssets.app_imagesWhatsapp,
                                  subText:
                                      '966${state.socialModel?.data?.whatsapp?.number ?? ''}+',
                                  onTap: () {
                                    String whatsappNumber = (state.socialModel?.data?.whatsapp?.key ?? '') +
                                        (state.socialModel?.data?.whatsapp?.number ?? '');
                                    if (whatsappNumber.isNotEmpty) {
                                      openLink('https://wa.me/$whatsappNumber');
                                    }
                                  },
                                ),
                                const SizedBox(height: 16),
                                ContactUsCardWidget(
                                  text: 'البريد الالكتروني',
                                  subText: '${state.socialModel?.data?.email ?? ''}',
                                  subtextIcon: AppAssets.app_imagesCopy,
                                  icon: AppAssets.app_imagesEmail,
                                  onTap: () {
                                    if (state.socialModel?.data?.email != null) {
                                      openEmail(email: state.socialModel!.data!.email);
                                    }
                                  },
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                        AppAssets.app_imagesOuroffice),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'مكاتبنا',
                                              textAlign: TextAlign.start,
                                              style: AppStyles.styleBold16(
                                                  context),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        OurOfficeWrap(
                                          offices: state.socialModel?.data
                                                  ?.ourOffice ??
                                              [],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                ContactUsCardWidget(
                                  text: 'تابعنا على',
                                  onTap: null,
                                  instagram: state.socialModel?.data?.instagram,
                                  linkedin: state.socialModel?.data?.linkedin,
                                  twitter: state.socialModel?.data?.twitter,
                                  youtube: state.socialModel?.data?.facebook,
                                ),
                                const SizedBox(height: 16),
                              ],
                            ),
                          );
                      }
                    },
                  ),
                        ContactUsFormWidget(pagesCubit: pagesCubit),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
