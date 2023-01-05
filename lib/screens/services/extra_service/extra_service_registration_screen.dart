import 'package:app_cudan/screens/auth/prv/resident_info_prv.dart';
import 'package:app_cudan/widgets/primary_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/extra_service.dart';
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
    ExtraService service = arg['service'];
    ServiceRegistration regService = ServiceRegistration();
    if (isEdit) {
      regService = arg['data'];
    }
    return ChangeNotifierProvider(
      create: (context) => ExtraServiceRegistrationPrv(
          payList: service.pay ?? [],
          code: isEdit ? regService.code : null,
          service: service,
          shelfLifeId: isEdit ? regService.shelfLifeId : null,
          maxDayPay: isEdit ? regService.maximum_day : null,
          id: isEdit ? regService.id : null,
          note: isEdit ? regService.note : null,
          regDateString: isEdit ? regService.registration_date : null,
          expiredDateString: isEdit ? regService.expiration_date : null,
          residentId: context.read<ResidentInfoPrv>().residentId,
          phoneNumber: regService.phoneNumber ??
              context.read<ResidentInfoPrv>().userInfo!.phone_required!,
          selectedApartmentId: regService.apartmentId ??
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

                  var listPaymentChoice = service.pay != null
                      ? service.pay!.map((e) {
                          return DropdownMenuItem(
                            value: e.id,
                            child: Text(e.type_time != null
                                ? "${e.use_time != null ? "${e.use_time} " : ""}${e.type_time}"
                                : e.code!),
                          );
                        }).toList()
                      : null;
                  var maxDayPayList = List.generate(
                      30,
                      (index) => DropdownMenuItem(
                            value: index + 1,
                            child: Text((index + 1).toString()),
                          ));
                  if (isEdit &&
                      context
                          .read<ExtraServiceRegistrationPrv>()
                          .payList
                          .isNotEmpty) {
                    context.read<ExtraServiceRegistrationPrv>().chosenCycle =
                        context
                            .read<ExtraServiceRegistrationPrv>()
                            .payList
                            .firstWhere((element) =>
                                element.id == regService.shelfLifeId);
                    context.read<ExtraServiceRegistrationPrv>().month = context
                            .read<ExtraServiceRegistrationPrv>()
                            .chosenCycle!
                            .use_time ??
                        0;
                  }
                  return Form(
                    onChanged:
                        context.watch<ExtraServiceRegistrationPrv>().autoValid
                            ? () => context
                                .read<ExtraServiceRegistrationPrv>()
                                .validate(context)
                            : null,
                    autovalidateMode:
                        context.watch<ExtraServiceRegistrationPrv>().autoValid
                            ? AutovalidateMode.onUserInteraction
                            : null,
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
                              .watch<ExtraServiceRegistrationPrv>()
                              .selectedApartmentId,
                          onChange: (v) => context
                              .read<ExtraServiceRegistrationPrv>()
                              .onChooseApartment(context, v),
                        ),
                        if (context
                            .watch<ExtraServiceRegistrationPrv>()
                            .payList
                            .isNotEmpty)
                          vpad(16),
                        if (context
                            .watch<ExtraServiceRegistrationPrv>()
                            .payList
                            .isNotEmpty)
                          PrimaryDropDown(
                            value: context
                                .read<ExtraServiceRegistrationPrv>()
                                .shelfLifeId,
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
                          maxLength: 500,
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
                        if (!(context
                                    .watch<ExtraServiceRegistrationPrv>()
                                    .codeCycle ==
                                "KHONGCO" ||
                            context
                                .watch<ExtraServiceRegistrationPrv>()
                                .payList
                                .isEmpty))
                          vpad(16),
                        if (!(context
                                    .watch<ExtraServiceRegistrationPrv>()
                                    .codeCycle ==
                                "KHONGCO" ||
                            context
                                .watch<ExtraServiceRegistrationPrv>()
                                .payList
                                .isEmpty))
                          PrimaryTextField(
                            maxLength: 500,
                            background: grayScaleColor4,
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
                        if (!(context
                                    .watch<ExtraServiceRegistrationPrv>()
                                    .codeCycle ==
                                "KHONGCO" ||
                            context
                                .watch<ExtraServiceRegistrationPrv>()
                                .payList
                                .isEmpty))
                          vpad(16),
                        if (!(context
                                    .watch<ExtraServiceRegistrationPrv>()
                                    .codeCycle ==
                                "KHONGCO" ||
                            context
                                .watch<ExtraServiceRegistrationPrv>()
                                .payList
                                .isEmpty))
                          PrimaryDropDown(
                            isRequired: true,
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
                          maxLength: 500,
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
