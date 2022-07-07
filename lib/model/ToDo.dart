class ToDo{
      int? id;
      int? isChecked;
      String? title;
      String? description;

      todoMap() {
            var mapping = Map<String, dynamic>();
            mapping['id'] = id ?? null;
            mapping['isChecked'] = isChecked!;
            mapping['title'] = title!;
            mapping['description'] = description!;
            return mapping;
      }
}