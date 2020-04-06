import 'dart:io';

import 'package:flutter/material.dart';
import 'package:agenda_flutter/helpers/contact_helper.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;
  ContactPage({this.contact});
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  
  bool _userEdited = false;
  
  Contact _editedContact;

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact.toMap());

      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editedContact.name ?? "Novo contato"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _editedContact.img != null
                          ? FileImage(File(_editedContact.img))
                          : AssetImage("imgs/person.png"),
                    )),
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nome",
              ),
              onChanged: (text) {
                _userEdited = true;
                setState(() {
                  _editedContact.name = text;
                });
              },
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) {
                _userEdited = true;
                _editedContact.email = text;
              },
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Phone",
              ),
              keyboardType: TextInputType.phone,
              onChanged: (text) {
                _userEdited = true;
                _editedContact.phone = text;
              },
            ),
          ],
        ),
      ),
    );
  }
}
