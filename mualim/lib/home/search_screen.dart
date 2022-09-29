import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mualim/constants/app_theme.dart';
import 'package:mualim/controllers/search_controller.dart';
import 'package:mualim/model/search_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(SearchController());
    return Scaffold(
      body: SafeArea(
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
                onChanged: (value) {},
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
            FutureBuilder<SearchModel?>(
              future:
                  searchController.searchChapters('', context),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Expanded(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final data = snapshot.data;
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 0),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data!.,
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
                                style: const TextStyle(color: AppTheme.white),
                              ),
                            ),
                            title: Text(
                              data.subject.chapter[index].name.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              data.subject.chapter[index].description,
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
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 2.5),
                  child: MaterialButton(
                    onPressed: () {},
                    elevation: 1.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      isThreeLine: true,
                      title: const Text(
                        'Chapter Title',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: const Text(
                        'Details screen',
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
              }),
            ),
          ],
        ),
      ),
    );
  }
}
