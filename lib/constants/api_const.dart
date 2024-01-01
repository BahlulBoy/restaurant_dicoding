class ApiConst {
  static String baseUrl = 'https://restaurant-api.dicoding.dev';
  static String list = '$baseUrl/list';
  static String detail(String id) => '$baseUrl/detail/$id';
  static String search(String search) => '$baseUrl/search?q=$search';
  static String mediumPic(String id) =>
      'https://restaurant-api.dicoding.dev/images/medium/$id';
  static String largePic(String id) =>
      'https://restaurant-api.dicoding.dev/images/large/$id';
}
