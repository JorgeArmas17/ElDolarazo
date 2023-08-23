import 'package:flutter/material.dart';

class FormularioPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _apellidoController = TextEditingController();
  TextEditingController _celularController = TextEditingController();
  TextEditingController _telefonoController = TextEditingController();
  TextEditingController _correoController = TextEditingController();

  void _mostrarNotificacion(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Formulario enviado correctamente'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Formulario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 40.0),
              TextFormField(
                controller: _nombreController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu nombre';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              SizedBox(height: 40.0),
              TextFormField(
                controller: _apellidoController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu apellido';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Apellido'),
              ),
              SizedBox(height: 40.0),
              TextFormField(
                controller: _celularController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Celular'),
              ),
              SizedBox(height: 40.0),
              TextFormField(
                controller: _telefonoController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Teléfono'),
              ),
              SizedBox(height: 40.0),
              TextFormField(
                controller: _correoController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu correo electrónico';
                  } else if (!value.contains('@')) {
                    return 'Correo electrónico inválido';
                  }
                  return null;
                },

                decoration: InputDecoration(labelText: 'Correo Electrónico'),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  _mostrarNotificacion(context);
                },
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
