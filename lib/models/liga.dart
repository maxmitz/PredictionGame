class Liga {
  final String regionname;
  final String bezirksname;
  final String kategoriename;
  final String liganame;
  final String ligalink;

  Liga(
      {this.regionname,
      this.bezirksname,
      this.kategoriename,
      this.liganame,
      this.ligalink});

  /*Map<String, dynamic> ligaItem(String region,String bezirk, String kategorie, String liga, String link) => {
    return {
    
    'Ligen': FieldValue.arrayUnion([
      {

        'region': region,
        'bezirk': bezirk,
        'kategorie': kategorie,
        'liga': liga,
        'link': link
      },

    ]),
    }
  };*/

}

class Ligen {
  final List<Liga> ligenliste;

  Ligen({this.ligenliste});
}
