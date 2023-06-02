// ignore_for_file: prefer_const_constructors

import 'package:app_cudan/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../widgets/choose_month_year.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_screen.dart';
import 'create_reflection.dart';
import 'prv/reflection_prv.dart';
import 'tab/reflection_tab.dart';

class ReflectionScreen extends StatefulWidget {
  const ReflectionScreen({super.key});
  static const routeName = '/reflection';

  @override
  State<ReflectionScreen> createState() => _ReflectionScreenState();
}

class _ReflectionScreenState extends State<ReflectionScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 6, vsync: this);
  var initIndex = 0;
  bool init = true;
  final isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map?;
    if (arg != null && arg['initTab'] != null && init) {
      initIndex = arg['initTab'];
    }
    return ChangeNotifierProvider(
      create: (context) => ReflectionPrv(),
      builder: (context, builder) {
        tabController.index = initIndex;
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            leading: BackButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.routeName,
                (route) => route.isCurrent,
              ),
            ),
            title: S.of(context).reflection,
            tabController: tabController,
            isTabScrollabel: true,
            tabs: [
              Tab(text: S.of(context).all),
              Tab(text: S.of(context).wait_execute),
              Tab(text: S.of(context).executing),
              Tab(text: S.of(context).executed),
              Tab(text: S.of(context).newl),
              Tab(text: S.of(context).cancel),
            ],
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Center(
                  child: PrimaryIcon(
                    icons: PrimaryIcons.filter,
                    onTap: () {
                      DatePicker.showPicker(
                        context,
                        onChanged: (v) {},
                        onConfirm: (v) {
                          context.read<ReflectionPrv>().onChooseMonthYear(v);
                          setState(() {
                            init = false;
                            initIndex = tabController.index;
                          });
                        },
                        pickerModel: CustomMonthPicker(
                          minTime: DateTime(DateTime.now().year - 10, 1, 1),
                          maxTime: DateTime(DateTime.now().year + 10, 12, 31),
                          currentTime: DateTime(
                            context.read<ReflectionPrv>().year ??
                                DateTime.now().year,
                            context.read<ReflectionPrv>().month ??
                                DateTime.now().month,
                            1,
                          ),
                          locale: LocaleType.vi,
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: S.of(context).add_new,
            onPressed: () {
              Navigator.pushNamed(
                context,
                CreateReflection.routeName,
                arguments: {
                  'isEdit': false,
                },
              );
            },
            backgroundColor: primaryColorBase,
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
          body: SafeArea(
            // ignore: prefer_const_literals_to_create_immutables
            child: TabBarView(
              controller: tabController,
              children: [
                ReflectionTab(
                  tabIndex: 0,
                ),
                ReflectionTab(
                  tabIndex: 1,
                ),
                ReflectionTab(
                  tabIndex: 2,
                ),
                ReflectionTab(
                  tabIndex: 3,
                ),
                ReflectionTab(
                  tabIndex: 4,
                ),
                ReflectionTab(
                  tabIndex: 5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
