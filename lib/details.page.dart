import 'package:flutter/material.dart';
import 'package:fluttr_graphql/queries.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DetailsPage extends StatefulWidget {
  final String? id;
  const DetailsPage({ Key? key, required this.id }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Details',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Query(
        options: QueryOptions(
          document: gql(Get_Character),
          variables: {
            'id': widget.id,
          },
        ), 
        builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore  }) {

          if( result.hasException ) {
            return Center(
              child: Column(
                children: [

                  Text(
                    'OOps',
                    style: GoogleFonts.indieFlower(),
                  ),
                  
                  Text(
                    'Check your network or try again after a while',
                    style: GoogleFonts.indieFlower(),
                  ),

                ],
              ),
            );
          }

          if( result.isLoading ) {
            return Center(
              child: Column(
                children: [

                  CircularProgressIndicator(),
                  
                  Text(
                    'Check your network or try again after a while',
                    style: GoogleFonts.indieFlower(),
                  ),

                ],
              ),
            );
          }

          if( result.data != null ) {
            print(result.data?['character']['id']);
          }
          Map<String, dynamic> character = result.data?['character'];

          return ListView(
            children: [

              Container(
                height: MediaQuery.of(context).size.height*.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.lime,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(character['image'], fit: BoxFit.cover),
              ),
              
              Text(
                character['name'],
                style: GoogleFonts.indieFlower(
                  fontSize: 32,
                ),
              ),
              
              Text(
                character['gender'],
              ),
              
              Text(
                character['species'],
              ),
              
              Text(
                character['status'],
              ),

            ],
          );
        }
      ),
    );
  }
}