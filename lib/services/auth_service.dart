import 'package:flutter_auth_base/flutter_auth_base.dart';
import 'package:ezsale/core/auth/services/firebase.dart';
import 'package:ezsale/core/imageProviders/gravatar_provider.dart';
import 'package:ezsale/core/imageProviders/user_photo_url_provider.dart';
import 'package:ezsale/core/imageProviders/combined_image_provider.dart';

AuthService createAuthService() {
  var authService = new FirebaseAuthService();

  var email = new FirebaseEmailProvider(service: authService);
  var google = new FirebaseGoogleProvider(service: authService);
  var facebook = new FirebaseGoogleProvider(service: authService);

  authService.authProviders.addAll([email, google, facebook]);
  authService.linkProviders.addAll([email, google, facebook]);
  authService.preAuthPhotoProvider = new GravatarProvider();
  authService.postAuthPhotoProvider = new CombinedPhotoProvider()
    ..add(new AuthUserImageProvider(service: authService))
    ..add(new GravatarProvider(missingImageType: ImageType.MysteryMan));

  return authService;
}
