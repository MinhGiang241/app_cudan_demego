import 'package:app_cudan/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../generated/l10n.dart';
import '../../../models/delivery.dart';
import '../../../utils/utils.dart';
import '../../../widgets/dash_button.dart';
import '../../../widgets/primary_appbar.dart';
import '../../../widgets/primary_card.dart';
import '../../../widgets/primary_icon.dart';
import '../../../widgets/primary_screen.dart';
import '../../../widgets/primary_text_field.dart';
import '../../../widgets/select_media_widget.dart';
import 'provider/register_delivery_prv.dart';

class RegisterDelivery extends StatefulWidget {
  const RegisterDelivery({super.key});
  static const routeName = '/delivery/register';

  @override
  State<RegisterDelivery> createState() => _RegisterDeliveryState();
}

class _RegisterDeliveryState extends State<RegisterDelivery> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    var isEdit = arg['isEdit'];
    Delivery delivery = Delivery();
    if (isEdit) {
      delivery = arg['data'];
    }

    return ChangeNotifierProvider(
      create: (context) => RegisterDeliveryPrv(
          id: delivery.id,
          existedImage: delivery.image ?? [],
          helpCheck: delivery.help_check ?? false,
          packageItems: delivery.item_added_list ?? [],
          type: delivery.type_transfer == "IN" ? 2 : 1),
      builder: ((context, child) {
        if (isEdit) {
          context.read<RegisterDeliveryPrv>().noteController.text =
              delivery.note_reason ?? '';
          context.read<RegisterDeliveryPrv>().startDateController.text =
              Utils.dateFormat(delivery.start_time ?? '');
          context.read<RegisterDeliveryPrv>().endDateController.text =
              Utils.dateFormat(delivery.end_time ?? '');
          context.read<RegisterDeliveryPrv>().noteController.text =
              delivery.note_reason ?? '';
          if (delivery.start_hour != null) {
            context.read<RegisterDeliveryPrv>().startHourController.text =
                delivery.start_hour!.substring(0, 5);
          }
          if (delivery.end_hour != null) {
            context.read<RegisterDeliveryPrv>().endHourController.text =
                delivery.end_hour!.substring(0, 5);
          }
        }

        return PrimaryScreen(
          appBar: PrimaryAppbar(
              title: isEdit
                  ? S.of(context).edit_reg_deliver
                  : S.of(context).reg_deliver),
          body: Builder(builder: (context) {
            return Form(
              key: context.watch<RegisterDeliveryPrv>().formKey,
              child: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  children: [
                    vpad(20),
                    Row(
                      children: [
                        Text(
                          S.of(context).transfer_type,
                          style: txtBodySmallRegular(color: grayScaleColorBase),
                        ),
                        Text(
                          ' *',
                          style: txtBodySmallRegular(color: redColor1),
                        )
                      ],
                    ),
                    vpad(16),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => context
                              .read<RegisterDeliveryPrv>()
                              .selectTransferType(1),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color:
                                    context.watch<RegisterDeliveryPrv>().type ==
                                            1
                                        ? primaryColor4
                                        : Colors.white,
                                border:
                                    Border.all(width: 2, color: primaryColor3),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(S.of(context).tranfer_out),
                          ),
                        ),
                        hpad(30),
                        InkWell(
                          onTap: () => context
                              .read<RegisterDeliveryPrv>()
                              .selectTransferType(2),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color:
                                    context.watch<RegisterDeliveryPrv>().type ==
                                            2
                                        ? primaryColor4
                                        : Colors.white,
                                border:
                                    Border.all(width: 2, color: primaryColor3),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(S.of(context).tranfer_in),
                          ),
                        ),
                      ],
                    ),
                    vpad(16),
                    Row(
                      children: [
                        Text(
                          S.of(context).start_time,
                          style: txtBodySmallRegular(color: grayScaleColorBase),
                        ),
                        Text(
                          '  *',
                          style: txtBodySmallRegular(color: redColor1),
                        )
                      ],
                    ),
                    vpad(12),
                    Row(children: [
                      Expanded(
                        flex: 1,
                        child: PrimaryTextField(
                          controller: context
                              .read<RegisterDeliveryPrv>()
                              .startDateController,
                          label: S.of(context).date,
                          hint: "dd/mm/yyyy",
                          isReadOnly: true,
                          isRequired: true,
                          onTap: () {
                            context
                                .read<RegisterDeliveryPrv>()
                                .pickStartDate(context);
                          },
                          suffixIcon:
                              const PrimaryIcon(icons: PrimaryIcons.calendar),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      hpad(20),
                      Expanded(
                        flex: 1,
                        child: PrimaryTextField(
                          controller: context
                              .read<RegisterDeliveryPrv>()
                              .startHourController,
                          label: S.of(context).hour,
                          hint: "hh/mm",
                          isReadOnly: true,
                          onTap: () async {
                            await context
                                .read<RegisterDeliveryPrv>()
                                .pickStartHour(context);
                          },
                          suffixIcon:
                              const PrimaryIcon(icons: PrimaryIcons.clock),
                        ),
                      ),
                    ]),

                    vpad(5),

                    Text(
                      context.watch<RegisterDeliveryPrv>().validateStartDate ??
                          '',
                      style: txtBodySmallRegular(color: redColorBase),
                    ),
                    vpad(5),
                    Row(
                      children: [
                        Text(
                          S.of(context).end_time,
                          style: txtBodySmallRegular(color: grayScaleColorBase),
                        ),
                        Text(
                          ' *',
                          style: txtBodySmallRegular(color: redColor1),
                        )
                      ],
                    ),
                    vpad(12),
                    Row(children: [
                      Expanded(
                        flex: 1,
                        child: PrimaryTextField(
                          controller: context
                              .read<RegisterDeliveryPrv>()
                              .endDateController,
                          label: S.of(context).date,
                          hint: "dd/mm/yyyy",
                          isReadOnly: true,
                          isRequired: true,
                          onTap: () {
                            context
                                .read<RegisterDeliveryPrv>()
                                .pickEndDate(context);
                          },
                          suffixIcon:
                              const PrimaryIcon(icons: PrimaryIcons.calendar),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                      ),
                      hpad(20),
                      Expanded(
                        flex: 1,
                        child: PrimaryTextField(
                          controller: context
                              .read<RegisterDeliveryPrv>()
                              .endHourController,
                          label: S.of(context).hour,
                          hint: "hh/mm",
                          isReadOnly: true,
                          onTap: () async {
                            await context
                                .read<RegisterDeliveryPrv>()
                                .pickEndHour(context);
                          },
                          suffixIcon:
                              const PrimaryIcon(icons: PrimaryIcons.clock),
                        ),
                      ),
                    ]),

                    vpad(5),
                    // if (context.watch<RegisterDeliveryPrv>().validateEndDate !=
                    //     null)
                    Text(
                      context.watch<RegisterDeliveryPrv>().validateEndDate ??
                          "",
                      style: txtBodySmallRegular(color: redColorBase),
                    ),
                    vpad(5),
                    SelectMediaWidget(
                      title: S.of(context).photos,
                      existImages:
                          context.watch<RegisterDeliveryPrv>().existedImage,
                      images:
                          context.watch<RegisterDeliveryPrv>().imagesDelivery,
                      onRemove: context
                          .read<RegisterDeliveryPrv>()
                          .onRemoveImageDelivery,
                      onRemoveExist: context
                          .read<RegisterDeliveryPrv>()
                          .removeExistedImages,
                      onSelect: () => context
                          .read<RegisterDeliveryPrv>()
                          .onSelectImageDelivery(context),
                    ),
                    vpad(16),
                    Row(
                      children: [
                        DashButton(
                          text: S.of(context).add_package,
                          lable: S.of(context).add_package,
                          isRequired: true,
                          icon: const PrimaryIcon(
                              icons: PrimaryIcons.add_to_queue),
                          onTap: () => context
                              .read<RegisterDeliveryPrv>()
                              .addPackage(context),
                        ),
                      ],
                    ),
                    vpad(16),
                    ...context
                        .watch<RegisterDeliveryPrv>()
                        .packageItems
                        .asMap()
                        .entries
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Dismissible(
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: secondaryColorBase,
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.delete,
                                      color: Colors.white, size: 50),
                                ),
                              ),
                              onDismissed: (direction) {
                                context
                                    .read<RegisterDeliveryPrv>()
                                    .removeItemPackage(e.key);
                              },
                              key: UniqueKey(),
                              child: PrimaryCard(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 16),
                                    child: Row(
                                      children: [
                                        const PrimaryIcon(
                                          icons: PrimaryIcons.box,
                                          style: PrimaryIconStyle.gradient,
                                          gradients: PrimaryIconGradient.yellow,
                                          size: 32,
                                          padding: EdgeInsets.all(12),
                                          color: Colors.white,
                                        ),
                                        hpad(16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(e.value.item_name ?? '',
                                                  style: txtLinkSmall()),
                                              vpad(2),
                                              Text(e.value.weight.toString(),
                                                  style: txtLinkSmall()),
                                              vpad(2),
                                              Text(e.value.dimension ?? '',
                                                  style:
                                                      txtBodyXSmallRegular()),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ),
                    vpad(16),
                    PrimaryTextField(
                      controller:
                          context.read<RegisterDeliveryPrv>().noteController,
                      label: S.of(context).note,
                      maxLines: 3,
                    ),
                    vpad(16),
                    Row(
                      children: [
                        SizedBox(
                          width: 22.0,
                          height: 22.0,
                          child: Checkbox(
                            fillColor:
                                MaterialStateProperty.all(primaryColorBase),
                            value:
                                context.watch<RegisterDeliveryPrv>().helpCheck,
                            onChanged: (v) {
                              context
                                  .read<RegisterDeliveryPrv>()
                                  .toggleHelpCheck();
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () => context
                              .read<RegisterDeliveryPrv>()
                              .toggleHelpCheck(),
                          child: Text(S.of(context).need_support,
                              style: txtBodySmallRegular(
                                  color: grayScaleColorBase)),
                        )
                      ],
                    ),
                    vpad(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PrimaryButton(
                          isLoading:
                              context.watch<RegisterDeliveryPrv>().isLoading,
                          buttonSize: ButtonSize.medium,
                          text: isEdit
                              ? S.of(context).update
                              : S.of(context).add_new,
                          onTap: () => context
                              .read<RegisterDeliveryPrv>()
                              .onSendSummitDelivery(context, false),
                        ),
                        PrimaryButton(
                          isLoading:
                              context.watch<RegisterDeliveryPrv>().isLoading,
                          buttonType: ButtonType.green,
                          buttonSize: ButtonSize.medium,
                          text: S.of(context).send_request,
                          onTap: () => context
                              .read<RegisterDeliveryPrv>()
                              .onSendSummitDelivery(context, true),
                        ),
                      ],
                    ),
                    vpad(24),
                  ],
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
