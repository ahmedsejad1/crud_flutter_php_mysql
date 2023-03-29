import 'package:crud_flutter_php_mysql/Liste_users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class edit_user extends StatefulWidget {
  final int id;
  final String nom;
  final String tel;
  final String email;
  final String mdp;

  edit_user(
      {required this.id,
      required this.nom,
      required this.tel,
      required this.email,
      required this.mdp});

  @override
  State<edit_user> createState() => _edit_userState();
}

class _edit_userState extends State<edit_user> {
  TextEditingController nom = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mdp = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != null) {
      nom.text = widget.nom;
      tel.text = widget.tel;
      email.text = widget.email;
      mdp.text = widget.mdp;
    }
  }

  update_user() async {
    final http.Response response =
        await http.post(Uri.parse("http://10.0.2.2/api/edit.php"), body: {
      'id': widget.id.toString(),
      'nom': nom.text,
      'tel': tel.text,
      'email': email.text,
      'mdp': mdp.text,
    });

    if (response.statusCode == 200) {
      Navigator.pop(context, "updated");
    } else {
      print('Erreur: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Modifier utlisateur"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/edit.png",
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
                    update_user();
                  },
                  icon: Icon(Icons.edit),
                  label: Text("Modifier"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
