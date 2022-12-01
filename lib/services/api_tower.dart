import 'package:app_cudan/models/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';

import '../../models/response_bantinduan_details.dart';
import '../generated/l10n.dart';
import '../models/response_apartment.dart';
import '../models/response_bantinduan_list.dart';
import '../models/response_comments.dart';
import '../models/response_construction_profile.dart';
import '../models/response_create_comment.dart';
import '../models/response_danh_muc_bantin.dart';
import '../models/response_forums.dart';
import '../models/response_like.dart';
import '../models/response_lost_and_found_list.dart';
import '../models/response_news_details.dart';
import '../models/response_news_list_model.dart';
import '../models/response_parcel_list.dart';
import '../models/response_parking_card_model.dart';
import '../models/response_pet_list_model.dart';
import '../models/resident_info.dart';
import '../models/response_thecudan_list.dart';
import 'api_service.dart';

class APITower {
  static Future getResidentInfo(String userName) async {
    var query = '''
    mutation (\$userName:String){
    response: resident_mobile_get_resident_info_by_account (userName: \$userName ) {
        code
        message
        data
    }
    }    
       
    ''';
    final MutationOptions options = MutationOptions(
        document: gql(query), variables: {"userName": userName});

    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future getUserOwnInfo(String residentId) async {
    var queryGetUserInfo = '''
    mutation (\$residentId:String){
    response: resident_mobile_get_resident_own_info (residentId: \$residentId ) {
        code
        message
        data
    }
}

  ''';

    final MutationOptions options = MutationOptions(
      document: gql(queryGetUserInfo),
      variables: {
        "residentId": residentId,
      },
    );
    final results = await ApiService.shared.mutationhqlQuery(options);

    var res = ResponseModule.fromJson(results);

    if (res.response.code != 0) {
      throw (res.response.message ?? "");
    } else {
      return res.response.data;
    }
  }

  static Future<ResponseNewsDetails> getNewsDetails(
      BuildContext context, String id) async {
    final data = await ApiService.shared.getApi(
      path: 'api/content/$id',
    );
    // print(data);
    return ResponseNewsDetails.fromJson(data);
  }

  static Future<ResponseBanTinDuAnList> getBanTinDuAn(
      {required BuildContext context,
      String? tag,
      int? pageSize,
      int? currentPage}) async {
    var params = <String, dynamic>{};

    var value = <String, dynamic>{};
    if (tag != null) {
      value['Tag'] = "'$tag'";
    }
    if (pageSize != null) {
      value['PageSize'] = pageSize;
    }
    if (currentPage != null) {
      value['Page'] = currentPage;
    }

    params['parameters'] = value;

    const String queries = r'''
    query getAllBanTinDuAn($parameters: String!) {
  getBanTinDuAn(parameters: $parameters) {
    total
    items {
      contentItemId
      contentType
      createdUtc
      displayText
      hinhAnh {
        paths
        urls
      }
      noiDung
      owner
      privateBanTin {
        soLuongComment
        soLuongLike
      }
      publishedUtc
      tieuDe
      danhMuc {
        taxonomyContentItemId
        termContentItemIds
      }
      list {
        contentItems {
          ... on LikeBanTin {
            owner
            contentItemId
          }
        }
      }
      privateCreator {
        anhDaiDien {
          paths
          urls
        }
        creatorId
        fullName
      }
    }
  }
}
''';

    final QueryOptions options = QueryOptions(
        document: gql(queries),
        variables: {
          "parameters": params.isEmpty ? null : "${params['parameters']}"
        });
    final data = await ApiService.shared.graphqlQuery(options);
    return ResponseBanTinDuAnList.fromJson(data);
  }

  static Future<ResponseComments> getComments(
      {required String id, required BuildContext context}) async {
    var params = <String, dynamic>{};

    params['parameters'] = "{ParentId: '$id'}";
    // final data = await ApiService.shared.getApi(
    //     path: 'api/queries/paging/GetCommentBanTin',
    //     params: params.isEmpty ? null : params);
    const String queries = r'''
    query getCommentBanTin($parameters: String!) {
  getCommentBanTin(parameters: $parameters) {
    total
    items {
      contentItemId
      contentType
      displayText
      createdUtc
      publishedUtc
      noiDung
      privateCreator {
        fullName
        anhDaiDien {
          paths
          urls
        }
      }
      privateBanTin {
        banTinId
        soLuongComment
        soLuongLike
      }
      list {
        contentItems {
          ... on LikeBanTin {
            owner
            contentItemId
          }
        }
      }
    }
  }
}

''';

    final QueryOptions options = QueryOptions(
        document: gql(queries),
        variables: {"parameters": "${params['parameters']}"});
    final data = await ApiService.shared.graphqlQuery(
      options,
    );
    return ResponseComments.fromJson(data);
  }

  static Future<ResponseBanTinDuAnDetails> getBTDADetails(
      String id, BuildContext context) async {
    final data = await ApiService.shared.getApi(
      path: 'api/content/$id',
    );
    // print(data);
    return ResponseBanTinDuAnDetails.fromJson(data);
  }

  static Future<ResponsePetList> getPetsList(
      {int? pageSize, int? currentPage, required BuildContext context}) async {
    var params = <String, dynamic>{};
    var value = <String, dynamic>{};
    if (pageSize != null) {
      value['PageSize'] = pageSize;
    }
    if (currentPage != null) {
      value['Page'] = currentPage;
    }
    if (value.isNotEmpty) {
      params['parameters'] = value;
    }
    final data = await ApiService.shared.getApi(
      path: 'api/queries/GetListVatNuoi',
      params: params.isEmpty ? null : params,
    );
    // print(data);
    return ResponsePetList.fromJson(data);
  }

  static Future<ResponseConstructionProfileList> getConstructionList(
      {int? pageSize, int? currentPage, required BuildContext context}) async {
    var params = <String, dynamic>{};
    var value = <String, dynamic>{};
    if (pageSize != null) {
      value['PageSize'] = pageSize;
    }
    if (currentPage != null) {
      value['Page'] = currentPage;
    }
    if (value.isNotEmpty) {
      params['parameters'] = value;
    }
    final data = await ApiService.shared.getApi(
      path: 'api/queries/paging/GetListDangKyThiCong',
      params: params.isEmpty ? null : params,
    );
    // print(data);
    return ResponseConstructionProfileList.fromJson(data);
  }

  static Future<ResponseTheCuDanList> getTheCuDan(
      {int? pageSize, int? currentPage}) async {
    var params = <String, dynamic>{};
    var value = <String, dynamic>{};
    if (pageSize != null) {
      value['PageSize'] = pageSize;
    }
    if (currentPage != null) {
      value['Page'] = currentPage;
    }
    if (value.isNotEmpty) {
      params['parameters'] = value;
    }
    final data = await ApiService.shared.getApi(
      path: 'api/queries/GetTheCuDan',
      params: params.isEmpty ? null : params,
    );
    // print(data);
    return ResponseTheCuDanList.fromJson(data);
  }

  static Future<ResponseParcelList> getParcelList(
      {int? pageSize, int? currentPage}) async {
    var params = <String, dynamic>{};
    var value = <String, dynamic>{};
    if (pageSize != null) {
      value['PageSize'] = pageSize;
    }
    if (currentPage != null) {
      value['Page'] = currentPage;
    }
    if (value.isNotEmpty) {
      params['parameters'] = value;
    }
    final data = await ApiService.shared.getApi(
      path: 'api/queries/GetBuuPham',
      params: params.isEmpty ? null : params,
    );
    // print(data);
    return ResponseParcelList.fromJson(data);
  }

  static Future<ResponseLostAndFoundList> getLostAndFoundList(
      {int? pageSize, int? currentPage, required BuildContext context}) async {
    var params = <String, dynamic>{};
    var value = <String, dynamic>{};
    if (pageSize != null) {
      value['PageSize'] = pageSize;
    }
    if (currentPage != null) {
      value['Page'] = currentPage;
    }
    if (value.isNotEmpty) {
      params['parameters'] = value;
    }
    final data = await ApiService.shared.getApi(
      path: 'api/queries/GetAllLostAndFound',
      params: params.isEmpty ? null : params,
    );
    // print(data);
    return ResponseLostAndFoundList.fromJson(data);
  }

  static Future<ResponseApartment> getApartments(BuildContext context) async {
    final data =
        await ApiService.shared.getApi(path: 'api/mobile/getAllApartment');
    // print(data);
    return ResponseApartment.fromJson(data);
  }

  static Future<ResponseDanhMucBanTin> getDanhMucBanTin(
      {required String alias, required BuildContext context}) async {
    var params = <String, dynamic>{};

    var value = <String, dynamic>{};
    value['Alias'] = "'$alias'";

    params['parameters'] = value;

    const String queries = r'''
    query getDanhMucBanTin($parameters: String!) {
  getTaxonomyByAlias(parameters: $parameters) {
    items {
      contentItemId
      displayText
      alias {
        alias
      }
      taxonomy {
        contentItems {
          displayText
          contentItemId
        }
      }
    }
  }
}
''';

    final QueryOptions options = QueryOptions(
        document: gql(queries),
        variables: {
          "parameters": params.isEmpty ? null : "${params['parameters']}"
        });
    final data = await ApiService.shared.graphqlQuery(options);
    return ResponseDanhMucBanTin.fromJson(data);
  }

  static Future<ResponseNewsList> getNewsList(
      {String? tag,
      int? pageSize,
      int? currentPage,
      required BuildContext context}) async {
    var params = <String, dynamic>{};

    var value = <String, dynamic>{};
    if (tag != null) {
      value['Tag'] = "'$tag'";
    }
    if (pageSize != null) {
      value['PageSize'] = pageSize;
    }
    if (currentPage != null) {
      value['Page'] = currentPage;
    }

    params['parameters'] = value;

    const String queries = r'''
    query getAllBanTinQuery($parameters: String!) {
  getAllBanTin(parameters: $parameters) {
    items {
      contentItemId
      tieuDe
      publishedUtc
      privateBanTin {
        soLuongComment
        soLuongLike
      }
      owner
      noiDung
      danhMuc {
        taxonomyContentItemId
        termContentItemIds
      }
      anhBia {
        paths
        urls
      }
      author
      contentItemId
      contentType
      createdUtc
      list {
        contentItems {
          ... on LikeBanTin {
            owner
            contentItemId
          }
        }
      }
      privateCreator {
        anhDaiDien {
          paths
          urls
        }
        creatorId
        fullName
      }
    }
    total
  }
}
''';

    final QueryOptions options = QueryOptions(
        document: gql(queries),
        variables: {
          "parameters": params.isEmpty ? null : "${params['parameters']}"
        });
    final data = await ApiService.shared.graphqlQuery(options);
    return ResponseNewsList.fromJson(data);
  }

  static Future<ResponseForums> getForums(
      {required bool published,
      int? pageSize,
      int? currentPage,
      required BuildContext context}) async {
    var params = <String, dynamic>{};

    var value = <String, dynamic>{};
    value['Published'] = published;
    if (pageSize != null) {
      value['PageSize'] = pageSize;
    }
    if (currentPage != null) {
      value['Page'] = currentPage;
    }
    params['parameters'] = value;

    const String queries = r'''
    query getAllBanTinDienDanQuery($parameters: String!) {
    getAllBanTinDienDan(parameters: $parameters) {
    total
    items {
      contentItemId
      createdUtc
      displayText
      modifiedUtc
      publishedUtc
      tieuDe
      danhMuc {
        taxonomyContentItemId
        termContentItemIds
      }
      noiDung
      hinhAnh {
        paths
        urls
      }
      owner
      privateBanTin {
        soLuongComment
        soLuongLike
      }
      list {
        contentItems {
          ... on LikeBanTin {
            contentItemId
            owner
          }
        }
      }
       privateCreator {
        anhDaiDien {
          paths
          urls
        }
        creatorId
        fullName
      }
    }
  }
}
''';

    final QueryOptions options = QueryOptions(
        document: gql(queries),
        variables: {"parameters": "${params['parameters']}"});
    final data = await ApiService.shared.graphqlQuery(options);

    return ResponseForums.fromJson(data);
  }

  static Future<ResponseLike> likeBanTin(
      {required String idBanTin,
      required String idUser,
      required BuildContext context}) async {
    final body = {
      "ContentType": "LikeBanTin",
      "Owner": idUser,
      "ContainedPart": {"ListContentItemId": idBanTin}
    };
    final data = await ApiService.shared
        .postApi(path: 'api/content', data: body, context: context);
    // print(data);
    return ResponseLike.fromJson(data);
  }

  static Future<ResponseLike> unlikeBantin(
      {required String id, required BuildContext context}) async {
    final data = await ApiService.shared
        .deleteApi(path: 'api/content/$id', context: context);
    // print(data);
    return ResponseLike.fromJson(data);
  }

  static Future<ResponseCreateComment> comment(
      {required BuildContext context,
      required String idBanTin,
      required String idUser,
      required String content}) async {
    final body = {
      "ContentType": "CommentBanTin",
      "Owner": idUser,
      "CommentBanTin": {
        "NoiDung": {"Text": content}
      },
      "ContainedPart": {"ListContentItemId": idBanTin},
      "PrivateBanTinPart": {
        "BanTinId": {"Text": idBanTin}
      }
    };
    final data = await ApiService.shared
        .postApi(path: 'api/content', data: body, context: context);
    // print(data);
    return ResponseCreateComment.fromJson(data);
  }
}
