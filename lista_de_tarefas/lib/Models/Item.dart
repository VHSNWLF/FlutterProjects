class Item{
  DateTime hora;
  String title = "";
  String? desc = "";

  Item.fromJson(Map<String, dynamic> json)
   :title = json['nome'],
    desc = json['desc'],
    hora = json['hora'];

  Item({required this.hora, required this.title, this.desc});

  Map<String, dynamic> toJson(){
    return {
      'nome': title,
      'desc': desc,
      'hora': hora.toIso8601String()
    };
  }
}