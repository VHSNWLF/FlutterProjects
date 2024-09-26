import 'dart:convert';

import 'package:lista_de_tarefas/Models/Item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemRepository{
late SharedPreferences sharedPreferences;

Future<List<Item>> getItemList() async{
 sharedPreferences = await SharedPreferences.getInstance();
 final String jsonString = sharedPreferences.getString('item_list') ?? '[]';
 final List jsonDecoded = json.decode(jsonString) as List;
 return jsonDecoded.map((e) => Item.fromJson(e)).toList();
}

void saveItemList(List<Item> items){
  final String formatJson = json.encode(items);
  sharedPreferences.setString('item_list', formatJson);
}
}