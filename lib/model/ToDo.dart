class ToDo{
      int? id;
      String? title;
      String? description;

      todoMap() {
            var mapping = Map<String, dynamic>();
            mapping['id'] = id ?? null;
            mapping['title'] = title!;
            mapping['description'] = description!;
            return mapping;
      }
}