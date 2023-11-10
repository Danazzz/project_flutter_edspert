import 'package:edspert/datasource/banner_remote_datasource.dart';
import 'package:edspert/model/banner_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRemoteDatasource bannerRemoteDatasource;

  BannerBloc({required this.bannerRemoteDatasource}) : super(BannerInitial()) {
    on<BannerEvent>((event, emit) async {
      if (event is GetBannerListEvent) {
        emit(BannerLoading());

        final result = await bannerRemoteDatasource.getBanners();

        emit(BannerSuccess(bannerResponse: result));
      }
    });
  }
}
