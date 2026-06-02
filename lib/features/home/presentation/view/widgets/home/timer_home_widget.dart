import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wathiq/core/utils/app_colors.dart';
import 'package:wathiq/core/utils/app_styles.dart';
import 'package:wathiq/features/home/data/models/auctions_model/auctions_model.dart';

class TimerHomeWidget extends StatefulWidget {
  const TimerHomeWidget({Key? key, required this.auctionData})
      : super(key: key);
  final AuctionData auctionData;
  @override
  State<TimerHomeWidget> createState() => _TimerHomeWidgetState();
}

class _TimerHomeWidgetState extends State<TimerHomeWidget> {
  // Initial time in seconds (e.g., 1 day, 2 hours, 5 minutes, and 55 seconds)
  late int totalSeconds;

  late Timer _timer;

  @override
  void initState() {
    totalSeconds = widget.auctionData.timer!.days * 24 * 60 * 60 +
        widget.auctionData.timer!.hours * 60 * 60 +
        widget.auctionData.timer!.minutes * 60 +
        widget.auctionData.timer!.seconds;

    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (totalSeconds > 0) {
          totalSeconds--;
        } else {
          timer.cancel(); // Stop the timer when it reaches zero
        }
      });
    });
  }

  // Convert total seconds into days, hours, minutes, and seconds
  Map<String, int> _timeComponents(int seconds) {
    int days = seconds ~/ (24 * 60 * 60);
    seconds %= (24 * 60 * 60);
    int hours = seconds ~/ (60 * 60);
    seconds %= (60 * 60);
    int minutes = seconds ~/ 60;
    seconds %= 60;

    return {
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
    };
  }

  @override
  Widget build(BuildContext context) {
    final time = _timeComponents(totalSeconds);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _timeBox(context, time['seconds']!, 'ثانية'),
        const TimerDividerLineWidget(),
        _timeBox(context, time['minutes']!, 'دقيقة'),
        const TimerDividerLineWidget(),
        _timeBox(context, time['hours']!, 'ساعه'),
        const TimerDividerLineWidget(),
        _timeBox(context, time['days']!, 'يوم'),
      ],
    );
  }

  Widget _timeBox(BuildContext context, int value, String label) {
    return Container(
      width: 66,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              '$value',
              style: AppStyles.styleBold18(context).copyWith(
                color: AppColors.typographyHeading(context),
                height: 2,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            label,
            style: AppStyles.styleMedium14(context).copyWith(
              color: AppColors.typographySubTitle(context),
            ),
          ),
        ],
      ),
    );
  }
}

class TimerDividerLineWidget extends StatelessWidget {
  const TimerDividerLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFFE6E6E6),
          ),
        ),
      ),
    );
  }
}
