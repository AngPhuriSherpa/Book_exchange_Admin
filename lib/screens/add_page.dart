import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();

  String _isbn = '';
  String _bookName = '';
  String _author = '';
  String _location = '';
  String _phoneNumber = '';

void _submitForm(String type) async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();

    // Access the Firestore collection
    final collection = FirebaseFirestore.instance.collection('books');

    // Set the document ID as the ISBN value
    final documentId = _isbn;

    // Check if the document already exists
    final documentSnapshot = await collection.doc(documentId).get();

    if (documentSnapshot.exists) {
      // Document already exists, update the count field
      final currentCount = documentSnapshot.data()!['count'] ?? 0;
      final newCount = currentCount + 1;

      await collection.doc(documentId).update({
        'count': newCount,
      });
    } else {
      // Document doesn't exist, create a new document with the form data and document ID
      await collection.doc(documentId).set({
        'ISBN': _isbn,
        'bookName': _bookName,
        'author': _author,
        'location': _location,
        'phoneNumber': _phoneNumber,
        'type': type,
        'count': 1,
      });
    }

    print('Document ID: $documentId');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Lend book',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ISBN',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter ISBN';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _isbn = newValue!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Book Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Book name';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _bookName = newValue!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Author',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Author name';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _author = newValue!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter location';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _location = newValue!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _phoneNumber = newValue!,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _submitForm('Lend'),
                  child: const Text('Lend'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
