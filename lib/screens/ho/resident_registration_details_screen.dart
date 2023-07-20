import 'package:app_cudan/services/api_ho_account.dart';
import 'package:app_cudan/utils/utils.dart';
import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_button.dart';
import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:app_cudan/widgets/primary_info_widget.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../models/ho_model.dart';
import '../../models/info_content_view.dart';

class ResidentRegistrationDetailsScreen extends StatelessWidget {
  const ResidentRegistrationDetailsScreen({super.key});
  static const routeName = '/project-registration/details';

  @override
  Widget build(BuildContext context) {
    final arg =
        ModalRoute.of(context)!.settings.arguments as ResidentResitration;
    var isGuest = arg.accountType?.toUpperCase() == 'GUEST';
    return PrimaryScreen(
      appBar: PrimaryAppbar(
        title: S.of(context).reg_info,
      ),
      body: ListView(
        children: [
          vpad(20),
          PrimaryInfoWidget(
            label: S.of(context).reg_info,
            listInfoView: [
              InfoContentView(
                isHorizontal: true,
                title: S.of(context).project,
                content: arg.project?.project_name,
                contentStyle: txtBodySmallBold(color: grayScaleColorBase),
              ),
              InfoContentView(
                isHorizontal: true,
                title: S.of(context).account_type,
                content: isGuest ? S.of(context).guest : S.of(context).resident,
                contentStyle: txtBodySmallBold(color: grayScaleColorBase),
              ),
              if (!isGuest)
                InfoContentView(
                  isHorizontal: true,
                  title: S.of(context).apartment,
                  content: arg.apartmentCode,
                  contentStyle: txtBodySmallBold(color: grayScaleColorBase),
                ),
              if (!isGuest)
                InfoContentView(
                  isHorizontal: true,
                  title: S.of(context).relation_with_owner,
                  content: arg.relationship,
                  contentStyle: txtBodySmallBold(color: grayScaleColorBase),
                ),
              // InfoContentView(
              //   isHorizontal: true,
              //   title: S.of(context).sell_contract_num,
              //   content: arg.contractCode,
              //   contentStyle: txtBodySmallBold(color: grayScaleColorBase),
              // ),
            ],
          ),
          vpad(12),
          PrimaryInfoWidget(
            label: S.of(context).appoved_status,
            listInfoView: [
              InfoContentView(
                isHorizontal: true,
                title: S.of(context).project,
                content: arg.project?.project_name,
                contentStyle: txtBodySmallBold(color: grayScaleColorBase),
              ),
              InfoContentView(
                isHorizontal: true,
                title: S.of(context).result_date,
                content: Utils.dateFormat(arg.updatedTime ?? '', 1),
                contentStyle: txtBodySmallBold(color: grayScaleColorBase),
              ),
              InfoContentView(
                isHorizontal: true,
                title: S.of(context).result_date,
                content: genResRegStatusString(arg.status),
                contentStyle: txtBold(14, genResRegStatusColor(arg.status)),
              ),
              if (arg.note != null)
                InfoContentView(
                  isHorizontal: true,
                  title: S.of(context).note_content,
                  content: arg.note,
                  contentStyle: txtBodySmallBold(color: grayScaleColorBase),
                ),
            ],
          ),
          vpad(20),
          FutureBuilder(
            future: () async {
              return await APIHOAccount.getSupportPhoneNumber();
            }(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var phone = snapshot.data;
                print(phone);
                return PrimaryButton(
                  icon: PrimaryIcon(
                    icons: PrimaryIcons.phone_call,
                    color: Colors.white,
                  ),
                  text: S.of(context).sys_support,
                  buttonType: ButtonType.green,
                  onTap: () async {
                    await FlutterPhoneDirectCaller.callNumber(phone);
                  },
                );
              }
              return vpad(0);
            },
          ),
          vpad(30),
        ],
      ),
    );
  }
}
