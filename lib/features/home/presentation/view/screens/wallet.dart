import 'package:flutter/material.dart';

import 'package:wathiq/app/app.dart';
import 'package:wathiq/core/widgets/guest_widget.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return KisGuest == true ? const GuestWidget() : const SizedBox();
  }
}
