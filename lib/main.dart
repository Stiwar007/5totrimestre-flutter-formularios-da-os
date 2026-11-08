import 'package:flutter/material.dart';

void main() {
  runApp(const ReporteDanoApp());
}

class ReporteDanoApp extends StatelessWidget {
  const ReporteDanoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reporte de Espacio Público',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const FormularioReportePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FormularioReportePage extends StatefulWidget {
  const FormularioReportePage({super.key});

  @override
  State<FormularioReportePage> createState() => _FormularioReportePageState();
}

class _FormularioReportePageState extends State<FormularioReportePage> {
  String? _barrioSeleccionado;
  String? _tipoDanoSeleccionado;

  bool _afectaPeatones = false;
  bool _afectaVehiculos = false;
  bool _afectaComerciantes = false;

  bool _deseaInfo = false;

  bool _formularioEnviado = false;
  String? _mensajeError;

  final List<String> _barrios = ['Belén', 'Laureles', 'Robledo', 'Manrique'];

  void _procesarReporte() {
    setState(() {
      if (_barrioSeleccionado == null || _barrioSeleccionado!.isEmpty) {
        _mensajeError =
            '⚠️ Por favor, selecciona un barrio antes de continuar.';
        _formularioEnviado = false;
      } else {
        _mensajeError = null;
        _formularioEnviado = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte Daño - Medellín'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reporta un daño en el espacio público',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            const Text(
              'Selecciona el Barrio:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              value: _barrioSeleccionado,
              hint: const Text('Seleccione un barrio'),
              isExpanded: true,
              items: _barrios.map((String barrio) {
                return DropdownMenuItem<String>(
                  value: barrio,
                  child: Text(barrio),
                );
              }).toList(),
              onChanged: (String? nuevoValor) {
                setState(() {
                  _barrioSeleccionado = nuevoValor;
                });
              },
            ),
            const SizedBox(height: 20),

            const Text(
              'Tipo de daño:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: const Text('Alumbrado'),
              value: 'Alumbrado',
              groupValue: _tipoDanoSeleccionado,
              onChanged: (String? valor) {
                setState(() {
                  _tipoDanoSeleccionado = valor;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Basuras'),
              value: 'Basuras',
              groupValue: _tipoDanoSeleccionado,
              onChanged: (String? valor) {
                setState(() {
                  _tipoDanoSeleccionado = valor;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Vías'),
              value: 'Vías',
              groupValue: _tipoDanoSeleccionado,
              onChanged: (String? valor) {
                setState(() {
                  _tipoDanoSeleccionado = valor;
                });
              },
            ),
            const SizedBox(height: 10),

            const Text(
              'Personas afectadas:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: const Text('Peatones'),
              value: _afectaPeatones,
              onChanged: (bool? valor) {
                setState(() {
                  _afectaPeatones = valor ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Vehículos'),
              value: _afectaVehiculos,
              onChanged: (bool? valor) {
                setState(() {
                  _afectaVehiculos = valor ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Comerciantes'),
              value: _afectaComerciantes,
              onChanged: (bool? valor) {
                setState(() {
                  _afectaComerciantes = valor ?? false;
                });
              },
            ),
            const SizedBox(height: 10),

            SwitchListTile(
              title: const Text('¿Desea recibir información?'),
              subtitle: Text(_deseaInfo ? 'Activado' : 'Desactivado'),
              value: _deseaInfo,
              onChanged: (bool valor) {
                setState(() {
                  _deseaInfo = valor;
                });
              },
            ),
            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _procesarReporte,
                child: const Text(
                  'Enviar Reporte',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),

            if (_mensajeError != null)
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.red[50],
                child: Text(
                  _mensajeError!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            if (_formularioEnviado && _mensajeError == null) ...[
              const Divider(thickness: 2),
              const Text(
                'Resumen de tu Reporte:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 8),
              Text('• Barrio: ${_barrioSeleccionado ?? "No seleccionado"}'),
              Text(
                '• Tipo de daño: ${_tipoDanoSeleccionado ?? "No seleccionado"}',
              ),
              Text('• Afectados: ${_obtenerAfectadosTexto()}'),
              Text('• Recibir información: ${_deseaInfo ? "Sí" : "No"}'),
            ],
          ],
        ),
      ),
    );
  }

  String _obtenerAfectadosTexto() {
    List<String> lista = [];
    if (_afectaPeatones) lista.add('Peatones');
    if (_afectaVehiculos) lista.add('Vehículos');
    if (_afectaComerciantes) lista.add('Comerciantes');

    return lista.isEmpty ? 'Ninguno' : lista.join(', ');
  }
}
