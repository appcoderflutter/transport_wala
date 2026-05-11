// class CachedImage {
//   final String url;
//   final double? width;
//   final double? height;
//   final BoxFit fit;
//   final Widget? placeholder;
//   final Widget? errorWidget;
//   final String? errorAsset;
//   final IconData errorIcon;
//   final Color backgroundColor;
//
//   CachedImage({
//     required this.url,
//     this.width,
//     this.height,
//     this.fit = BoxFit.cover,
//     this.placeholder,
//     this.errorWidget,
//     this.errorAsset,
//     this.errorIcon = Icons.person,
//     this.backgroundColor = const Color(0xFFBDBDBD),
//   });
//
//   bool _isSvg(String url) => url.toLowerCase().endsWith('.svg');
//
//   bool _isGif(String url) => url.toLowerCase().endsWith('.gif');
//
//   bool _isNetwork(String url) =>
//       url.startsWith('http://') || url.startsWith('https://');
//
//   /// ✅ Your manual .build() method
//   Widget build() {
//     if (!_isNetwork(url)) {
//       return _errorWidget();
//     }
//
//     // 🧩 Handle SVG
//     if (_isSvg(url)) {
//       return SvgPicture.network(
//         url,
//         width: width,
//         height: height,
//         fit: fit,
//         placeholderBuilder: (_) => placeholder ?? _placeholder(),
//       );
//     }
//
//     // 🌀 Handle GIF
//     if (_isGif(url)) {
//       return Image.network(
//         url,
//         width: width,
//         height: height,
//         fit: fit,
//         loadingBuilder: (_, child, loadingProgress) {
//           if (loadingProgress == null) return child;
//           return placeholder ?? _placeholder();
//         },
//         errorBuilder: (_, __, ___) => _errorWidget(),
//       );
//     }
//
//     // 🖼️ Default: png, jpg, jpeg, webp
//     return CachedNetworkImage(
//       imageUrl: url,
//       width: width,
//       height: height,
//       fit: fit,
//       placeholder: (_, __) => placeholder ?? _placeholder(),
//       errorWidget: (_, __, ___) => errorWidget ?? _errorWidget(),
//     );
//   }
//
//   Widget _placeholder() => Container(
//         width: width,
//         height: height,
//         color: backgroundColor,
//         alignment: Alignment.center,
//         child: Icon(Icons.image, size: (width ?? 40) / 2, color: Colors.white),
//       );
//
//   Widget _errorWidget() {
//     if (errorAsset != null) {
//       return Image.asset(
//         errorAsset!,
//         width: width,
//         height: height,
//         fit: fit,
//         errorBuilder: (_, __, ___) => _iconFallback(),
//       );
//     }
//     return _iconFallback();
//   }
//
//   Widget _iconFallback() => Container(
//         width: width,
//         height: height,
//         color: backgroundColor,
//         alignment: Alignment.center,
//         child: Icon(errorIcon, size: (width ?? 40) / 2, color: Colors.white),
//       );
// }

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class _ImageDiskCache {
  _ImageDiskCache._();
  static final _ImageDiskCache instance = _ImageDiskCache._();
  final Map<String, String> _pathCache = {};
  final Map<String, Future<String>> _inflight = {};

  Future<String> resolve(String url) {
    if (_pathCache.containsKey(url)) {
      return Future.value(_pathCache[url]!);
    }
    if (_inflight.containsKey(url)) {
      return _inflight[url]!;
    }

    final future = _download(url).then((path) {
      _pathCache[url] = path;
      _inflight.remove(url);
      return path;
    }).catchError((e) {
      _inflight.remove(url);
      throw e;
    });

    _inflight[url] = future;
    return future;
  }

  Future<String> _download(String url) async {
    final fileName = _safeFileName(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/image_cache/$fileName');

    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true);
    }

    if (await file.exists()) return file.path;

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode} for $url');
    }
    await file.writeAsBytes(response.bodyBytes, flush: true);
    return file.path;
  }

  String _safeFileName(String url) {
    final uri = Uri.parse(url);
    final raw = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : 'image';
    return raw.replaceAll(RegExp(r'[^\w\.\-]'), '_');
  }

  void prefetch(String url) {
    if (url.isEmpty) return;
    resolve(url).catchError((_) {});
  }

  void clearMemory() => _pathCache.clear();
}

class CachedImage {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final String? errorAsset;
  final IconData errorIcon;
  final Color backgroundColor;

  CachedImage({
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.errorAsset,
    this.errorIcon = Icons.person,
    this.backgroundColor = const Color(0xFFBDBDBD),
  });
  bool get _isSvg => url.toLowerCase().endsWith('.svg');
  bool get _isGif => url.toLowerCase().endsWith('.gif');
  bool get _isNetwork =>
      url.startsWith('http://') || url.startsWith('https://');

