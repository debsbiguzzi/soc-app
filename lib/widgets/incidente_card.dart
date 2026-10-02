import 'package:flutter/material.dart';
import '../models/incidente.dart';

IconData iconeDaSeveridade(IncidenteSeveridade severidade) {
  switch (severidade) {
    case IncidenteSeveridade.critico:
      return Icons.report;
    case IncidenteSeveridade.alto:
      return Icons.warning;
    case IncidenteSeveridade.medio:
      return Icons.info;
    case IncidenteSeveridade.baixo:
      return Icons.low_priority;
  }
}

Color corDaSeveridade(IncidenteSeveridade severidade) {
  switch (severidade) {
    case IncidenteSeveridade.critico:
      return Colors.red;
    case IncidenteSeveridade.alto:
      return Colors.orange;
    case IncidenteSeveridade.medio:
      return Colors.amber;
    case IncidenteSeveridade.baixo:
      return Colors.blue;
  }
}

Color corDoStatus(IncidenteStatus status) {
  switch (status) {
    case IncidenteStatus.aberto:
      return Colors.red;
    case IncidenteStatus.emAndamento:
      return Colors.amber;
    case IncidenteStatus.resolvido:
      return Colors.green;
  }
}

class IncidenteCard extends StatefulWidget {
  final Incidente incidente;

  const IncidenteCard({super.key, required this.incidente});

  @override
  State<StatefulWidget> createState() => _IncidenteCardState();

}

class _IncidenteCardState extends State<IncidenteCard> {

  late IncidenteStatus status = widget.incidente.status;

  @override
  Widget build(BuildContext context) {
    final incidente = widget.incidente;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    incidente.severidade.textoExibicao,
                    style: TextStyle(
                      color: corDaSeveridade(incidente.severidade),
                    ),
                  ),
                  backgroundColor: corDaSeveridade(incidente.severidade)
                      .withValues(alpha: 0.1),
                  side: BorderSide(
                    color: corDaSeveridade(incidente.severidade),
                  ),
                ),
                Text(incidente.abertoHa),
              ],
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Icon(
                  iconeDaSeveridade(incidente.severidade),
                  color: corDaSeveridade(incidente.severidade),
                ),
                const SizedBox(width: 8),
                Text(
                  incidente.titulo,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 4),
            Text(
              '#${incidente.id} · ${incidente.tipo}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 4),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    status.texto,
                    style: TextStyle(color: corDoStatus(status)),
                  ),
                  backgroundColor: Colors.grey.withValues(alpha: 0.2),
                  side: BorderSide(color: corDoStatus(status)),
                ),
                Text(incidente.responsavel ?? 'Sem responsável'),
              ],
            ),
            ElevatedButton(
              onPressed:() {
                setState(() {
                  status = status.proximo;
                });
              },
              child: Text("Avançar status")
            )
          ],
        ),
      ),
    );
  }
}
