import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdaptativeButtonWidget extends StatelessWidget {
  final String label;
  final Function onPressed;
  const AdaptativeButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
  });

  Widget _getElevatedButton(BuildContext context) {
    return ElevatedButton(
      child: Text(
        label,
        style: const TextStyle(fontSize: 20),
      ),
      onPressed: () => onPressed(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      width: double.infinity,
      height: 60,
      child: kIsWeb
          // WEB
          ? _getElevatedButton(context)
          : Platform.isIOS
              // IOS
              ? CupertinoButton(
                  color: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () => onPressed(),
                )
              // ANDROID
              : _getElevatedButton(context),
    );
  }
}
