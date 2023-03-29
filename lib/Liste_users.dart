import 'dart:convert';
import 'package:crud_flutter_php_mysql/User.dart';
import 'package:crud_flutter_php_mysql/add_user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:crud_flutter_php_mysql/edit_user.dart';

class Liste_users extends StatefulWidget {
  const Liste_users({Key? key}) : super(key: key);

  @override
  State<Liste_users> createState() => _Liste_usersState();
}

class _Liste_usersState extends State<Liste_users> {
  Future<List<User>> getUsers() async {
    var data = await http.get(Uri.parse("http://10.0.2.2/api/read.php"));
    var jsonData = json.decode(data.body);
    List<User> users = [];
    for (var u in jsonData) {
      User user =
          User(int.parse(u["id"]), u["nom"], u["tel"], u["email"], u["mdp"]);

      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Liste des utilsateurs"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: FutureBuilder(
          future: getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Chargement....")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data[index].nom),
                    subtitle: Text(snapshot.data[index].tel),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/img.png"),
                    ),
                    onTap: () async {
                      final value = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => edit_user(
                              id: snapshot.data[index].id,
                              nom: snapshot.data[index].nom,
                              tel: snapshot.data[index].tel,
                              email: snapshot.data[index].email,
                              mdp: snapshot.data[index].mdp,
                            ),
                          ));
                      if (value == "updated") {
                        setState(() {});
                      }
                    },
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (builder) {
                                return AlertDialog(
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            http.post(
                                                Uri.parse(
                                                    "http://10.0.2.2/api/delete.php"),
                                                body: {
                                                  'id': snapshot.data[index].id
                                                      .toString()
                                                });
                                            Navigator.of(context).pop(true);
                                          });
                                        },
                                        child: Text("Confirmer")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Annuler")),
                                  ],
                                  title: Icon(
                                    Icons.dangerous,
                                    color: Colors.red,
                                  ),
                                  content: Text(
                                      "Êtes-vous sûr de vouloir supprimer ${snapshot.data[index].nom} ?"),
                                );
                              });
                        },
                        icon: Icon(Icons.delete)),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final value = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => add_user()));
          if (value == "inserted") {
            setState(() {});
          }
        },
        child: Icon(Icons.person_add_alt_1),
      ),
    );
  }
}
