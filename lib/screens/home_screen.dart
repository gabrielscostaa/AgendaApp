import 'package:agenda_app/screens/editcontact/edit_contact.dart';
import 'package:agenda_app/screens/viewcontact/view_contact.dart';
import 'package:agenda_app/services/contact_server.dart';
import 'package:flutter/material.dart';
import '../models/contact.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ContactService _service = ContactService();
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final contacts = await _service.loadContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  void _navigateToAddContact() async {
    final newContact = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EditContactScreen()),
    );

    if (newContact != null) {
      setState(() {
        _contacts.add(newContact);
      });
      _service.saveContacts(_contacts);
    }
  }

  void _deleteContact(int index) {
    setState(() => _contacts.removeAt(index));
    _service.saveContacts(_contacts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda de Contatos')),
      body: _contacts.isEmpty
          ? const Center(child: Text('Nenhum contato.'))
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (_, index) {
                final contact = _contacts[index];
                return ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.phone),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ContactDetailScreen(
                          contact: contact,
                          onDelete: () => _deleteContact(index),
                        ),
                      ),
                    );

                    if (result == true) {
                      _loadContacts();
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddContact,
        child: const Icon(Icons.add),
      ),
    );
  }
}
