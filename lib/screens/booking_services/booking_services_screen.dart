import 'dart:isolate';
import 'dart:ui';

import 'package:app_cudan/widgets/primary_appbar.dart';
import 'package:app_cudan/widgets/primary_loading.dart';
import 'package:app_cudan/widgets/primary_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../generated/l10n.dart';
import '../../services/api_service.dart';
import '../../widgets/primary_image_netword.dart';
import 'prv/booking_services_prv.dart';
import 'select_booking_service_sceen.dart';

class BookingServicesScreen extends StatefulWidget {
  const BookingServicesScreen({super.key});
  static const routeName = '/booking-services';

  @override
  State<BookingServicesScreen> createState() => _BookingServicesScreenState();
}

class _BookingServicesScreenState extends State<BookingServicesScreen> {
  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    _port.listen((dynamic data) {
      String id = data[0];
      int status = data[1];
      int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        print("Download complete");
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

  ReceivePort _port = ReceivePort();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookingServicesPrv(),
      builder: (context, child) => PrimaryScreen(
        appBar: PrimaryAppbar(
          title: S.of(context).ultility_list,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.timer_outlined),
            ),
          ],
        ),
        body: FutureBuilder(
          future:
              context.read<BookingServicesPrv>().getBookingServiceList(context),
          builder: (context, snapshot) {
            var services = context.watch<BookingServicesPrv>().viewServices;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: PrimaryLoading());
            }
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(right: 10, top: 10, left: 10),
                child: SizedBox(
                  height: dvHeight(context) - 100,
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.4,
                    children: [
                      ...services.map(
                        (e) => InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              SelectBookingServiceScreen.routeName,
                              arguments: {
                                "service": e,
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
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
                                      ),
                                    ],
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        5,
                                      ),
                                    ),
                                    gradient: gradientBlue,
                                  ),
                                  child: e.icon != null
                                      ? PrimaryImageNetwork(
                                          canShowPhotoView: false,
                                          fit: BoxFit.contain,
                                          path:
                                              "${ApiService.shared.uploadURL}?load=${e.icon ?? ""}&regcode=${ApiService.shared.regCode}",
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              5,
                                            ),
                                          ),
                                        )
                                      : Image.asset(AppImage.defaultAvatar),
                                ),
                                vpad(7),
                                Flexible(
                                  child: Text(
                                    e.name ?? "",
                                    style: txtBold(13),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
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
      ),
    );
  }
}