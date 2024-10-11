import 'dart:async';
import 'dart:convert';
import 'dart:typed_data' as td;
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_her_app/model/dbHelper/dbHelper.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> _contacts = const [];

  String? _text;

  bool _isLoading = false;

  List<ContactField> _fields = ContactField.values.toList();

  final _ctrl = ScrollController();

  final TextEditingController _searchController = TextEditingController();

  Future<void> loadContacts({String? query}) async {
    try {
      await Permission.contacts.request();
      _isLoading = true;
      if (mounted) setState(() {});
      final sw = Stopwatch()..start();
      _contacts = await FastContacts.getAllContacts(fields: _fields);

      // Filter contacts based on the search query
      if (query != null && query.isNotEmpty) {
        _contacts = _contacts.where((contact) {
          final lowerCaseQuery = query.toLowerCase();
          return contact.displayName.toLowerCase().contains(lowerCaseQuery);
        }).toList();
      }

      sw.stop();
      _text =
          'Contacts: ${_contacts.length}\nTook: ${sw.elapsedMilliseconds}ms';
    } on PlatformException catch (e) {
      _text = 'Failed to get contacts:\n${e.details}';
    } finally {
      _isLoading = false;
    }
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    loadContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contacts'),
        actions: [
          TextButton(
            onPressed: loadContacts,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 24,
                  width: 24,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    // child: _isLoading
                    //     ? CircularProgressIndicator()
                    //     : Icon(Icons.refresh),
                    child: Icon(Icons.refresh),
                  ),
                ),
                const SizedBox(width: 8),
                Text('Load contacts'),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                // Call loadContacts with the updated search query
                loadContacts(query: query);
              },
              decoration: InputDecoration(
                labelText: 'Search by Display Name',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          // Reload the original list of contacts
                          loadContacts();
                        },
                        icon: Icon(Icons.clear),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Colors.grey, // Change the color of the border as needed
                  ),
                  borderRadius:
                      BorderRadius.circular(10.0), // Adjust the border radius
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors
                        .pink, // Change the color of the focused border as needed
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 11,
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _contacts.isEmpty
                    ? Center(child: Text('No contacts found.'))
                    : Scrollbar(
                        controller: _ctrl,
                        interactive: true,
                        thickness: 18,
                        child: ListView.builder(
                          controller: _ctrl,
                          itemCount: _contacts.length,
                          itemExtent: 80,
                          itemBuilder: (_, index) =>
                              _ContactItem(contact: _contacts[index]),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({
    Key? key,
    required this.contact,
  }) : super(key: key);

  //static final height = 6.0;

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final phones = contact.phones.map((e) => e.number).join(', ');
    // final emails = contact.emails.map((e) => e.address).join(', ');
    // final name = contact.structuredName;
    // final nameStr = name != null
    //     ? [
    //         if (name.namePrefix.isNotEmpty) name.namePrefix,
    //         if (name.givenName.isNotEmpty) name.givenName,
    //         if (name.middleName.isNotEmpty) name.middleName,
    //         if (name.familyName.isNotEmpty) name.familyName,
    //         if (name.nameSuffix.isNotEmpty) name.nameSuffix,
    //       ].join(', ')
    //     : '';
    // final organization = contact.organization;
    // final organizationStr = organization != null
    //     ? [
    //         if (organization.company.isNotEmpty) organization.company,
    //         if (organization.department.isNotEmpty) organization.department,
    //         if (organization.jobDescription.isNotEmpty)
    //           organization.jobDescription,
    //       ].join(', ')
    //     : '';

    return Container(
      //height: 40,
      decoration: BoxDecoration(
        border: Border.all(width: 0.04),
      ),
      child: Center(
        child: ListTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => _ContactDetailsPage(
                contactId: contact.id,
              ),
            ),
          ),
          leading: _ContactImage(
              contact: contact), // Assuming _ContactImage is a custom widget
          title: Text(
            contact.displayName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          subtitle: (phones.isNotEmpty)
              ? ListTileSubtitleItem(
                  icon: Icons.phone,
                  text: phones,
                )
              : Text('Number not present'),
          trailing: FutureBuilder<bool>(
            future: DbHelper.isContactFav(contact.id),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error Fetching Contacts \nPlease try again');
              } else {
                final bool isFavorite = snapshot.data ?? false;
                return IconButton(
                  onPressed: () async {
                    if (isFavorite) {
                      // Remove from favorites
                      await DbHelper.deleteContact(contact.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${contact.displayName} removed from favorites'),
                        ),
                      );
                      Navigator.pop(context);
                    } else {
                      // Add to favorites
                      await DbHelper.saveContact(contact);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('${contact.displayName} added to favorites'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  tooltip: isFavorite ? 'Remove' : 'Add',
                  icon: isFavorite ? Icon(Icons.remove) : Icon(Icons.add),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ListTileSubtitleItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const ListTileSubtitleItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 15,
        ),
        SizedBox(width: 4.0),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ContactImage extends StatefulWidget {
  const _ContactImage({
    Key? key,
    required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  __ContactImageState createState() => __ContactImageState();
}

class __ContactImageState extends State<_ContactImage> {
  late Future<td.Uint8List?> _imageFuture;

  @override
  void initState() {
    super.initState();
    _imageFuture = FastContacts.getContactImage(widget.contact.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<td.Uint8List?>(
      future: _imageFuture,
      builder: (context, snapshot) => CircleAvatar(
        radius: 30,
        backgroundImage: snapshot.hasData
            ? MemoryImage(
                snapshot.data!,
              )
            : null, // Set to null if no image data
        child: snapshot.hasData ? null : Icon(Icons.account_box_rounded),
      ),
    );
  }
}

class _ContactDetailsPage extends StatefulWidget {
  const _ContactDetailsPage({
    Key? key,
    required this.contactId,
  }) : super(key: key);

  final String contactId;

  @override
  State<_ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<_ContactDetailsPage> {
  late Future<Contact?> _contactFuture;

  Duration? _timeTaken;

  @override
  void initState() {
    super.initState();
    final sw = Stopwatch()..start();
    _contactFuture = FastContacts.getContact(widget.contactId).then((value) {
      _timeTaken = (sw..stop()).elapsed;
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact details: ${widget.contactId}'),
      ),
      body: FutureBuilder<Contact?>(
        future: _contactFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final error = snapshot.error;
          if (error != null) {
            return Center(child: Text('Error: $error'));
          }

          final contact = snapshot.data;
          if (contact == null) {
            return const Center(child: Text('Contact not found'));
          }

          final contactJson =
              JsonEncoder.withIndent('  ').convert(contact.toMap());

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ContactImage(contact: contact),
                  const SizedBox(height: 16),
                  if (_timeTaken != null)
                    Text('Took: ${_timeTaken!.inMilliseconds}ms'),
                  const SizedBox(height: 16),
                  Text(contactJson),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
