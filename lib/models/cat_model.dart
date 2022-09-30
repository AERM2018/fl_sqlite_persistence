class Cat{

    final int? id;
    final String race;
    final String name;
    final String? picPath;
    
    Cat({
      this.id,
      required this.race,
      required this.name,
      this.picPath,
    });

    factory Cat.fromMap(Map<String,dynamic> json) => Cat(id:json['id'],race: json['race'], name: json['name'], picPath: json['picPath']);

    Map<String,dynamic> toMap(){
      return {
        "id":id,
        "race":race,
        "name":name,
        "picPath":picPath
      };
    }
}