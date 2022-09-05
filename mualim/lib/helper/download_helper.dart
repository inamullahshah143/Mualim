import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadHelper {
  static downloadFile(String url) async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(url, "${dir.path}/myFile",
          onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");
      });
    } catch (e) {
      print(e);
    }
    print("Download completed");
  }
}
