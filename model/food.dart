class Food {
  String nombre;
  String precio;
  String imagenUrl;
  String descripcion;
  String ingredientes;
  String estrellas;

  Food(
      {required this.nombre,
      required this.precio,
      required this.imagenUrl,
      required this.descripcion,
      required this.ingredientes,
      required this.estrellas});

  String get _nombre => nombre;
  String get _price => precio;
  String get _imagenUrl => imagenUrl;
  String get _descripcion => descripcion;
  String get _ingredientes => ingredientes;
  String get _estrellas => estrellas;
}