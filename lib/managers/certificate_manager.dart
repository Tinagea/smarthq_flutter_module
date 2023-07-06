// file: certificate_manager.dart
// date: Nov/25/2021
// brief: Certificate manager.
// Copyright GEAppliances, a Haier company (Confidential). All rights reserved.

import 'dart:io';
// import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';


class CertificateManager {
  static final CertificateManager _instance = CertificateManager._();
  factory CertificateManager() {
    return _instance;
  }
  CertificateManager._();

  late List<Uint8List> _certificates;
  List<Uint8List> get certificates => _certificates;

  // List<String> _allowedSha256FingerPrint = [
  //   '2D:12:B6:19:A6:60:CE:FB:01:32:71:83:1D:89:12:13:FC:43:4E:98:2A:21:56:82:56:CF:4E:2E:86:32:4B:EA',
  //   '8E:CD:E6:88:4F:3D:87:B1:12:5B:A3:1A:C3:FC:B1:3D:70:16:DE:7F:57:CC:90:4F:E1:CB:97:C6:AE:98:19:6E',
  //   '1B:A5:B2:AA:8C:65:40:1A:82:96:01:18:F8:0B:EC:4F:62:30:4D:83:CE:C4:71:3A:19:C3:9C:01:1E:A4:6D:B4',
  //   '18:CE:6C:FE:7B:F1:4E:60:B2:E3:47:B8:DF:E8:68:CB:31:D0:2E:BB:3A:DA:27:15:69:F5:03:43:B4:6D:B3:A4',
  //   'E3:5D:28:41:9E:D0:20:25:CF:A6:90:38:CD:62:39:62:45:8D:A5:C6:95:FB:DE:A3:C2:2B:0B:FB:25:89:70:92',
  //   '56:8D:69:05:A2:C8:87:08:A4:B3:02:51:90:ED:CF:ED:B1:97:4A:60:6A:13:C6:E5:29:0F:CB:2A:E6:3E:DA:B5'
  // ];
  // List<String> get allowedSha256FingerPrint => _allowedSha256FingerPrint;

  @Deprecated('Use setCertificatePinning instead.')
  void setFingerPrint(Dio dio) {
    // dio.interceptors.add(CertificatePinningInterceptor(allowedSHAFingerprints: allowedSha256FingerPrint));
  }

  Future<bool> load() async {
    geaLog.debug("CertificateManager:load");
    _certificates = [
      (await rootBundle.load("assets/certificates/AmazonRootCA1.cer")).buffer.asUint8List(),
      (await rootBundle.load("assets/certificates/AmazonRootCA2.cer")).buffer.asUint8List(),
      (await rootBundle.load("assets/certificates/AmazonRootCA3.cer")).buffer.asUint8List(),
      (await rootBundle.load("assets/certificates/AmazonRootCA4.cer")).buffer.asUint8List(),
      (await rootBundle.load("assets/certificates/SFSRootCAG2.cer")).buffer.asUint8List()
    ];

    return true;
  }

  void setCertificatePinning(Dio dio) {
    var adapter = dio.httpClientAdapter;
    if (adapter is IOHttpClientAdapter) {
      adapter.onHttpClientCreate = (client) {
        SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
        certificates.forEach((certificate) {
          securityContext.setTrustedCertificatesBytes(certificate);
        });
        HttpClient httpClient = HttpClient(context: securityContext);
        httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) {
          geaLog.warning("badCertificate:\n${cert.pem}");
          return false;
        };
        setProxy(httpClient);
        return httpClient;
      };
    }
  }

  Future<bool> checkCertificatePinning(String url) async {
    // To check only gea cloud url.
    if (url.contains("brillion.geappliances.com") == false) return true;

    SecurityContext context = SecurityContext(withTrustedRoots: false);
    certificates.forEach((certificate) {
      context.setTrustedCertificatesBytes(certificate);
    });

    HttpClient httpClient = new HttpClient(context: context);
    setProxy(httpClient);

    final splitData = url.split("://");
    final scheme = splitData[0];
    final urlData = splitData[1].split("/");
    final host = urlData[0];
    var path = "";
    urlData.forEach((element) {
      if (urlData.indexOf(element) != 0) {
        path += "/$element";
      }
    });

    try {
      final httpRequest = await httpClient
          .getUrl(Uri(scheme: scheme, host: host, path: path));
      final response = await httpRequest.close();
      geaLog.debug("response.statusCode:${response.statusCode}");
      return true;
    } catch (error) {
      if (error is HandshakeException) {
        geaLog.error("HandshakeException on WebView Pinning.");
        return false;
      } else {
        return true;
      }
    }
  }

  void setProxy(HttpClient client) {
    // client.findProxy = (uri) {
    //   return "PROXY 192.168.35.211:8088";
    // };
  }

}