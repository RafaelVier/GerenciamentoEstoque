import 'package:flutter/material.dart';

class OnBoardingStep extends StatelessWidget {
  final String imageAssetURL;
  final String? text;

  const OnBoardingStep({
    super.key,
    required this.imageAssetURL,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imageAssetURL,
            height: 128,
          ),
        ),
        if (text != null)
          Text(
            text!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
      ],
    );
  }
}