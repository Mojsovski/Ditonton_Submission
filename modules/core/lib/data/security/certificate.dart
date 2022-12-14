import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

class Certificate {
  static IOClient get client => ioClient!;
  static IOClient? ioClient;

  static Future<void> init() async {
    ioClient = await clientIO;
  }

  static Future<IOClient> get clientIO async {
    final sslCert = await rootBundle.load('assets/certificate.crt');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    HttpClient client = HttpClient(context: securityContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    return IOClient(client);
  }
}
