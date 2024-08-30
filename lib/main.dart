import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(CalculadoraFinanciera());
}

class CalculadoraFinanciera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Financiera',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: MenuPrincipal(),
    );
  }
}

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Financiera'),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            MenuCard(
              title: 'Interés Simple',
              icon: Icons.attach_money,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InteresSimplePage()),
                );
              },
            ),
            MenuCard(
              title: 'Interés Compuesto',
              icon: Icons.trending_up,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InteresCompuestoPage()),
                );
              },
            ),
            MenuCard(
              title: 'Gradiente Aritmético',
              icon: Icons.bar_chart,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GradienteAritmeticoPage()),
                );
              },
            ),
            MenuCard(
              title: 'Gradiente Geométrico',
              icon: Icons.show_chart,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GradienteGeometricoPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  MenuCard({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: EdgeInsets.all(20),
        leading: Icon(icon, size: 40, color: Colors.indigo),
        title: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.indigo),
        onTap: onTap,
      ),
    );
  }
}

class InteresSimplePage extends StatefulWidget {
  @override
  _InteresSimplePageState createState() => _InteresSimplePageState();
}

class _InteresSimplePageState extends State<InteresSimplePage> {
  final _principalController = TextEditingController();
  final _tasaInteresController = TextEditingController();
  final _tiempoController = TextEditingController();

  double _resultado = 0.0;

  void _calcularInteresSimple() {
    double principal = double.tryParse(_principalController.text) ?? 0.0;
    double tasaInteres = double.tryParse(_tasaInteresController.text) ?? 0.0;
    double tiempo = double.tryParse(_tiempoController.text) ?? 0.0;

    setState(() {
      _resultado = principal * tasaInteres * tiempo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interés Simple'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _principalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Principal',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _tasaInteresController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Tasa de Interés',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _tiempoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Tiempo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularInteresSimple,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text('Resultado: \$${_resultado.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class InteresCompuestoPage extends StatefulWidget {
  @override
  _InteresCompuestoPageState createState() => _InteresCompuestoPageState();
}

class _InteresCompuestoPageState extends State<InteresCompuestoPage> {
  final _principalController = TextEditingController();
  final _tasaInteresController = TextEditingController();
  final _tiempoController = TextEditingController();
  final _capitalizacionesController = TextEditingController();

  double _resultado = 0.0;

  void _calcularInteresCompuesto() {
    double principal = double.tryParse(_principalController.text) ?? 0.0;
    double tasaInteres = double.tryParse(_tasaInteresController.text) ?? 0.0;
    double tiempo = double.tryParse(_tiempoController.text) ?? 0.0;
    int capitalizaciones = int.tryParse(_capitalizacionesController.text) ?? 1;

    setState(() {
      _resultado = principal * (pow(1 + (tasaInteres / capitalizaciones), capitalizaciones * tiempo)) - principal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interés Compuesto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _principalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Principal'),
            ),
            TextField(
              controller: _tasaInteresController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tasa de Interés'),
            ),
            TextField(
              controller: _tiempoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tiempo (años)'),
            ),
            TextField(
              controller: _capitalizacionesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Capitalizaciones por Año'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularInteresCompuesto,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text('Resultado: \$${_resultado.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

class GradienteAritmeticoPage extends StatefulWidget {
  @override
  _GradienteAritmeticoPageState createState() => _GradienteAritmeticoPageState();
}

class _GradienteAritmeticoPageState extends State<GradienteAritmeticoPage> {
  final _gradienteController = TextEditingController();
  final _tasaInteresController = TextEditingController();
  final _periodosController = TextEditingController();

  double _resultado = 0.0;

  void _calcularGradienteAritmetico() {
    double gradiente = double.tryParse(_gradienteController.text) ?? 0.0;
    double tasaInteres = double.tryParse(_tasaInteresController.text) ?? 0.0;
    int periodos = int.tryParse(_periodosController.text) ?? 0;

    setState(() {
      _resultado = gradiente * ((pow(1 + tasaInteres, periodos) - 1) / pow(tasaInteres, 2) - periodos / tasaInteres);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gradiente Aritmético'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _gradienteController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Gradiente'),
            ),
            TextField(
              controller: _tasaInteresController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tasa de Interés'),
            ),
            TextField(
              controller: _periodosController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número de Períodos'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularGradienteAritmetico,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text('Resultado: \$${_resultado.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

class GradienteGeometricoPage extends StatefulWidget {
  @override
  _GradienteGeometricoPageState createState() => _GradienteGeometricoPageState();
}

class _GradienteGeometricoPageState extends State<GradienteGeometricoPage> {
  final _primerPagoController = TextEditingController();
  final _tasaInteresController = TextEditingController();
  final _tasaCrecimientoController = TextEditingController();
  final _periodosController = TextEditingController();

  double _resultado = 0.0;

  void _calcularGradienteGeometrico() {
    double primerPago = double.tryParse(_primerPagoController.text) ?? 0.0;
    double tasaInteres = double.tryParse(_tasaInteresController.text) ?? 0.0;
    double tasaCrecimiento = double.tryParse(_tasaCrecimientoController.text) ?? 0.0;
    int periodos = int.tryParse(_periodosController.text) ?? 0;

    if (tasaInteres == tasaCrecimiento) {
      setState(() {
        _resultado = primerPago * periodos / (1 + tasaInteres);
      });
    } else {
      setState(() {
        _resultado = (primerPago / (tasaInteres - tasaCrecimiento)) * 
                     (1 - pow((1 + tasaCrecimiento) / (1 + tasaInteres), periodos));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gradiente Geométrico'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _primerPagoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Primer Pago'),
            ),
            TextField(
              controller: _tasaInteresController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tasa de Interés'),
            ),
            TextField(
              controller: _tasaCrecimientoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tasa de Crecimiento'),
            ),
            TextField(
              controller: _periodosController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Número de Períodos'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calcularGradienteGeometrico,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text('Resultado: \$${_resultado.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
