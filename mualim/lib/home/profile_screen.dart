import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/controllers/report_controller.dart';
import 'package:mualim/main.dart';
import 'package:mualim/model/report_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reportController = Get.put(ReportController());
    return Scaffold(
      body: StreamBuilder<ReportModel?>(
        stream: reportController.getReports(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Column(
                  children: [
                    Image.asset(
                      'assets/images/alert.png',
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: double.infinity,
                    ),
                    const Text(
                      'Profile Not Found',
                      style: TextStyle(
                        fontSize: 22.0,
                        color: AppTheme.primary,
                      ),
                    )
                  ],
                );
              } else {
                final data = snapshot.data!;
                double totalScore = 0.0;
                for (var element in data.report) {
                  totalScore = totalScore + double.parse(element.score);
                }
                return Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppTheme.appThemeColor,
                            AppTheme.primary,
                          ],
                        ),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 350.0,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    prefs!.getString('picture') != null
                                        ? Image.file(
                                            File(
                                              prefs!
                                                  .getString('picture')
                                                  .toString(),
                                            ),
                                            fit: BoxFit.fill,
                                          ).image
                                        : Image.network(
                                            'https://1.bp.blogspot.com/-ytMsk6NJCIc/YRDL86N7-CI/AAAAAAAAM_Q/3VFXo2IqsmMxqKbZYlERxjcLX7uA1L67QCLcBGAsYHQ/s500/unique-boys-whatsapp-dp-images-boys-dpz-dp-for-boys-profile-pictures-for-Boys%2B%25281%2529.jpg',
                                            fit: BoxFit.fill,
                                          ).image,
                                radius: 50.0,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                prefs!.getString('username').toString(),
                                style: const TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                prefs!.getString('email').toString(),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0),
                                clipBehavior: Clip.antiAlias,
                                color: Colors.white,
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 22.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            const Text(
                                              "Total Score",
                                              style: TextStyle(
                                                color: AppTheme.primary,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              '${((totalScore / (data.report.length * 100)) * 100).toStringAsFixed(1)}%',
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                                color: AppTheme.fonts,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            const Text(
                                              "Current Module",
                                              style: TextStyle(
                                                color: AppTheme.primary,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Text(
                                              data.report.last.chapter.name,
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                                color: AppTheme.fonts,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.report.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5.0),
                            clipBehavior: Clip.antiAlias,
                            color: Colors.white,
                            elevation: 1.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(15),
                              title: Text(data.report[index].chapter.name),
                              subtitle:
                                  Text(data.report[index].chapter.description),
                              trailing: Text('${data.report[index].score}%'),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              }
          }
        },
      ),
    );
  }
}
