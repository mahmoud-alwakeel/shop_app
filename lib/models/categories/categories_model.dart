class CategoriesModel{
  bool status;
  CategoriesDataModel data;

  CategoriesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }

}
class CategoriesDataModel{
  int currentPage;
  List<DataModel> data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data.add(DataModel.fromJson(element));
    });
    // data = json['data'];
  }
}

class DataModel{
  int id;
  String name;
  String image;

  DataModel.fromJson(Map<String, dynamic> json){
  id = json['id'];
  name = json['name'];
  image = json['image'];
  }
}

class ProductData {
  int id;
  String name;
  String image;

  ProductData({this.id, this.name, this.image});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}