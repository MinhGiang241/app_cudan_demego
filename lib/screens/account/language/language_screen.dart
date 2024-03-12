import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_screen.dart';
import 'cubit/lang_cubit.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LangPrv>().locale;
    return PrimaryScreen(
      appBar: PrimaryAppbar(title: S.of(context).language),
      body: ListView(
        children: [
          vpad(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: PrimaryCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<LangPrv>().setViLang();
                      },
                      child: SizedBox(
                        height: 62,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/vn.svg",
                                width: 32,
                                height: 24,
                              ),
                              hpad(12),
                              Expanded(
                                child: Text(
                                  S.of(context).vi,
                                  style: txtBodySmallRegular(),
                                ),
                              ),
                              if (locale == const Locale("vi", "VN"))
                                const PrimaryIcon(
                                  icons: PrimaryIcons.check,
                                  style: PrimaryIconStyle.none,
                                )
                              else
                                vpad(32),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    InkWell(
                      onTap: () {
                        context.read<LangPrv>().setEnLang();
                      },
                      child: SizedBox(
                        height: 62,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/uk.svg",
                                width: 32,
                                height: 24,
                              ),
                              hpad(12),
                              Expanded(
                                child: Text(
                                  S.of(context).en,
                                  style: txtBodySmallRegular(),
                                ),
                              ),
                              if (locale == const Locale("en", "US"))
                                const PrimaryIcon(
                                  icons: PrimaryIcons.check,
                                  style: PrimaryIconStyle.none,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 1),
                    InkWell(
                      onTap: () {
                        context.read<LangPrv>().setKoLang();
                      },
                      child: SizedBox(
                        height: 62,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/ko.svg",
                                width: 32,
                                height: 24,
                              ),
                              hpad(12),
                              Expanded(
                                child: Text(
                                  S.of(context).ko,
                                  style: txtBodySmallRegular(),
                                ),
                              ),
                              if (locale == const Locale("ko", "KR"))
                                const PrimaryIcon(
                                  icons: PrimaryIcons.check,
                                  style: PrimaryIconStyle.none,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
