


import 'package:graphql_flutter/graphql_flutter.dart';

String Get_Characters = """
    query {
      characters {
        results {
          id 
          name
          status
          species
          type
          gender
          origin {
            name
          }
          image
        }
      }
    }
""";
  
