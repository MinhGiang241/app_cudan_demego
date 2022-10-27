import 'package:flutter/material.dart';

class SelectionModel {
  final String title;
  bool isSelected;
  final Widget? icon;

  SelectionModel({required this.title, this.isSelected = false, this.icon});
}
