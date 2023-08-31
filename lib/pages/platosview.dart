import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_services.dart';

class Dish extends StatefulWidget {
  @override
  _DishState createState() => _DishState();
}

class _DishState extends State<Dish> {
  List<Map<String, dynamic>> dishList = [];
  List<Map<String, dynamic>> platos = [];
  String selectedRestaurantId = '';
  @override
  void initState() {
    super.initState();
    fetchPeople();
  }

  Future<void> fetchPeople() async {
    List<Map<String, dynamic>> fetchedList = await fetchRestaurants();
    if (mounted) {
      setState(() {
        dishList = fetchedList;
      });
    }
  }

  Future<void> getPlatos(String restaurantId) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("registro/$restaurantId/platos")
        .get();

    List<Map<String, dynamic>> platosList = [];

    snapshot.docs.forEach((DocumentSnapshot doc) {
      Map<String, dynamic> platoData = doc.data() as Map<String, dynamic>;
      platoData['id'] = doc.id; // Agregamos el ID al mapa de datos
      platosList.add(platoData);
    });

    setState(() {
      platos = platosList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD6E2EA),
      appBar: AppBar(
        title: Text('Editar / Eliminar'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 47, 47, 41),
                Color.fromARGB(255, 108, 165, 218),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton(
              items: dishList.map((restaurant) {
                return DropdownMenuItem(
                  value: restaurant[
                      'id'], // Utiliza el ID del documento como valor
                  child: Text(restaurant['nombre']),
                );
              }).toList(),
              onChanged: (selectedRestaurant) async {
                setState(() {
                  selectedRestaurantId = selectedRestaurant as String;
                });

                await getPlatos(selectedRestaurantId);
              },
              hint: Text('Seleccionar Restaurante'),
            ),
            SizedBox(height: 16),
            Text(
              'Platos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),
            // Usamos ListView.builder para mostrar los platos
            ListView.builder(
              shrinkWrap: true,
              itemCount: platos.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          platos[index]['nombre'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              platos[index]['descripcion'],
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "\$${platos[index]['precio']}",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        leading: Image.network(
                          platos[index]['imagenUrl'],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              deleteDish(
                                  selectedRestaurantId, platos[index]['id']);
                            },
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            child: Text('Eliminar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
