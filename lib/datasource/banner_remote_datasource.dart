import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:edspert/constant/constant.dart';
import 'package:edspert/model/banner_response_model.dart';

class BannerRemoteDatasource {
  Future<BannerResponse> getBanners() async {
    try {
      final url = '${LearningConstants.baseUrl}${LearningConstants.bannerpath}';

      final result = await Dio().get(
        url,
        options: Options(
          headers: {'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a0'},
        ),
      );

      final bannerResponse = BannerResponse.fromJson(result.data);

      return bannerResponse;
    } catch (e, stacktrace) {
      log(
        e.toString(),
        stackTrace: stacktrace,
        error: e,
      );
      rethrow;
    }
  }
}
