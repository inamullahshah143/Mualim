import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/controllers/search_controller.dart';
import 'package:mualim/model/search_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(SearchController());
    final searchKey = ''.obs;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 20,
                ),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) {
                    searchKey.value = value;
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: AppTheme.secondary.withOpacity(0.075),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search Chapter by Name',
                    hintStyle: TextStyle(
                      color: AppTheme.fonts.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
                endIndent: 25,
                indent: 25,
              ),
              Obx(() {
                return FutureBuilder<SearchModel?>(
                  future: searchController.searchChapters(searchKey, context),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const CircularProgressIndicator();
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final data = snapshot.data!;
                          return ListView.builder(
                            padding: const EdgeInsets.only(top: 0),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.chapter.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 2.5),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                isThreeLine: true,
                                leading: CircleAvatar(
                                  backgroundColor: AppTheme.appThemeColor,
                                  child: Text(
                                    "${index + 1}",
                                    style:
                                        const TextStyle(color: AppTheme.white),
                                  ),
                                ),
                                title: Text(
                                  data.chapter[index].name.toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  data.chapter[index].description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.play_arrow_rounded),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          );
                        }
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
