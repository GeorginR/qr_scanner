import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanner/result_screen.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

const bgColor = Color.fromARGB(255, 247, 247, 247);

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "QR Scanner",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Place the QR in the area",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    MobileScanner(
                      allowDuplicates: true,
                      onDetect: (barcode, args) {
                        if (!isScanCompleted) {
                          String code = barcode.rawValue ?? '---';
                          isScanCompleted = true;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScanner(
                                        closeScreen: closeScreen,
                                        code: code,
                                      )));
                        }
                      },
                    ),
                    QRScannerOverlay(
                      overlayColor: bgColor,
                      borderColor: Colors.amberAccent,
                    )
                  ],
                )),
            Expanded(
                child: Container(
              alignment: Alignment.center,
              color: bgColor,
              child: Text(
                "Developed by Royal Roys",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 1,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
