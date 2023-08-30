import 'package:app_cudan/models/info_content_view.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_card.dart';
import '../../widgets/primary_empty_widget.dart';
import '../../widgets/primary_error_widget.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_loading.dart';
import '../../widgets/primary_screen.dart';
import 'add_new_proj_reg_screen.dart';
import 'prv/ho_account_service_prv.dart';
import 'resident_registration_details_screen.dart';
import 'select_project_screen.dart';

class ProjectRegistrationScreen extends StatefulWidget {
  const ProjectRegistrationScreen({super.key});
  static const routeName = '/project-registration';

  @override
  State<ProjectRegistrationScreen> createState() =>
      _ProjectRegistrationScreenState();
}

class _ProjectRegistrationScreenState extends State<ProjectRegistrationScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return PrimaryScreen(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pushReplacementNamed(
            context,
            SelectProjectScreen.routeName,
            arguments: {
              "not-auto": true,
            },
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              context.read<HOAccountServicePrv>().logOutHO(context);
            },
            icon: const Icon(Icons.logout),
          ),
          hpad(12),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                S.of(context).waiting_project_resistration,
                style: txtDisplayMedium(),
                textAlign: TextAlign.center,
              ),
            ),
            vpad(10),
            Expanded(
              child: FutureBuilder(
                future: context
                    .read<HOAccountServicePrv>()
                    .getRegisterList(context),
                builder: (context, snapshot) {
                  var list =
                      context.watch<HOAccountServicePrv>().registrationList;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: PrimaryLoading());
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return PrimaryErrorWidget(
                      code: snapshot.hasError ? 'err' : '1',
                      message: snapshot.data.toString(),
                      onRetry: () async {
                        setState(() {});
                      },
                    );
                  } else if (list.isEmpty) {
                    return SafeArea(
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: false,
                        header: WaterDropMaterialHeader(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        controller: _refreshController,
                        onRefresh: () {
                          setState(() {});
                          _refreshController.refreshCompleted();
                        },
                        child: PrimaryEmptyWidget(
                          emptyText: S.of(context).no_reg_proj,
                          icons: PrimaryIcons.detail,
                          action: () {},
                        ),
                      ),
                    );
                  }

                  return SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: WaterDropMaterialHeader(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    controller: _refreshController,
                    onRefresh: () {
                      setState(() {});
                      _refreshController.refreshCompleted();
                    },
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        ...list.map(
                          (e) {
                            var isGuest =
                                e.accountType?.toUpperCase() == "GUEST";
                            return PrimaryCard(
                              onTap: () async {
                                Navigator.pushNamed(
                                  context,
                                  ResidentRegistrationDetailsScreen.routeName,
                                  arguments: e,
                                );
                              },
                              margin: const EdgeInsets.only(
                                bottom: 16,
                                // left: 12,
                                // right: 12,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 12,
                              ),
                              child: Row(
                                children: [
                                  PrimaryIcon(
                                    icons: PrimaryIcons.follow_service,
                                    style: PrimaryIconStyle.gradient,
                                    gradients: PrimaryIconGradient.green,
                                    size: 32,
                                    padding: EdgeInsets.all(12),
                                    color: Colors.white,
                                  ),
                                  hpad(10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.project?.project_name ?? "",
                                          style:
                                              txtBold(12, grayScaleColorBase),
                                        ),
                                        Text(
                                          "${S.of(context).account_type}: ${isGuest ? S.of(context).guest : S.of(context).resident}",
                                          style: txtRegular(
                                            13,
                                            grayScaleColorBase,
                                          ),
                                        ),
                                        // if (!isGuest)
                                        //   Text(
                                        //     "${S.of(context).apartment}: ${e.apartmentCode ?? ""}",
                                        //     style: txtRegular(
                                        //       13,
                                        //       grayScaleColorBase,
                                        //     ),
                                        //   ),
                                        // if (!isGuest)
                                        //   Row(
                                        //     children: [
                                        //       Icon(Icons.usb_sharp),
                                        //       Text(
                                        //         e.relationship ?? '',
                                        //         style: txtRegular(
                                        //           12,
                                        //           grayScaleColorBase,
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_month_outlined),
                                            Text(
                                              Utils.dateFormat(
                                                e.updatedTime ?? '',
                                                1,
                                              ),
                                              style: txtRegular(
                                                12,
                                                grayScaleColorBase,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${S.of(context).status}: ',
                                              style: txtRegular(
                                                12,
                                                grayScaleColorBase,
                                              ),
                                            ),
                                            Text(
                                              genResRegStatusString(e.status),
                                              style: txtBold(
                                                12,
                                                genResRegStatusColor(e.status),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (e.note != null)
                                          Text(
                                            e.note ?? "",
                                            style: txtRegular(
                                              12,
                                              grayScaleColor3,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            PrimaryButton(
              onTap: () {
                Navigator.pushNamed(context, AddNewProjRegScreen.routeName);
              },
              width: double.infinity,
              text: S.of(context).create_reg_proj,
              icon: Icon(Icons.add, color: Colors.white, size: 24),
            ),
            vpad(10),
          ],
        ),
      ),
    );
  }
}
