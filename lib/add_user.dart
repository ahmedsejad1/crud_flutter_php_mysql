import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Liste_users.dart';

class add_user extends StatefulWidget {
  @override
  State<add_user> createState() => _add_userState();
}

class _add_userState extends State<add_user> {
  String result = "";

  TextEditingController nom = TextEditingController();

  TextEditingController tel = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController mdp = TextEditingController();

  insert_user() async {
    final http.Response response =
        await http.post(Uri.parse("http://10.0.2.2/api/add.php"), body: {
      'nom': nom.text,
      'tel': tel.text,
      'email': email.text,
      'mdp': mdp.text,
    });
    if (response.statusCode == 200) {
      Navigator.of(context).pop("inserted");
    } else {
      print('Erreur: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Ajouter utlisateur"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/user.png",
                width: 100,
                height: 100,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: "Prénom et nom",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: nom,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: "Teléphone",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: tel,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: "E-mail",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: email,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.key),
                    labelText: "Mot de passe",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: mdp,
                obscureText: true,
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    insert_user();
                  },
                  icon: Icon(Icons.save),
                  label: Text("Ajouter"))
            ],
          ),
        ),
      ),
    );
  }
}