  Widget build() {
    if (url.isEmpty || !_isNetwork) return _errorFallback();
    if (_isSvg) return _DiskCachedSvg(image: this);
    if (_isGif) {
      return Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (_, child, progress) =>
            progress == null ? child : _loadingWidget(),
        errorBuilder: (_, __, ___) => _errorFallback(),
      );
    }
    return _DiskCachedImage(image: this);
  }

  /// Prefetch without displaying — useful for list pre-warming
  static void prefetch(String url) {
    if (url.isEmpty) return;
    _ImageDiskCache.instance.prefetch(url);
  }

  Widget _loadingWidget() =>
      placeholder ??
      Container(
        width: width,
        height: height,
        color: backgroundColor,
        alignment: Alignment.center,
        child: Icon(
          Icons.image,
          size: (width ?? 40) / 2,
          color: Colors.white54,
        ),
      );

  Widget _errorFallback() {
    if (errorWidget != null) return errorWidget!;
    if (errorAsset != null) {
      return Image.asset(
        errorAsset!,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _iconFallback(),
      );
    }
    return _iconFallback();
  }

  Widget _iconFallback() => Container(
        width: width,
        height: height,
        color: backgroundColor,
        alignment: Alignment.center,
        child: Icon(
          errorIcon,
          size: (width ?? 40) / 2,
          color: Colors.white,
        ),
      );
}

class _DiskCachedImage extends StatefulWidget {
  final CachedImage image;
  const _DiskCachedImage({required this.image});

  @override
  State<_DiskCachedImage> createState() => _DiskCachedImageState();
}

class _DiskCachedImageState extends State<_DiskCachedImage> {
  late Future<String> _pathFuture;

  @override
  void initState() {
    super.initState();
    _pathFuture = _ImageDiskCache.instance.resolve(widget.image.url);
  }

  @override
  void didUpdateWidget(_DiskCachedImage old) {
    super.didUpdateWidget(old);
    if (old.image.url != widget.image.url) {
      _pathFuture = _ImageDiskCache.instance.resolve(widget.image.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final img = widget.image;

    return FutureBuilder<String>(
      future: _pathFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return img._loadingWidget();
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return CachedNetworkImage(
            imageUrl: img.url,
            width: img.width,
            height: img.height,
            fit: img.fit,
            placeholder: (_, __) => img._loadingWidget(),
            errorWidget: (_, __, ___) => img._errorFallback(),
          );
        }
        return Image.file(
          File(snapshot.data!),
          width: img.width,
          height: img.height,
          fit: img.fit,
          errorBuilder: (_, __, ___) => CachedNetworkImage(
            imageUrl: img.url,
            width: img.width,
            height: img.height,
            fit: img.fit,
            placeholder: (_, __) => img._loadingWidget(),
            errorWidget: (_, __, ___) => img._errorFallback(),
          ),
        );
      },
    );
  }
}

class _DiskCachedSvg extends StatefulWidget {
  final CachedImage image;
  const _DiskCachedSvg({required this.image});

  @override
  State<_DiskCachedSvg> createState() => _DiskCachedSvgState();
}

class _DiskCachedSvgState extends State<_DiskCachedSvg> {
  late Future<String> _pathFuture;

  @override
  void initState() {
    super.initState();
    _pathFuture = _ImageDiskCache.instance.resolve(widget.image.url);
  }

  @override
  void didUpdateWidget(_DiskCachedSvg old) {
    super.didUpdateWidget(old);
    if (old.image.url != widget.image.url) {
      _pathFuture = _ImageDiskCache.instance.resolve(widget.image.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final img = widget.image;

    return FutureBuilder<String>(
      future: _pathFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return img._loadingWidget();
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return SvgPicture.network(
            img.url,
            width: img.width,
            height: img.height,
            fit: img.fit,
            placeholderBuilder: (_) => img._loadingWidget(),
          );
        }

        return SvgPicture.file(
          File(snapshot.data!),
          width: img.width,
          height: img.height,
          fit: img.fit,
        );
      },
    );
  }
}

// Use error asset image
// CachedImage(
//   url: user.imageUrl,
//   width: 40,
//   height: 40,
//   errorAsset: 'assets/images/user_placeholder.png',
// ).build()

// Use error icon
// CachedImage(
//   url: user.imageUrl,
//   width: 40,
//   height: 40,
//   errorIcon: Icons.person_outline,
// ).build()

//Fully custom error widget
// CachedImage(
//   url: user.imageUrl,
//   width: 40,
//   height: 40,
//   errorWidget: CircleAvatar(
//     backgroundColor: Colors.red,
//     child: Icon(Icons.close, color: Colors.white),
//   ),
// ).build()

// Perfect for CircleAvatar
// CircleAvatar(
//   radius: 22,
//   child: ClipOval(
//     child: CachedImage(
//       url: viewers[index],
//       width: 44,
//       height: 44,
//       errorIcon: Icons.person,
//     ).build(),
//   ),
// );

// new //
// Profile avatar
// CachedImage(
// url: userModel.profileImage ?? '',
// width: 50.w,
// height: 50.h,
// fit: BoxFit.cover,
// ).build()
//
// // With error icon
// CachedImage(
// url: userModel.profileImage ?? '',
// width: 50.w,
// height: 50.h,
// errorIcon: Icons.person_outline,
// ).build()
//
// // With error asset image
// CachedImage(
// url: userModel.profileImage ?? '',
// width: 50.w,
// height: 50.h,
// errorAsset: Res.logoSplash,
// ).build()
