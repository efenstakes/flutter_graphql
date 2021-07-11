

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
  


String Get_Character = """
    query Get_Character (\$id: ID!) {
      character(id: \$id) {
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
""";
  
