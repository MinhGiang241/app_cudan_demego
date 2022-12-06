import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/service_registration.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_error_widget.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_loading.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import 'prv/extra_service_registration_prv.dart';

class ExtraServiceRegistrationScreen extends StatefulWidget {
  const ExtraServiceRegistrationScreen({super.key});
  static const routeName = '/extra-service/register';

  @override
  State<ExtraServiceRegistrationScreen> createState() =>
      _ExtraServiceRegistrationScreenState();
}

class _ExtraServiceRegistrationScreenState
    extends State<ExtraServiceRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;

    var isEdit = arg['isEdit'];
    var service = arg['service'];
    ServiceRegistration regService = ServiceRegistration();
    if (isEdit) {
      regService = arg['data'];
    }
    return ChangeNotifierProvider(
      create: (context) => ExtraServiceRegistrationPrv(
          service: service,
          codeCycle: isEdit ? regService.paymentCycle : null,
          maxDayPay: isEdit ? regService.maximum_day : null,
          id: isEdit ? regService.id : null,
          note: isEdit ? regService.note : null,
          regDateString: isEdit ? regService.registration_date : null,
          expiredDateString: isEdit ? regService.expiration_date : null,
          residentId: context.read<ResidentInfoPrv>().residentId,
          phoneNumber:
              context.read<ResidentInfoPrv>().userInfo!.phone_required!,
          selectedApartmentId:
              context.read<ResidentInfoPrv>().selectedApartment!.apartmentId!,
          arisingServiceId: arg['serviceId']),
      builder: ((context, child) {
        return PrimaryScreen(
          appBar: PrimaryAppbar(
              title: isEdit
                  ? S.of(context).edit_service_a(arg['name'])
                  : S.of(context).reg_service_a(arg['name'])),
          body: SafeArea(
            child: FutureBuilder(
              future: context
                  .read<ExtraServiceRegistrationPrv>()
                  .getPaymentCycle(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: PrimaryLoading());
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return PrimaryErrorWidget(
                      code: snapshot.hasError ? "err" : "1",
                      message: snapshot.data.toString(),
                      onRetry: () async {
                        setState(() {});
                      });
                } else {
                  var listApartmentChoice =
                      context.read<ResidentInfoPrv>().listOwn.map((e) {
                    return DropdownMenuItem(
                      value: e.apartmentId,
                      child: Text(e.apartment?.name! != null
                          ? '${e.apartment?.name} - ${e.floor?.name} - ${e.building?.name}'
                          : e.apartmentId!),
                    );
                  }).toList();

                  var listPaymentChoice = context
                      .read<ExtraServiceRegistrationPrv>()
                      .payList
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.code,
                      child: Text(e.name != null ? e.name! : e.code!),
                    );
                  }).toList();
                  var maxDayPayList = List.generate(
                      14,
                      (index) => DropdownMenuItem(
                            value: index + 1,
                            child: Text((index + 1).toString()),
                          ));
                  if (isEdit) {
                    context.read<ExtraServiceRegistrationPrv>().chosenCycle =
                        context
                            .read<ExtraServiceRegistrationPrv>()
                            .payList
                            .firstWhere((element) =>
                                element.code == regService.paymentCycle);
                    context.read<ExtraServiceRegistrationPrv>().month = context
                            .read<ExtraServiceRegistrationPrv>()
                            .chosenCycle!
                            .month ??
                        0;
                  }
                  return Form(
                    key: context.read<ExtraServiceRegistrationPrv>().formKey,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      children: [
                        vpad(20),
                        PrimaryDropDown(
                          isDense: false,
                          isRequired: true,
                          label: S.of(context).apartment,
                          selectList: listApartmentChoice,
                          value: context
                              .read<ResidentInfoPrv>()
                              .selectedApartment!
                              .apartmentId,
                          onChange: (v) => context
                              .read<ExtraServiceRegistrationPrv>()
                              .onChooseApartment(context, v),
                        ),
                        vpad(16),
                        PrimaryDropDown(
                          value: context
                              .read<ExtraServiceRegistrationPrv>()
                              .codeCycle,
                          isRequired: true,
                          label: S.of(context).payment_circle,
                          selectList: listPaymentChoice,
                          onChange: (v) {
                            context
                                .read<ExtraServiceRegistrationPrv>()
                                .onSelectPaymentCycle(context, v);
                          },
                        ),
                        vpad(16),
                        PrimaryTextField(
                          controller: context
                              .read<ExtraServiceRegistrationPrv>()
                              .regDateController,
                          label: S.of(context).reg_date,
                          hint: "dd/mm/yyyy",
                          isReadOnly: true,
                          isRequired: true,
                          onTap: () {
                            context
                                .read<ExtraServiceRegistrationPrv>()
                                .pickRegDate(context);
                          },
                          suffixIcon:
                              const PrimaryIcon(icons: PrimaryIcons.calendar),
                          // validator: (v) {
                          //   if (v!.isEmpty) {
                          //     return '';
                          //   }
                          //   return null;
                          // },
                        ),
                        vpad(16),
                        PrimaryTextField(
                          controller: context
                              .watch<ExtraServiceRegistrationPrv>()
                              .expiredDateController,
                          label: S.of(context).expired_date,
                          hint: "dd/mm/yyyy",
                          isReadOnly: true,
                          isRequired: true,
                          onTap: () => context
                              .read<ExtraServiceRegistrationPrv>()
                              .onTapExpiredDate(context),
                          suffixIcon:
                              const PrimaryIcon(icons: PrimaryIcons.calendar),
                          // validator: (v) {
                          //   if (v!.isEmpty) {
                          //     return '';
                          //   }
                          //   return null;
                          // },
                        ),
                        vpad(16),
                        PrimaryDropDown(
                          value: context
                              .read<ExtraServiceRegistrationPrv>()
                              .maxDayPay,
                          label: S.of(context).max_day_pay,
                          selectList: maxDayPayList,
                          onChange: (v) => context
                              .read<ExtraServiceRegistrationPrv>()
                              .onChangeMaxPayDate(context, v),
                        ),
                        vpad(16),
                        PrimaryTextField(
                          label: S.of(context).note,
                          maxLines: 3,
                          controller: context
                              .read<ExtraServiceRegistrationPrv>()
                              .noteController,
                        ),
                        vpad(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PrimaryButton(
                              isLoading: context
                                  .watch<ExtraServiceRegistrationPrv>()
                                  .isAddNewLoading,
                              buttonSize: ButtonSize.medium,
                              text: isEdit
                                  ? S.of(context).update
                                  : S.of(context).add_new,
                              onTap: () => context
                                  .read<ExtraServiceRegistrationPrv>()
                                  .onSendSummit(context, false),
                            ),
                            PrimaryButton(
                              isLoading: context
                                  .watch<ExtraServiceRegistrationPrv>()
                                  .isSendApproveLoading,
                              buttonType: ButtonType.green,
                              buttonSize: ButtonSize.medium,
                              text: S.of(context).send_request,
                              onTap: () => context
                                  .read<ExtraServiceRegistrationPrv>()
                                  .onSendSummit(context, true),
                            ),
                          ],
                        ),
                        vpad(24),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
