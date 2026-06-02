import 'package:flutter/material.dart';

import '../../../../../app/app.dart';
import '../../../../../core/widgets/guest_widget.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return KisGuest == true ? GuestWidget() : SizedBox();
  }
}
