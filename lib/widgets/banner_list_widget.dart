import 'package:edspert/model/banner_response_model.dart';
import 'package:flutter/material.dart';

class BannerListWidget extends StatelessWidget {
  final List<BannerData> bannerList;
  const BannerListWidget({super.key, required this.bannerList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 146,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: bannerList.length,
        separatorBuilder: (context, index) => const SizedBox(
          width: 29,
        ),
        itemBuilder: (context, index) {
          final banner = bannerList[index];

          return SizedBox(
            height: 146,
            width: 284,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                banner.eventImage ?? '',
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
