enum Mediums { email, wa, sms }

extension LongNames on Mediums {
  String get longName {
    String long = name;
    switch (this) {
      case Mediums.email:
        break;
      case Mediums.wa:
        long = "whatsapp";
        break;
      case Mediums.sms:
        long = "message";
        break;
    }
    return long;
  }
}
