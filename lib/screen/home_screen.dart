import 'package:edspert/bloc/banner_bloc/banner_bloc.dart';
import 'package:edspert/datasource/banner_remote_datasource.dart';
import 'package:edspert/datasource/course_remote_datasource.dart';
import 'package:edspert/model/banner_response_model.dart';
import 'package:edspert/model/course_response_mode.dart';
import 'package:edspert/widgets/banner_list_widget.dart';
import 'package:edspert/widgets/course_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum BannerStatus { initial, loading, success, error }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final bannerRemoteDatasource = BannerRemoteDatasource();
  final courseRemoteDatasource = CourseRemoteDatasource();

  // BannerResponse? bannerResponse;
  CourseResponse? courseResponse;
  @override
  void initState() {
    // getBanner();
    getCourse();
    super.initState();
  }

  // void getBanner() async {
  //   bannerResponse = await bannerRemoteDatasource.getBanners();
  //   setState(() {});
  // }

  void getCourse() async {
    courseResponse = await courseRemoteDatasource.getCourses();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BannerBloc(
        bannerRemoteDatasource: BannerRemoteDatasource(),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, Altop',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Selamat Datang',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 17.5,
                        backgroundImage: AssetImage('assets/edo-selfie.png'),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 147,
                    decoration: BoxDecoration(
                      color: const Color(0xFF357AD4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 26,
                              left: 20,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Mau kerjain\nlatihan soal\napa hari ini?',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset('assets/mau-latihan.png'))
                        ]),
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pilih Pelajaran',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {}, child: const Text('Lihat Semua')),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  courseResponse == null
                      ? const Center(child: CircularProgressIndicator())
                      : CourseListWidget(
                          courseList: courseResponse?.data ?? []),
                  const SizedBox(
                    height: 27,
                  ),
                  const Text(
                    'Terbaru',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  BlocBuilder<BannerBloc, BannerState>(
                    builder: (context, state) {
                      if (state is BannerFailed) {
                        return Center(child: Text(state.message ?? ''));
                      } else if (state is BannerSuccess) {
                        return BannerListWidget(
                          bannerList: state.bannerResponse.data ?? [],
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
