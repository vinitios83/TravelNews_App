import 'package:get/get.dart';
import '../models/association_members.dart';
import '../services/associatin_helper.dart';
import '../services/associations_api.dart';



class AssociationMemberController extends GetxController {
  var isLoading = true.obs;
  var chapterChairman = <ChapterChairman>[].obs;
  var directors = <ChapterChairman>[].obs;
  var members = <ChapterChairman>[].obs;

  String getMemberUrl({
    required String aUserName,
    required String aUserPassword,
    required String aName,
    required String aId,
  }) {
    String url =
        AssociationHelper.membersBaseUrl + DateTime.now().toIso8601String();
    url = url.replaceAll("mmituser", aUserName);
    url = url.replaceAll("mmitpassword", aUserPassword);
    url = url.replaceAll("mASSOID", aId);
    url = url.replaceAll("mAname", aName);
    return url;
  }

  Future<void> fetchMemberList({
    required String aUserName,
    required String aUserPassword,
    required String aName,
    required String aId,
  }) async {
    String url = getMemberUrl(
      aUserName: aUserName,
      aUserPassword: aUserPassword,
      aName: aName,
      aId: aId,
    );
    chapterChairman.clear();
    directors.clear();
    members.clear();
    try {
      if (chapterChairman.isEmpty || directors.isEmpty || members.isEmpty) {
        isLoading(true);
        chapterChairman.clear();
        directors.clear();
        members.clear();
      }
      var myList = await Apis.getMembers(url: url);

      if (myList != null) {
        chapterChairman.addAll(myList.chapterChairman);
        directors.addAll(myList.directors);
        members.addAll(myList.members);
      }
    } finally {
      isLoading(false);
    }
  }
}
