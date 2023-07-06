import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../widgets/primary_empty_widget.dart';
import '../../widgets/primary_error_widget.dart';
import '../../widgets/primary_icon.dart';
import '../../widgets/primary_loading.dart';
import '../../widgets/primary_screen.dart';
import '../auth/prv/auth_prv.dart';
import 'prv/ho_account_service_prv.dart';

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
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthPrv>().onSignOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
          hpad(12)
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
                  var list = [];
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
                      children: [Text("kldsdldfksldskdlasdkjaskljklj")],
                    ),
                  );
                },
              ),
            ),
            PrimaryButton(
              width: double.infinity,
              text: "Tạo đăng ký mới",
              icon: Icon(Icons.add, color: Colors.white, size: 24),
            ),
            vpad(10)
          ],
        ),
      ),
    );
  }
}
