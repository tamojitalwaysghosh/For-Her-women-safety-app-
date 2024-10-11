import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:for_her_app/model/Fav_contact/fav_contact.dart';
import 'package:for_her_app/model/dbHelper/dbHelper.dart';
import 'package:for_her_app/view/contacts_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteContactsScreen extends StatefulWidget {
  const FavoriteContactsScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteContactsScreen> createState() => _FavoriteContactsScreenState();
}

class _FavoriteContactsScreenState extends State<FavoriteContactsScreen> {
  late Future<List<FavContact>> _futureFavoriteContacts;

  @override
  void initState() {
    super.initState();
    _futureFavoriteContacts = DbHelper.getFavContacts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh the contact list when the dependencies (e.g., Navigator) change
    _futureFavoriteContacts = DbHelper.getFavContacts();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * .1,
        centerTitle: true,
        title: Text(
          'Guardians',
          style: GoogleFonts.aboreto(
            textStyle: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 19, 1, 7),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<FavContact>>(
        future: _futureFavoriteContacts,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text('Error fetching contacts: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            final contacts = snapshot.data!;
            return _buildContactList(contacts);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactsScreen(),
            ),
          ).then((_) {
            // Use a callback to refresh the contact list after returning from ContactsScreen
            setState(() {
              _futureFavoriteContacts = DbHelper.getFavContacts();
            });
          });
        },
        child: Icon(Icons.person_add),
      ),
    );
  }

  Widget _buildContactList(List<FavContact> contacts) {
    if (contacts.isEmpty) {
      return const Center(child: Text('No favorite contacts found'));
    }
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage:
                contact.image != null ? MemoryImage(contact.image!) : null,
            child: contact.image == null
                ? Icon(
                    Icons.account_circle, // Replace with your desired icon
                    color: Colors.pinkAccent,
                    size: 40, // Adjust the size of the icon as needed
                  )
                : null,
          ),
          title: Text(contact.displayName),
          subtitle: Text(contact.phoneNumbers),
          // Add more actions as needed (e.g., view details, delete)
          trailing: Container(
            width: MediaQuery.of(context).size.width * .3,
            child: Row(
              children: [
                IconButton(
                    onPressed: () async {
                      await FlutterPhoneDirectCaller.callNumber(
                          contact.phoneNumbers);
                    },
                    icon: Icon(
                      Icons.call,
                      color: Color.fromARGB(255, 163, 101, 121),
                    )),
                IconButton(
                    onPressed: () async {
                      await DbHelper.deleteContact(contact.id);
                      // Update the state after deleting a contact
                      setState(() {
                        _futureFavoriteContacts = DbHelper.getFavContacts();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${contact.displayName} removed from favorites'),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      color: const Color.fromARGB(137, 65, 60, 60),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
