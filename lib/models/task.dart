class Task {
  String name;
  String description;
  String place;
  bool completed;
  String date;

  Task({required this.name, required this.description, required this.place ,
  required this.completed, required this.date});

  factory Task.fromJson(dynamic json){
    return Task(name: json["name"],
        description: json["description"],
        place: json["place"],
        completed: json["completed"],
        date: json["date"]);
  }
  static List<Task> tasksFromJson(dynamic json ){
    var apiResult = json["data"];
    List<Task> results = List.empty(growable: true);

    if (apiResult != null){

      apiResult.forEach((v)=>{
        results.add(Task.fromJson(v))
      });
      return results;
    }
    return results;
  }



}