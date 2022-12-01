import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher_string.dart';
import "package:photo_view/photo_view_gallery.dart";

import 'package:uuid/uuid.dart';

import '../constants/api_constant.dart';
import '../constants/constants.dart';

class PrimaryImageNetwork extends StatelessWidget {
  const PrimaryImageNetwork({
    Key? key,
    this.path,
    this.borderRadius,
    this.fit,
    this.height,
    this.width,
    this.canShowPhotoView = true,
    this.customUrl,
    this.fileName,
    this.listLink,
    this.file,
    this.initIndex,
  }) : super(key: key);

  final String? path;
  final String? fileName;
  final BorderRadius? borderRadius;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final bool canShowPhotoView;
  final String? customUrl;
  final List<String>? listLink;
  final int? initIndex;
  final File? file;

  @override
  Widget build(BuildContext context) {
    final tag = const Uuid().v4();
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(4),
      child: Hero(
        tag: tag,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: canShowPhotoView
                ? () {
                    if (path != null && customUrl == null) {
                      if (path!.endsWith(".docx") ||
                          path!.endsWith(".doc") ||
                          path!.endsWith(".xls") ||
                          path!.endsWith(".xlsx") ||
                          path!.endsWith(".pdf") ||
                          path!.endsWith(".txt")) {
                        launchUrlString(path!,
                            // "${ApiConstants.baseURL}/content/media/$path",
                            mode: LaunchMode.externalApplication);
                      } else if (file != null) {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  PhotoViewer(
                                      link: path!,
                                      // "${ApiConstants.baseURL}/content/media/$path",
                                      listLink: listLink ??
                                          [
                                            path!,
                                            //"${ApiConstants.baseURL}/content/media/$path"
                                          ],
                                      initIndex: initIndex ?? 0,
                                      heroTag: tag),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ));
                      } else {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  PhotoViewer(
                                      link: path!,
                                      // "${ApiConstants.baseURL}/content/media/$path",
                                      listLink: listLink ??
                                          [
                                            path!,
                                            //"${ApiConstants.baseURL}/content/media/$path"
                                          ],
                                      initIndex: initIndex ?? 0,
                                      heroTag: tag),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ));
                      }
                    } else {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    PhotoViewer(
                                        file: file,
                                        link: customUrl,
                                        initIndex: 0,
                                        listLink: const [
                                          // customUrl!,
                                        ],
                                        heroTag: tag),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ));
                    }
                  }
                : null,
            child: file == null
                ? CachedNetworkImage(
                    imageUrl: customUrl ??
                        path!, //ApiConstants.baseURL}/content/media/$path",
                    fit: fit ?? BoxFit.cover,
                    height: height,
                    width: width,
                    errorWidget: (context, r, v) {
                      Widget eWidget = const Icon(
                        Icons.broken_image,
                        color: Colors.black45,
                      );
                      if (r.endsWith(".doc") || r.endsWith(".docx")) {
                        eWidget = Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/doc.png",
                              width: 64,
                              height: 64,
                            ),
                            vpad(6),
                            if (fileName != null)
                              Text(fileName!, style: txtBold(12, Colors.white))
                          ],
                        );
                      }
                      if (r.endsWith(".xls") || r.endsWith(".xlsx")) {
                        eWidget = Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/xls.png",
                              width: 64,
                              height: 64,
                            ),
                            vpad(6),
                            if (fileName != null)
                              Text(fileName!, style: txtBold(12, Colors.white))
                          ],
                        );
                      }
                      if (r.endsWith(".pdf")) {
                        eWidget = Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/pdf.png",
                              width: 64,
                              height: 64,
                            ),
                            vpad(6),
                            if (fileName != null)
                              Text(fileName!, style: txtBold(12, Colors.white))
                          ],
                        );
                      }
                      if (r.endsWith(".txt")) {
                        eWidget = Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/txt.png",
                              width: 64,
                              height: 64,
                            ),
                            vpad(6),
                            if (fileName != null)
                              Text(fileName!, style: txtBold(12, Colors.white))
                          ],
                        );
                      }
                      return Container(
                          color: Colors.black38, child: Center(child: eWidget));
                    },
                    placeholder: (context, url) {
                      return Center(
                        child: Icon(Icons.image,
                            color: grayScaleColor1.withOpacity(0.6), size: 30),
                      );
                    },
                  )
                : Image.file(file!),
          ),
        ),
      ),
    );
  }
}

class PhotoViewer extends StatefulWidget {
  PhotoViewer(
      {Key? key,
      this.link,
      this.file,
      required this.heroTag,
      required this.listLink,
      required this.initIndex})
      : pageController = PageController(initialPage: initIndex),
        super(key: key);
  final String? link;
  final List<String> listLink;
  final String heroTag;
  final int initIndex;
  final PageController pageController;
  final File? file;

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  int currentIndex = 1;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.initIndex + 1;
  }

  onPageChanged(int index) {
    setState(() {
      currentIndex = index + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: const CloseButton(
            color: Colors.white,
          ),
          // title: Text(
          //   "$currentIndex/${widget.listLink.length}",
          //   style: txtMedium(15, Colors.white),
          // ),
        ),
        body: Column(
          children: [
            Expanded(
              child: widget.file != null
                  ? (PhotoViewGallery.builder(
                          itemCount: 1,
                          scrollPhysics: const ClampingScrollPhysics(),
                          builder: (BuildContext context, int index) {
                            return PhotoViewGalleryPageOptions(
                                imageProvider: FileImage(widget.file!),
                                initialScale: PhotoViewComputedScale.contained,
                                heroAttributes: PhotoViewHeroAttributes(
                                    tag: widget.heroTag));
                          })

                      // PhotoView(
                      //   imageProvider: FileImage(widget.file!),
                      // )
                      )
                  : PhotoViewGallery.builder(
                      scrollPhysics: const ClampingScrollPhysics(),
                      builder: (BuildContext context, int index) {
                        return PhotoViewGalleryPageOptions(
                          imageProvider: CachedNetworkImageProvider(
                            widget.listLink[index].startsWith("http")
                                ? widget.listLink[index]
                                : widget.listLink[
                                    index], //"${ApiConstants.baseURL}/content/media/${widget.listLink[index]}",
                          ),
                          initialScale: PhotoViewComputedScale.contained,
                          heroAttributes:
                              PhotoViewHeroAttributes(tag: widget.heroTag),
                        );
                      },
                      itemCount: widget.listLink.length,

                      loadingBuilder: (context, event) => Center(
                        child: SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            value: event == null
                                ? 0
                                : event.cumulativeBytesLoaded /
                                    (event.expectedTotalBytes ?? 1),
                          ),
                        ),
                      ),
                      backgroundDecoration:
                          const BoxDecoration(color: Colors.black),

                      pageController: widget.pageController,
                      onPageChanged: onPageChanged,
                      // heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
                    ),
            ),
          ],
        ));
  }
}
