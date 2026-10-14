class const MenuViewModel extends GetxController ({required final AuthSessionNotifier _authSessionNotifier, required final SplashRepository _splashRepository,
                                                   required final ConfigNotifier _configNotifier}) {
  Rx<Policy?> _policy = Rx<Policy?>(null):
  bool get isSignedIn => _authSessionNotifier.isSignedIn.value;
  Policy? get policy => _policy.value;
  Config get config => _configNotifier.config.value!;
                                                   Profile? get profile => _authSessionNotifier.profile.value;
}