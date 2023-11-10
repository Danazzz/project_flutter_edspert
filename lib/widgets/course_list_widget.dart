import 'package:edspert/model/course_response_mode.dart';
import 'package:flutter/material.dart';

class CourseListWidget extends StatelessWidget {
  final List<CourseData> courseList;
  const CourseListWidget({super.key, required this.courseList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(
        height: 15,
      ),
      itemBuilder: (context, index) {
        final course = courseList[index];

        return Container(
          height: 96,
          padding: const EdgeInsets.symmetric(
            vertical: 22,
            horizontal: 18,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F7F8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    course.urlCover ?? '',
                    width: 28,
                    height: 28,
                  )),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.majorName ?? 'No Course Name',
                    ),
                    Text(
                      '${course.jumlahDone} / ${course.jumlahMateri} Paket Latihan Soal',
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const LinearProgressIndicator(
                      value: 0.5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
