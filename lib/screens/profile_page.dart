import 'package:book_exchange_admin/components/show_confirmation_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final _name = TextEditingController();
  final _email = TextEditingController();
  DateTime? _selectedDate;
  final _address = TextEditingController();

  @override
  void initState() {
    super.initState();

    _firestore.collection('users').doc(user.uid).get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data()!;
        _name.text = data['userName'] ?? '';
        _email.text = data['email'] ?? '';
        final birthDate = data['birthDate'] as Timestamp?;
        _selectedDate = birthDate?.toDate() ?? null;
        _address.text = data['address'] ?? '';
        setState(
            () {}); // Trigger a rebuild to update the UI with the retrieved data
      }
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _address.dispose();
    super.dispose();
  }

  void signUserOut() async {
    final confirmed = await showConfirmationDialog(
        context, 'Confirmation', 'Are you sure you want to sign out?');
    if (confirmed == true) {
      FirebaseAuth.instance.signOut();
    }
  }

  Future<void> deleteUser() async {
    final confirmed = await showConfirmationDialog(context, 'Confirmation',
        'Are you sure you want to delete your account? This action cannot be undone.');
    if (confirmed == true) {
      try {
        await user.delete();
        await _firestore.collection('users').doc(user.uid).delete();
      } on FirebaseAuthException catch (e) {
        print('Failed to delete user: $e');
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  Future<void> updateUser() async {
    try {
      await user.updateEmail(_email.text);
      await _firestore.collection('users').doc(user.uid).update({
        'userName': _name.text,
        'birthDate':
            _selectedDate != null ? Timestamp.fromDate(_selectedDate!) : null,
        'address': _address.text,
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } on FirebaseAuthException catch (e) {
      print('Failed to update user: $e');
    } catch (e) {
      print('Error: $e');
    }
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Please select your birthdate'
                          : 'Birthdate: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _selectDate,
                    child: const Text('Select'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _address,
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
                maxLines: null,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: updateUser,
                child: const Text('Save Changes'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: signUserOut,
                child: const Text('Sign Out'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: deleteUser,
                child: const Text('Delete Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
