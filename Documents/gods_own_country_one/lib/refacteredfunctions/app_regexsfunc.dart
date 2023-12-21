import 'package:keralatraveller/refactoredwidgets/app_strings.dart';

String? validateName(String? name) {
  if (name == null || name.isEmpty) {
    return AppStrings.pleaseusername;
  }
  if (!RegExp(AppStrings.namereg).hasMatch(name)) {
    return AppStrings.feildisrequired;
  }
  return null;
}

String? validateLoginPassed(String? password) {
  if (password == null || password.isEmpty) {
    return AppStrings.requiredfeild;
  }

  return null;
}

String? validateEmailFromloninpage(String? email) {
  if (email == null || email.isEmpty) {
    return AppStrings.requiredfeild;
  }

  return null;
}


String? validateUsername(String? username) {
  if (username == null || username.isEmpty) {
    return 'field is required';
  }

  RegExp usernameRegex = RegExp(r"^\S[a-zA-Z\d]*(?: [a-zA-Z\d]+)?$");

  if (!usernameRegex.hasMatch(username)) {
    return 'username should contain only alphabets';
  }

  return null;
}


String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return "field is required";
  }
  RegExp emailRegex = RegExp(AppStrings.emailregx);
  if (!emailRegex.hasMatch(email)) {
    return AppStrings.pleasevalidemail;
  }
  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) {
    return "field is required";
  }
  if (!RegExp(AppStrings.passwordregx).hasMatch(password)) {
    return AppStrings.pleasepassword8char;
  }
  return null;
}

String? validatePlaceAddToHome(String? place) {
  if (place == null || place.isEmpty) {
    return 'field is required';
  }
  place = place.trim();
  RegExp placeregex = RegExp(AppStrings.placereg);
  if (!placeregex.hasMatch(place)) {
    return AppStrings.feildisrequired;
  }

  return null;
}

String? validateLocationAddToHome(String? location) {
  if (location == null || location.isEmpty) {
    return 'field is required';
  }
  location = location.trim();
  if (!RegExp(AppStrings.locationreg).hasMatch(location)) {
    return AppStrings.feildisrequired;
  }

  return null;
}

String? validateDetailsAddToHome(String? details) {
  if (details == null || details.isEmpty) {
    return 'field is required ';
  }

  details = details.trim();
  if (!RegExp(AppStrings.namereg).hasMatch(details)) {
    return AppStrings.feildisrequired;
  }

  return null;
}
