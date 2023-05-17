// ignore_for_file: unnecessary_import, prefer_typing_uninitialized_variables, camel_case_types

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kivasa/constants/colors_constants.dart';
import 'package:kivasa/constants/icon_constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../utills/navigation_rought.dart';
import '../landing_screen/scan_screen.dart';

class Scan_Qr extends StatefulWidget {
  const Scan_Qr({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Scan_QrState();
}

class _Scan_QrState extends State<Scan_Qr> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Padding(
          padding: EdgeInsets.only(left: w * 0.08),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
                onTap: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                },
                child: FutureBuilder(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    return Image.asset(
                      flashlight,
                      height: h * 0.05,
                      width: w * 0.1108,
                      color: buttonclr,
                    );
                  },
                )),
          )),
      body: Column(
        children: [
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < w * 2.216 ||
            MediaQuery.of(context).size.height < h * 1)
        ? 300.0
        : 600.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: h * 0.0125,
          borderLength: h * 0.0375,
          borderWidth: w * 0.0277,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (scanData.code != null) {
          webview = scanData.code ?? "";
          push_to(context, const Scanweb());
          controller.dispose();
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
