class ApiRoutes {
  static const signIn = '/api/v1/authentication/sign-in';
  static const signUp = '/api/v1/authentication/sign-up';

  static String userById(String id) => '/api/v1/users/$id';

  static const professionals = '/api/v1/professionals';
  static String professionalById(String id) => '/api/v1/professionals/$id';
}
