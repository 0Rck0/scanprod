import 'package:flutter/material.dart';
import '../core/models/models.dart';

class EquipoDetailsScreen extends StatelessWidget {
  final Equipo equipo;

  const EquipoDetailsScreen({Key? key, required this.equipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Equipo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailSection('Detalles Generales', [
              _buildDetailRow('Hostname', equipo.hostname),
              _buildDetailRow('Serie', equipo.serie),
              _buildDetailRow('Modelo', equipo.modelo),
              _buildDetailRow('Marca', equipo.marca),
              _buildDetailRow('Procesador', equipo.procesador),
              _buildDetailRow('Memoria', equipo.memoria),
              _buildDetailRow('Disco', equipo.disco),
              _buildDetailRow('Condición', equipo.condicion),
              _buildDetailRow('Cantidad', equipo.cantidad.toString()),
              _buildDetailRow('Estado', equipo.estado.toString()),
            ]),
            const SizedBox(height: 20),
            _buildDetailSection('Detalles de Usuario', [
              _buildUserDetails(equipo.usuario),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserDetails(Usuario usuario) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Usuario:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 4),
        Text(
          '${usuario.nombres} ${usuario.apellidos}',
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
        const SizedBox(height: 12),
        const Text(
          'Correo:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 4),
        Text(
          usuario.correo,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
        const SizedBox(height: 12),
        const Text(
          'Empresa:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 4),
        Text(
          usuario.empresa.nombreEmpresa,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ],
    );
  }
}
