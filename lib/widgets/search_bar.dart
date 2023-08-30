import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../generated/l10n.dart';
import 'primary_text_field.dart';

class SearchBar extends StatelessWidget {
  SearchBar({super.key, this.onPress, this.isFilter = false});

  final Function()? onPress;
  final bool isFilter;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryTextField(
                      textInputAction: TextInputAction.go,
                      margin: isFilter
                          ? const EdgeInsets.fromLTRB(0, 0, 12, 0)
                          : EdgeInsets.zero,
                      hint: S.of(context).search,
                      prefixIcon: InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: PrimaryIcon(
                            icons: PrimaryIcons.search_outline,
                            color: grayScaleColor2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (isFilter)
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 32,
                            color: const Color(0xff6575A7).withOpacity(0.08),
                            offset: const Offset(0, 8),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: onPress,
                        icon: const Icon(
                          Icons.filter_alt,
                          size: 30,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
