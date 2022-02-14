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
}

class Ligen {
  final List<Liga> ligenliste;

  Ligen({this.ligenliste});
}
