enum IncidenteStatus {
  aberto("Aberto"),
  emAndamento("Em Andamento"), 
  resolvido("Resolvido");

  final String texto;
  const IncidenteStatus(this.texto);

  IncidenteStatus get proximo {
    switch (this){
      case IncidenteStatus.aberto:
        return IncidenteStatus.emAndamento;
      case IncidenteStatus.emAndamento:
        return IncidenteStatus.resolvido;
      case IncidenteStatus.resolvido:
        return IncidenteStatus.aberto;
    }
  }
}

enum IncidenteSeveridade {
  critico, alto, medio, baixo,
}

extension IncidenteSeveridadeExtension on IncidenteSeveridade {
  String get textoExibicao {
    switch (this) {
      case IncidenteSeveridade.critico:
        return 'Crítico';
      case IncidenteSeveridade.alto:
        return 'Alto';
      case IncidenteSeveridade.medio:
        return 'Médio';
      case IncidenteSeveridade.baixo:
        return 'Baixo';
    }
  }
}

class Incidente {
  final String id;
  final String titulo;
  final String tipo;
  final IncidenteSeveridade severidade;
  final IncidenteStatus status;
  final DateTime abertoEm;
  final String? responsavel;

  const Incidente({
    required this.id,
    required this.titulo,
    required this.tipo,
    required this.severidade,
    required this.status,
    required this.abertoEm,
    this.responsavel,
  });

  String get abertoHa {
    final decorrido = DateTime.now().difference(abertoEm);
    if (decorrido.inMinutes < 60) {
      return 'há ${decorrido.inMinutes}min';
    }
    if (decorrido.inHours < 24) {
      return 'há ${decorrido.inHours}h';
    }
    final dias = decorrido.inDays;
    return dias == 1 ? 'há 1 dia' : 'há $dias dias';
  }
}