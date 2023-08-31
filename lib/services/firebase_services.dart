import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

FirebaseFirestore db = FirebaseFirestore.instance;

//Funcion para añadir restaurante
Future<void> addRestaurant(
    String name, String description, String location, String imageUrl) async {
  await firestore.FirebaseFirestore.instance.collection("registro").add({
    "nombre": name,
    "descripcion": description,
    "ubicacion": location,
    "imagenUrl": imageUrl,
  });
}

//Funcion para añadir restaurante usando como identificar el id de un restaurante especifio
//Crea una nueva coleccion dentro de la principal para los platos
Future<void> addDish(
    String restaurantId,
    String name,
    String imageUrl,
    String description,
    String estrellas,
    String precio,
    String ingredientes) async {
  await firestore.FirebaseFirestore.instance
      .collection("registro/$restaurantId/platos")
      .add({
    "nombre": name,
    "imagenUrl": imageUrl,
    "descripcion": description,
    "estrellas": estrellas,
    "precio": precio,
    "ingredientes": ingredientes,
  });
}

Future<void> addComentario(String coment) async {
  await firestore.FirebaseFirestore.instance.collection("comentarios").add({
    "resena": coment,
  });
}

//Funcion para obtener  mediante un mapeo la parte de la coleccion del registro del restaurante
//el ID y retornar la lista de los restaurantes
Future<List<Map<String, dynamic>>> fetchRestaurants() async {
  final snapshot =
      await firestore.FirebaseFirestore.instance.collection("registro").get();

  final restaurantList = snapshot.docs.map((doc) {
    Map<String, dynamic> restaurantData = doc.data() as Map<String, dynamic>;
    restaurantData['id'] = doc.id; // Agrega el ID del documento al mapa
    return restaurantData;
  }).toList();

  return restaurantList;
}

//Funcion para obtener los platos dependiendo de ID o restaurante del que quiera saber los platos
Future<List<Map<String, dynamic>>> getPlatos(String restaurantId) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection("registro/$restaurantId/platos")
      .get();

  List<Map<String, dynamic>> platos = [];

  snapshot.docs.forEach((DocumentSnapshot doc) {
    platos.add(doc.data() as Map<String, dynamic>);
  });

  return platos;
}

Future<void> deleteDish(String restaurantId, String dishId) async {
  await firestore.FirebaseFirestore.instance
      .collection("registro/$restaurantId/platos")
      .doc(dishId)
      .delete();
  await getPlatos(restaurantId);
}
