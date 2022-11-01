import 'package:flutter/material.dart';

import '../../../models/bill_model.dart';

class BillsPrv extends ChangeNotifier {
  bool selectAll = false;

  final List<BillModel> listBill = [
    BillModel(
        code: "AAAA",
        name: "Hoá đơn tiền điện",
        content: "Hoá đơn tiền điện tháng 2",
        date: "2022-02-02",
        price: 1578000,
        status: "Status",
        vat: 0),
    BillModel(
        code: "AAAA",
        name: "Hoá đơn tiền điện",
        content: "Hoá đơn tiền điện tháng 2",
        date: "2022-02-02",
        price: 1578000,
        status: "Status",
        vat: 0),
    BillModel(
        code: "AAAA",
        name: "Hoá đơn tiền điện",
        content: "Hoá đơn tiền điện tháng 2",
        date: "2022-03-03",
        price: 1578000,
        status: "Status",
        vat: 0),
    BillModel(
        code: "AAAA",
        name: "Hoá đơn tiền điện",
        content: "Hoá đơn tiền điện tháng 2",
        date: "2022-03-03",
        price: 1578000,
        status: "Status",
        vat: 0)
  ];

  onSelect(int index) {
    listBill[index].isSelected = !listBill[index].isSelected;
    notifyListeners();
  }

  onSelectAll() {
    selectAll = !selectAll;
    for (var i = 0; i < listBill.length; i++) {
      if (selectAll) {
        listBill[i].isSelected = true;
      } else {
        listBill[i].isSelected = false;
      }
    }
    notifyListeners();
  }
}
