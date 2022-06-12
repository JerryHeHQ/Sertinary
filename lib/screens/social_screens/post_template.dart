class PostTemplate {
  String uid;
  String title;
  int calories;
  int carbs;
  int protein;
  int fats;
  String ingredients;
  String instructions;
  String username;

  PostTemplate({
    required this.uid,
    required this.title,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fats,
    required this.ingredients,
    required this.instructions,
    required this.username,
  });

  //Send Data To Firebase Server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'calories': calories,
      'carbs': carbs,
      'protein': protein,
      'fats': fats,
      'ingredients': ingredients,
      'instructions': instructions,
      'username': username,
      'likes': 0,
    };
  }
}
