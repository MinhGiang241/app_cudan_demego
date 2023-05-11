// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import '../../../../generated/l10n.dart';
import '../../../../models/list_transport.dart';
import '../../../../models/manage_card.dart';
import '../../../../models/transportation_card.dart';
import '../../../../services/api_transport.dart';
import '../../../../utils/utils.dart';
import '../manage_card_details_screen.dart';

class ExtendTransportPrv extends ChangeNotifier {
  ExtendTransportPrv({
    this.card,
    this.index,
    this.item,
    this.cancel,
  }) {
    if (card != null) {
      // expireValue = item?.shelfLifeId;
      if (DateTime.tryParse(item?.expire_date ?? "") != null) {
        var oldDate =
            DateTime.parse(item!.expire_date!).add(const Duration(hours: 7));
        oldExpireController.text =
            Utils.dateFormat(oldDate.toIso8601String(), 1);
        extendController.text =
            Utils.dateFormat(DateTime.now().toIso8601String(), 1);
      }
    }
  }
  ListTransport? item;
  final formKey = GlobalKey<FormState>();
  bool autoValid = false;
  DateTime? regDate;
  DateTime? expireDate;
  DateTime? newExpireDate;
  Function? cancel;
  formValidation() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      clearValidString();
    } else {
      genValidString();
    }
  }

  clearValidString() {
    expireValiate = null;
    notifyListeners();
  }

  genValidString() {
    if (expireValue == null) {
      expireValiate = S.current.not_blank;
    } else {
      expireValiate = null;
    }
    notifyListeners();
  }

  final TextEditingController oldExpireController = TextEditingController();
  final TextEditingController newExpireController = TextEditingController();
  final TextEditingController extendController = TextEditingController();

  List<ShelfLife> shelfLifeList = [];

  String? expireValiate;
  String? expireValue;

  bool isLoading = false;

  onChange(v) {
    expireValue = v;
    var shelf =
        shelfLifeList.firstWhere((element) => element.id == expireValue);

    if (shelf.type_time?.toLowerCase() == 'tháng') {
      newExpireDate = DateTime(
        expireDate!.year,
        expireDate!.month + (shelf.use_time ?? 0),
        expireDate!.day,
      );
    }
    if (shelf.type_time?.toLowerCase() == 'năm') {
      newExpireDate = DateTime(
        expireDate!.year + (shelf.use_time ?? 0),
        expireDate!.month,
        expireDate!.day,
      );
    }
    if (shelf.type_time?.toLowerCase() == 'ngày') {
      newExpireDate = DateTime(
        expireDate!.year,
        expireDate!.month,
        expireDate!.day + (shelf.use_time ?? 0),
      );
    }
    newExpireController.text =
        Utils.dateFormat(newExpireDate!.toIso8601String(), 0);
    notifyListeners();
  }

  ManageCard? card;
  int? index;

  Future getShelfLife(BuildContext context) async {
    await APITransport.getShelfLife().then((v) {
      shelfLifeList.clear();
      if (v != null) {
        v.forEach((e) {
          shelfLifeList.add(ShelfLife.fromMap(e));
        });
        expireDate = DateTime.parse(item!.expire_date ?? "")
            .add(const Duration(hours: 7));

        // ShelfLife? shelf =
        //     shelfLifeList.firstWhere((element) => element.id == expireValue, );
        // regDate = DateTime.parse(card?.registration_date ?? '');
        // if (shelf.type_time?.toLowerCase() == 'tháng') {
        //   expireDate = DateTime(
        //     regDate!.year,
        //     regDate!.month + (shelf.use_time ?? 0),
        //     regDate!.day,
        //   );
        // }
        // if (shelf.type_time?.toLowerCase() == 'năm') {
        //   expireDate = DateTime(
        //     regDate!.year + (shelf.use_time ?? 0),
        //     regDate!.month,
        //     regDate!.day,
        //   );
        // }
        // if (shelf.type_time?.toLowerCase() == 'ngày') {
        //   expireDate = DateTime(
        //     regDate!.year,
        //     regDate!.month,
        //     regDate!.day + (shelf.use_time ?? 0),
        //   );
        // }
        oldExpireController.text =
            Utils.dateFormat(expireDate!.toIso8601String(), 0);

        newExpireDate = expireDate;
        newExpireController.text =
            Utils.dateFormat(newExpireDate!.toIso8601String(), 0);
      }
    });
  }

  onSubmit(BuildContext context) async {
    isLoading = true;
    autoValid = true;
    notifyListeners();
    if (formKey.currentState!.validate()) {
      // var formRenew = FormRenewalTransport(
      //   expire_date:
      //       newExpireDate?.subtract(const Duration(hours: 7)).toIso8601String(),
      //   expire_date_old:
      //       expireDate?.subtract(const Duration(hours: 7)).toIso8601String(),
      //   shelfLifeId: expireValue,
      //   listTransportId: item?.id,
      //   renewal_date:
      //       regDate?.subtract(const Duration(hours: 7)).toIso8601String(),
      //   // transports_list: card?.t?.transports_list
      // );

      item?.expire_date =
          newExpireDate?.subtract(const Duration(hours: 7)).toIso8601String();
      item?.shelfLifeId = expireValue;

      await APITransport.renewDateTransport(
        [item?.toMap()],
        item?.shelfLifeId,
        true,
      ).then((v) {
        isLoading = false;
        notifyListeners();
        Utils.showSuccessMessage(
          context: context,
          e: S.of(context).succees_extend_trans,
          onClose: () {
            Navigator.pushReplacementNamed(
              context,
              ManageCardDetailsScreen.routeName,
              arguments: {
                "card": card,
                "cancel": cancel,
              },
            );
          },
        );
      }).catchError((e) {
        isLoading = false;

        notifyListeners();
        Utils.showErrorMessage(context, e);
      });
    } else {
      isLoading = false;
      genValidString();
    }
  }
}
