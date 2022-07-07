class User{
      int? id;
      String? title;
      String? description;

      userMap() {
            var mapping = Map<String, dynamic>();
            mapping['id'] = id ?? null;
            mapping['title'] = title!;
            mapping['description'] = description!;
            return mapping;
      }
}