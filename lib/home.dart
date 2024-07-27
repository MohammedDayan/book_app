import 'package:book_app/data.dart';
// import 'package:flutter/material.dart';

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //app bar
//     final appBar = AppBar(
//       elevation: .5,
//       leading: IconButton(
//         icon: Icon(Icons.menu),
//         onPressed: () {},
//       ),
//       title: Text('Book Store'),
//       actions: <Widget>[
//         IconButton(
//           icon: Icon(Icons.search),
//           onPressed: () {},
//         )
//       ],
//     );

//     ///create book tile hero
//     createTile(Book book) => Hero(
//           tag: book.title,
//           child: Material(
//             elevation: 15.0,
//             shadowColor: Colors.yellow.shade900,
//             child: InkWell(
//               onTap: () {
//                 Navigator.pushNamed(context, 'detail/${book.title}');
//               },
//               child: Image(
//                 image: AssetImage(book.image),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         );

//     ///create book grid tiles
//     final grid = CustomScrollView(
//       primary: false,
//       slivers: <Widget>[
//         SliverPadding(
//           padding: EdgeInsets.all(16.0),
//           sliver: SliverGrid.count(
//             childAspectRatio: 2 / 3,
//             crossAxisCount: 3,
//             mainAxisSpacing: 20.0,
//             crossAxisSpacing: 20.0,
//             children: books.map((book) => createTile(book)).toList(),
//           ),
//         )
//       ],
//     );

//     return Scaffold(
//       // backgroundColor: Theme.of(context).primaryColor,
//       backgroundColor: Colors.white,
//       appBar: appBar,
//       body: grid,
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //app bar
    final appBar = AppBar(
      elevation: .5,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      title: Text('Book Store'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        )
      ],
    );

    ///create book tile hero
    createTile(Book book) => Hero(
          tag: book.title,
          child: Material(
            elevation: 15.0,
            shadowColor: Colors.yellow.shade900,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'detail/${book.title}');
              },
              child: Image(
                image: AssetImage(book.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );

    ///create book grid tiles
    final grid = CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('books').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
              return SliverGrid.count(
                childAspectRatio: 2 / 3,
                crossAxisCount: 3,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                children: snapshot.data!.docs.map((document) {
                  Book book = Book.fromMap(document.data() as Map<String, dynamic>);
                  return createTile(book);
                }).toList(),
              );
            },
          ),
        )
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: grid,
    );
  }
}
