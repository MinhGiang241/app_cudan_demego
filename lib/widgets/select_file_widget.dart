import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:app_cudan/widgets/primary_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import '../constants/constants.dart';
import '../generated/l10n.dart';
import '../services/api_service.dart';
import '../utils/utils.dart';
import 'dash_button.dart';
import 'package:path/path.dart';
import 'package:open_file_plus/open_file_plus.dart';

import 'primary_image_netword.dart';

class SelectFileWidget extends StatefulWidget {
  const SelectFileWidget({
    super.key,
    this.title,
    this.files = const [],
    this.existFiles = const [],
    this.onSelect,
    this.onRemove,
    this.onRemoveExist,
    this.isDash = true,
    this.text,
    this.enable = true,
    this.icon,
    this.isRequired = false,
  });
  final String? title;
  final String? text;
  final Widget? icon;
  final List existFiles;
  final List<File> files;
  final Function()? onSelect;
  final Function(int)? onRemove;
  final Function(int)? onRemoveExist;
  final bool isRequired;
  final bool isDash;
  final bool enable;

  @override
  State<SelectFileWidget> createState() => _SelectFileWidgetState();
}

class _SelectFileWidgetState extends State<SelectFileWidget> {
  ReceivePort port = ReceivePort();
  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
      port.sendPort,
      'downloader_send_port',
    );
    port.listen((dynamic data) {
      // String id = data[0];
      int status = data[1];
      // int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        print("Download complete");
        log(data);
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    int status,
    int progress,
  ) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var listImage = [
      'jpg',
      'jpeg',
      'png',
    ];
    List imageExist = [];
    List fileExist = [];
    List<File> imageList = [];
    List<File> filesList = [];
    for (var a in widget.existFiles) {
      if (listImage.contains(a.name.split('.').last)) {
        imageExist.add(a);
      } else {
        fileExist.add(a);
      }
    }
    for (var i in widget.files) {
      if (listImage.contains(i.path.split('.').last)) {
        imageList.add(i);
      } else {
        filesList.add(i);
      }
    }
    return Column(
      children: [
        Row(
          children: [
            DashButton(
              isDash: widget.isDash && widget.enable,
              text: widget.text ?? S.of(context).upload,
              lable: widget.title,
              isRequired: widget.isRequired,
              icon: widget.icon ?? const PrimaryIcon(icons: PrimaryIcons.plus),
              onTap: widget.onSelect,
            ),
          ],
        ),
        Column(
          children: [
            if (imageExist.isNotEmpty || imageList.isNotEmpty) vpad(12),
            if (imageExist.isNotEmpty || imageList.isNotEmpty)
              SizedBox(
                height: 116,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...imageExist.asMap().entries.map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(right: 14.0),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: PrimaryImageNetwork(
                                    canShowPhotoView: true,
                                    path:
                                        '${ApiService.shared.uploadURL}/?load=${e.value.id!}&regcode=${ApiService.shared.regCode}',
                                  ),
                                ),
                                if (widget.enable)
                                  Positioned(
                                    top: 2,
                                    right: 2,
                                    child: PrimaryIcon(
                                      icons: PrimaryIcons.close,
                                      style: PrimaryIconStyle.gradient,
                                      gradients: PrimaryIconGradient.red,
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(4),
                                      onTap: () {
                                        var index =
                                            widget.existFiles.indexWhere(
                                          (element) => element.id == e.value.id,
                                        );
                                        widget.onRemoveExist?.call(index);
                                      },
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                    ...imageList.asMap().entries.map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(right: 14.0),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: PrimaryImageNetwork(
                                    file: e.value,
                                  ),

                                  //  Image.file(e.value),
                                ),
                                if (widget.enable)
                                  Positioned(
                                    top: 2,
                                    right: 2,
                                    child: PrimaryIcon(
                                      icons: PrimaryIcons.close,
                                      style: PrimaryIconStyle.gradient,
                                      gradients: PrimaryIconGradient.red,
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(4),
                                      onTap: () {
                                        widget.onRemove?.call(e.key);
                                      },
                                    ),
                                  )
                              ],
                            ),
                          ),
                        )
                  ],
                ),
              ),
            vpad(12),
            ...widget.existFiles.asMap().entries.map(
              (e) {
                if (listImage.contains(e.value.name.split('.').last)) {
                  return vpad(0);
                }
                return Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          Utils.downloadFile(
                            context: context,
                            id: e.value.id,
                          );
                          // await launchUrl(
                          //   Uri.parse(
                          //     "${ApiConstants.uploadURL}?load=${e.value.id}",
                          //   ),
                          //   mode: LaunchMode.externalApplication,
                          // );
                        },
                        child: Text(
                          e.value.name ?? "",
                          textAlign: TextAlign.left,
                          style: txtMedium(
                            14,
                            primaryColor6,
                          ),
                        ),
                      ),
                    ),
                    if (widget.enable)
                      IconButton(
                        onPressed: () {
                          var index = widget.existFiles.indexWhere(
                            (element) => element.id == e.value.id,
                          );
                          widget.onRemoveExist?.call(index);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 25,
                        ),
                      ),
                  ],
                );
              },
            ),
            ...filesList.asMap().entries.map(
              (e) {
                if (listImage.contains(e.value.path.split('.').last)) {
                  return vpad(0);
                }
                return Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          OpenFile.open(e.value.path);
                        },
                        child: Text(
                          basename(e.value.path),
                          textAlign: TextAlign.left,
                          style: txtMedium(
                            14,
                            primaryColor6,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.onRemove?.call(e.key);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 25,
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
