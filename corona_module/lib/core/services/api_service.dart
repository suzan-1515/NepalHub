class ApiService {
  List<Map<String, dynamic>> flattenTimelineMap(Map<String, dynamic> map) {
    List<Map<String, dynamic>> list = [];
    map.forEach((k, v) {
      list.add({
        'date': k,
        ...v,
      });
    });
    return list;
  }
}
