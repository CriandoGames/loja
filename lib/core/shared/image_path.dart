class ImagePath {
  static final ImagePath _singleton = ImagePath._internal();

  factory ImagePath() => _singleton;

  ImagePath._internal();

  static String homeEmptyImage() {
    return 'assets/images/empty.png';
  }

  static String wrongImage() {
    return 'assets/images/wrong.png';
  }
}
