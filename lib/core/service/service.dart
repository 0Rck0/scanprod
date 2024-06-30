import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/models.dart';

class ApiService {
  static const String baseUrl =
      'https://ms-active.proudglacier-d2dc017c.eastus.azurecontainerapps.io/api/equipo/buscarSerie/';

  Future<List<Equipo>> buscarSerie(String serie) async {
    final response = await http.get(Uri.parse('$baseUrl$serie'));

    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);

      // Verificar si la respuesta es una lista o un solo objeto
      if (jsonResponse is List) {
        return jsonResponse.map((data) => Equipo.fromJson(data)).toList();
      } else if (jsonResponse is Map<String, dynamic>) {
        // Si la respuesta es un solo objeto, crear una lista con ese objeto
        return [Equipo.fromJson(jsonResponse)];
      } else {
        throw Exception('Formato de respuesta inválido');
      }
    } else {
      throw Exception('Error al cargar datos: ${response.statusCode}');
    }
  }
}
