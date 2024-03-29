part of 'urls_and_socials_extensions.dart';

class GooglePlusUrl {
  final GooglePlusIdUrl? idUrl;
  final GooglePlusUserNameUrl? userNameUrl;
  String? get username => userNameUrl?.username;
  String? get id => idUrl?.id;
  GooglePlusUrl._(this.idUrl, this.userNameUrl);
  static GooglePlusUrl? parse(String url) {
    var userName = GooglePlusUserNameUrl.parse(url);
    var id = GooglePlusIdUrl.parse(url);
    if (userName == null && id == null) return null;
    return GooglePlusUrl._(id, userName);
  }
}

class GooglePlusIdUrl {
  final String id;

  GooglePlusIdUrl._(this.id);
  static GooglePlusIdUrl? parse(String url) {
    var matches = RegExp(r'(?:https?:)?\/\/plus\.google\.com\/(?<id>[0-9]{21})')
        .allMatches(url);
    var id = matches.getValue("id");
    if (id == null) return null;
    return GooglePlusIdUrl._(id);
  }
}

class GooglePlusUserNameUrl {
  final String username;

  GooglePlusUserNameUrl._(this.username);
  static GooglePlusUserNameUrl? parse(String url) {
    var matches =
        RegExp(r'(?:https?:)?\/\/plus\.google\.com\/\+(?<username>[A-z0-9+]+)')
            .allMatches(url);
    var username = matches.getValue("username");
    if (username == null) return null;
    return GooglePlusUserNameUrl._(username);
  }
}
