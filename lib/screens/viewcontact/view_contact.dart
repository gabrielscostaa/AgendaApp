import 'package:agenda_app/screens/editcontact/edit_contact.dart';
import 'package:flutter/material.dart';
import '../../models/contact.dart';

class ContactDetailScreen extends StatelessWidget {
  final Contact contact;
  final VoidCallback onDelete;

  const ContactDetailScreen({
    super.key,
    required this.contact,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(contact.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(contact.phone, style: const TextStyle(fontSize: 18)),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () async {
                    final edited = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditContactScreen(contact: contact),
                      ),
                    );

                    if (edited != null) {
                      Navigator.pop(context, true);
                    }
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    onDelete();
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Excluir'),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
