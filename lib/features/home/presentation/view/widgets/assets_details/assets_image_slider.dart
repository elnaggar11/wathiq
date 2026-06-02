import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../core/functions/get_auction_status_and_type.dart';
import '../../../../../../core/utils/app_animations.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../view_model/home/home_cubit.dart';

class AssetsImageSlider extends StatefulWidget {
  @override
  _AssetsImageSliderState createState() => _AssetsImageSliderState();
}

class _AssetsImageSliderState extends State<AssetsImageSlider> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return Stack(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 226,
            autoPlay: false, // Turn off autoplay for videos
            enlargeCenterPage: true,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: homeCubit.auctionOrigin!.attachment.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: url.endsWith('.mp4')
                      ? VideoWidget(videoUrl: url)
                      : CachedNetworkImage(
                          imageUrl: url,
                          placeholder: (context, url) => Padding(
                            padding: const EdgeInsets.all(120),
                            child: LottieBuilder.asset(
                              AppAnimationAssets.screenLoading,
                              fit: BoxFit.contain,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.image_not_supported_sharp),
                          fit: BoxFit.cover,
                        ),
                );
              },
            );
          }).toList(),
        ),
        PositionedDirectional(
          bottom: 32,
          start: 0,
          end: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(homeCubit.auctionOrigin!.attachment.length,
                (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: _currentIndex == index ? 19 : 13,
                height: 10,
                decoration: BoxDecoration(
                  color: _currentIndex == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(32),
                ),
              );
            }),
          ),
        ),
        Column(
          children: [
            Container(
              height: 226,
              width: 1.sw,
              decoration: BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // MazadLocationWidget(),
                        Spacer(),
                        Container(
                          height: 40,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: AppColors.color2(context),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text(
                            getAuctionTypeText(homeCubit.auctionData?.type),
                            style: AppStyles.styleBold16(context).copyWith(
                              color: AppColors.typographyHeadingWhite(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class VideoWidget extends StatefulWidget {
  final String videoUrl;

  VideoWidget({required this.videoUrl});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            autoPlay: true,
            looping: true,
            aspectRatio: _videoPlayerController.value.aspectRatio,
            errorBuilder: (context, errorMessage) => Center(
              child: Text("Error loading video"),
            ),
          );
        });
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _chewieController != null &&
            _chewieController!.videoPlayerController.value.isInitialized
        ? Chewie(controller: _chewieController!)
        : Center(child: CircularProgressIndicator());
  }
}
