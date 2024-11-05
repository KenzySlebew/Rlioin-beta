// class _HomePageState extends State<HomePage> {
//   final DBHelper dbHelper = DBHelper();
//   List<Map<String, dynamic>> _users = [];
//   List<Map<String, dynamic>> _filteredUsers = [];
//   final TextEditingController _searchController = TextEditingController();

//   final List<String> imgList = [
//     'https://marketplace.canva.com/EAFt1tP1LFw/1/0/1600w/canva-hitam-putih-simpel-minimal-desain-portfolio-presentation-U23DTXx-RHA.jpg',
//     'https://marketplace.canva.com/EAFFzPkF8pw/1/0/1600w/canva-kreatif-portofolio-perancang-busana-presentasi-mRGW7SfBT5s.jpg',
//     'https://marketplace.canva.com/EAFsPkM5oZg/2/0/1600w/canva-black-grey-minimalist-clean-creative-portfolio-presentation-lpaulTasxy0.jpg',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _refreshUsers();
//   }

//   void _refreshUsers() async {
//     final data = await dbHelper.queryAllUsers();
//     setState(() {
//       _users = data;
//       _filteredUsers = data;
//     });
//   }

//   void _searchUser(String query) {
//     final results = _users.where((user) {
//       final userName = user['name'].toLowerCase();
//       final input = query.toLowerCase();
//       return userName.contains(input);
//     }).toList();
//     setState(() {
//       _filteredUsers = results;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//             child:
//                 Image.asset('assets/logo.png', fit: BoxFit.cover, width: 100)),
//         backgroundColor: Color(0xFF002D82),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Search',
//                 suffixIcon: Icon(Icons.search),
//               ),
//               onChanged: _searchUser,
//             ),
//           ),
//           CarouselSlider(
//             options: CarouselOptions(
//               autoPlay: true,
//               aspectRatio: 2.0,
//               enlargeCenterPage: true,
//             ),
//             items: imgList
//                 .map((item) => Container(
//                       child: Center(
//                           child: Image.network(item,
//                               fit: BoxFit.cover, width: 1000)),
//                     ))
//                 .toList(),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredUsers.length,
//               itemBuilder: (context, index) => Card(
//                 margin: const EdgeInsets.all(15),
//                 child: ListTile(
//                   title: Text(_filteredUsers[index]['name']),
//                   subtitle: Text(_filteredUsers[index]['address']),
//                   leading: _filteredUsers[index]['imagePath'] != null
//                       ? Image.file(
//                           File(_filteredUsers[index]['imagePath']),
//                           width: 50,
//                           height: 50,
//                           fit: BoxFit.cover,
//                         )
//                       : const Icon(Icons.account_circle, size: 50),
//                   trailing: SizedBox(
//                     width: 100,
//                     child: Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.edit),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => FormPage(
//                                     userId: _filteredUsers[index]['id']),
//                               ),
//                             );
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text('Hapus Portofolio'),
//                                   content: Text(
//                                       'Apakah anda yakin ingin menghapus portofolio ini?'),
//                                   actions: <Widget>[
//                                     TextButton(
//                                       onPressed: () => Navigator.pop(context),
//                                       child: Text('Cancel'),
//                                     ),
//                                     TextButton(
//                                       onPressed: () async {
//                                         await DBHelper().deleteUser(
//                                             _filteredUsers[index]['id']);
//                                         _refreshUsers(); // Refresh the list after deletion
//                                         Navigator.pop(context);
//                                       },
//                                       child: Text('Delete'),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
