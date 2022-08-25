import 'package:flutter/material.dart';
import 'package:mualim/constants/app_theme.dart';

class PageBuilderWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imgurl;
  const PageBuilderWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.imgurl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Image.asset(imgurl),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.fonts,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            description,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: AppTheme.fonts,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
