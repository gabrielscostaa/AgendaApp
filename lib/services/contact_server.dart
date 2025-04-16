import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/contact.dart';

class ContactService {
  static const String _key = 'contacts';

  Future<void> saveContacts(List<Contact> contacts) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList = contacts.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  Future<List<Contact>> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key) ?? [];
    return jsonList.map((json) => Contact.fromJson(jsonDecode(json))).toList();
  }
}
