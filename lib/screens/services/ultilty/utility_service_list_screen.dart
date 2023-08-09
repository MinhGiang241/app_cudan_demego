import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../services/api_service.dart';
import '../../../widgets/primary_empty_widget.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_image_netword.dart';
import '../../../widgets/primary_loading.dart';
import '../extra_service/extra_service_card_list.dart';
import 'prv/utility_service_list_prv.dart';

class UtilityServiceListScreen extends StatefulWidget {
  const UtilityServiceListScreen({super.key});
  static const routeName = "/ultility-service-sceen";

  @override
  State<UtilityServiceListScreen> createState() =>
      _UtilityServiceListScreenState();
}

class _UtilityServiceListScreenState extends State<UtilityServiceListScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UtilityServiceListPrv(),
      builder: (context, state) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
            title: "Dịch vụ tiện ích",
          ),
          body: FutureBuilder(
            future:
                context.read<UtilityServiceListPrv>().getExtraService(context),
            builder: (context, snapshot) {
              var list =
                  context.watch<UtilityServiceListPrv>().listExtraService;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: PrimaryLoading(),
                );
              } else if (snapshot.hasError) {
                return PrimaryErrorWidget(
                  code: snapshot.hasError ? "err" : "1",
                  message: snapshot.data.toString(),
                  onRetry: () async {
                    setState(() {});
                  },
                );
              }
              if (list.isEmpty) {
                return SafeArea(
                  child: PrimaryEmptyWidget(
                    emptyText: "Không có dịch vụ nào",
                    icons: PrimaryIcons.setting,
                    action: () {},
                  ),
                );
              }
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(right: 20, top: 20, left: 20),
                  child: SizedBox(
                    height: dvHeight(context) - 100,
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 18,
                      crossAxisSpacing: 15,
                      childAspectRatio: 1.4,
                      children: [
                        ...list.map(
                          (e) => InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                ExtraServiceCardListScreen.routeName,
                                arguments: {
                                  "service": e,
                                  "year": DateTime.now().year,
                                  "month": DateTime.now().month
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                // gradient: gradientW,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(
                                      0,
                                      3,
                                    ), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          blurStyle: BlurStyle.normal,
                                          spreadRadius: 1,
                                          blurRadius: 24,
                                          color: (primaryColorBase).withOpacity(
                                            0.25,
                                          ),
                                          offset: const Offset(
                                            0,
                                            16,
                                          ),
                                        )
                                      ],
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                          5,
                                        ),
                                      ),
                                      gradient: gradientBlue,
                                    ),
                                    child: PrimaryImageNetwork(
                                      canShowPhotoView: false,
                                      fit: BoxFit.contain,
                                      path:
                                          "${ApiService.shared.uploadURL}?load=${e.service_icon!.id ?? ""}&regcode=${ApiService.shared.regCode}",
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                          5,
                                        ),
                                      ),
                                    ),

                                    // Image.network(

                                    //     fit: BoxFit.contain,
                                    //     width: 20,
                                    //     height: 20,
                                    //     "${ApiConstants.uploadURL}?load=${e.service_icon!.id ?? ""}"),
                                  ),
                                  vpad(7),
                                  Flexible(
                                    child: Text(
                                      e.name ?? "",
                                      style: txtBold(13),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        vpad(0),
                        vpad(0),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
