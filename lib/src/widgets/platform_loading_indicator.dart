import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformLoadingIndicator extends StatelessWidget {
  final double size;

  const PlatformLoadingIndicator({Key? key, this.size = 20.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS || Platform.isMacOS)
        ? const CupertinoActivityIndicator()
        : SizedBox(
            width: size,
            height: size,
            child: const CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          );
  }
}
