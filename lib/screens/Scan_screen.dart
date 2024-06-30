import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../core/models/models.dart';
import '../core/service/service.dart';
import 'equipo_details_screen.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({Key? key}) : super(key: key);

  @override
  BarcodeScannerScreenState createState() => BarcodeScannerScreenState();
}

class BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final List<String> scannedCodes = [];
  final List<Equipo> equipos = [];
  bool isScanning = false;
  final ApiService apiService = ApiService();

  Future<void> scanCode(ScanMode mode) async {
    setState(() {
      isScanning = true;
    });

    try {
      String scanResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancelar',
        true,
        mode,
      );

      if (scanResult != '-1') {
        scannedCodes.add(scanResult);
        await fetchEquipos(scanResult);
      } else {
        showSnackbar('Escaneo cancelado o sin éxito');
      }
    } catch (e) {
      showSnackbar('Error: $e');
    } finally {
      setState(() {
        isScanning = false;
      });
    }
  }

  Future<void> fetchEquipos(String serie) async {
    try {
      List<Equipo> fetchedEquipos = await apiService.buscarSerie(serie);
      setState(() {
        equipos.clear();
        equipos.addAll(fetchedEquipos);
      });
    } catch (e) {
      showSnackbar('Error al cargar datos: $e');
    }
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escáner de Códigos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildScanButton(ScanMode.BARCODE, 'Escanear Código de Barras', 15.0, CupertinoIcons.barcode),
            const SizedBox(height: 16.0),
            buildScanButton(ScanMode.QR, 'Escanear Código QR', 15.0, CupertinoIcons.qrcode_viewfinder),
            const SizedBox(height: 24.0),
            Expanded(
              child: buildScannedCodesList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildScanButton(ScanMode mode, String label, double fontSize, IconData icon) {
    return ElevatedButton.icon(
      onPressed: isScanning ? null : () => scanCode(mode),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.teal,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        shadowColor: Colors.teal.withOpacity(0.3),
        elevation: 5.0,
      ),
      icon: Icon(icon),
      label: Text(
        label,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }

  Widget buildScannedCodesList() {
    return ListView.builder(
      itemCount: scannedCodes.length,
      itemBuilder: (context, index) {
        return buildCodeListItem(scannedCodes[index]);
      },
    );
  }

  Widget buildCodeListItem(String code) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.code),
        title: Text(
          code,
          style: const TextStyle(fontSize: 16.0),
        ),
        onTap: () => navigateToEquipoDetails(code),
      ),
    );
  }

  Future<void> navigateToEquipoDetails(String serie) async {
    try {
      List<Equipo> fetchedEquipos = await apiService.buscarSerie(serie);
      if (fetchedEquipos.isNotEmpty) {
        Equipo selectedEquipo = fetchedEquipos.firstWhere((equipo) => equipo.serie == serie);
        if (selectedEquipo != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EquipoDetailsScreen(equipo: selectedEquipo),
            ),
          );
        } else {
          showSnackbar('Equipo no encontrado');
        }
      } else {
        showSnackbar('Equipo no encontrado');
      }
    } catch (e) {
      print('Error al cargar datos: $e');
      showSnackbar('Error al cargar datos');
    }
  }
}
