class VisitPlaceFields{

  static final String id = 'id';
  static final String nombre ='nombre';
  static final String descripcion = 'descripcion';
  static final String latitude = 'coordenada';
  static final String longitude = 'time';

  //crear una lista estatica con el nombre de los valores para ayudar en la obtencion de datos de la bbd
  static final List <String> valores =[id,nombre,descripcion,latitude,longitude];
}

class VisitPlace{
  final int? id;
  final String nombre;
  final String descripcion;
  final String latitude;
  final String longitude;

  const VisitPlace({this.id,required this.nombre,required this.descripcion,required this.latitude,required this.longitude});

  factory VisitPlace.fromMap(Map<String,dynamic> value) =>
      VisitPlace(
        id: value["id"],
        nombre: value["nombre"],
        descripcion: value["descripcion"],
        latitude: value["latitude"],
        longitude: value["longitude"],
      );

}