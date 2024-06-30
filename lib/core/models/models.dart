class Empresa {
  final String nombreEmpresa;
  final int estado;
  final int id;

  Empresa({
    required this.nombreEmpresa,
    required this.estado,
    required this.id,
  });

  factory Empresa.fromJson(Map<String, dynamic> json) {
    return Empresa(
      nombreEmpresa: json['nombre_Empresa'],
      estado: json['estado'] ?? 0, // Asignar un valor por defecto si es null
      id: json['id'] ?? 0, // Asignar un valor por defecto si es null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre_Empresa': nombreEmpresa,
      'estado': estado,
      'id': id,
    };
  }
}

class Usuario {
  final int estado;
  final Empresa empresa;
  final int id;
  final String nombres;
  final String apellidos;
  final String correo;

  Usuario({
    required this.estado,
    required this.empresa,
    required this.id,
    required this.nombres,
    required this.apellidos,
    required this.correo,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      estado: json['estado'] ?? 0, // Asignar un valor por defecto si es null
      empresa: Empresa.fromJson(json['empresa'] ?? {}), // Asignar un objeto Empresa vacío si es null
      id: json['id'] ?? 0, // Asignar un valor por defecto si es null
      nombres: json['nombres'] ?? '',
      apellidos: json['apellidos'] ?? '',
      correo: json['correo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'estado': estado,
      'empresa': empresa.toJson(),
      'id': id,
      'nombres': nombres,
      'apellidos': apellidos,
      'correo': correo,
    };
  }
}

class Equipo {
  final String hostname;
  final String serie;
  final String modelo;
  final String marca;
  final String procesador;
  final String memoria;
  final String disco;
  final String condicion;
  final int cantidad;
  final int estado;
  final Usuario usuario;
  final int id;

  Equipo({
    required this.hostname,
    required this.serie,
    required this.modelo,
    required this.marca,
    required this.procesador,
    required this.memoria,
    required this.disco,
    required this.condicion,
    required this.cantidad,
    required this.estado,
    required this.usuario,
    required this.id,
  });

  factory Equipo.fromJson(Map<String, dynamic> json) {
    return Equipo(
      hostname: json['hostname'] ?? '',
      serie: json['serie'] ?? '',
      modelo: json['modelo'] ?? '',
      marca: json['marca'] ?? '',
      procesador: json['procesador'] ?? '',
      memoria: json['memoria'] ?? '',
      disco: json['disco'] ?? '',
      condicion: json['condicion'] ?? '',
      cantidad: json['cantidad'] ?? 0, // Asignar un valor por defecto si es null
      estado: json['estado'] ?? 0, // Asignar un valor por defecto si es null
      usuario: Usuario.fromJson(json['usuario'] ?? {}), // Asignar un objeto Usuario vacío si es null
      id: json['id'] ?? 0, // Asignar un valor por defecto si es null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hostname': hostname,
      'serie': serie,
      'modelo': modelo,
      'marca': marca,
      'procesador': procesador,
      'memoria': memoria,
      'disco': disco,
      'condicion': condicion,
      'cantidad': cantidad,
      'estado': estado,
      'usuario': usuario.toJson(),
      'id': id,
    };
  }
}