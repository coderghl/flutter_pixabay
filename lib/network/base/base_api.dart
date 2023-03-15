enum RequestMethod { get, post, put, delete, patch, copy }

class BaseApi {
  String serviceKey() => "";

  String path() => "";

  RequestMethod method() => RequestMethod.get;

}
