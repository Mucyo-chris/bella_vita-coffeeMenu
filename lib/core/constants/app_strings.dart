/// Centralised string constants — easy to localise later.
abstract final class AppStrings {
  // ── App ───────────────────────────────────────────────────
  static const String appName        = 'Bella Vita';
  static const String appTagline     = 'Your daily coffee ritual';

  // ── Auth ──────────────────────────────────────────────────
  static const String signIn         = 'Sign In';
  static const String signUp         = 'Sign Up';
  static const String logOut         = 'Log Out';
  static const String emailPhone     = 'Email or phone';
  static const String email          = 'Email';
  static const String username       = 'Username';
  static const String password       = 'Password';
  static const String confirmPassword = 'Confirm password';
  static const String createAccount  = 'Create Account';
  static const String alreadyAccount = 'Already have an account?';
  static const String noAccount      = "Don't have an account?";
  static const String continueGoogle = 'Continue with Google';
  static const String guestMode      = 'Use Guest mode to sign in';
  static const String learnMore      = 'Learn more';
  static const String next           = 'Next';

  // ── Home ──────────────────────────────────────────────────
  static const String goodMorning    = 'Good Morning';
  static const String searchHint     = 'Search coffee...';
  static const String categoryAll    = 'ALL';
  static const String categoryEspresso   = 'Espresso';
  static const String categoryCappuccino = 'Cappuccino';
  static const String categoryAmericano  = 'Americano';

  // ── Navigation ────────────────────────────────────────────
  static const String home           = 'Home';
  static const String likes          = 'Likes';
  static const String shop           = 'Shop';
  static const String profile        = 'Profile';
  static const String notification   = 'Notification';
  static const String darkMode       = 'Dark Mode';
  static const String myCart         = 'My Cart';
  static const String payment        = 'Payment';
  static const String settings       = 'Settings';
  static const String help           = 'Help';

  // ── Notifications ─────────────────────────────────────────
  static const String readNotifications     = 'Read App Notifications';
  static const String notifSubtitle         =
      'Find All Notifications of Selected App at one place.\n'
      'Never miss any important notification.';
  static const String continueBtn           = 'Continue';
  static const String markAllRead           = 'Mark all read';
  static const String noNotifications       = 'No notifications yet';

  // ── Cart ──────────────────────────────────────────────────
  static const String emptyCart      = 'Your cart is empty';
  static const String total          = 'Total';
  static const String checkout       = 'Checkout';
  static const String addedToCart    = 'Added to cart';

  // ── Errors ────────────────────────────────────────────────
  static const String requiredField    = 'This field is required';
  static const String invalidEmail     = 'Enter a valid email address';
  static const String passwordMinLen   = 'Password must be at least 6 characters';
  static const String passwordMismatch = 'Passwords do not match';
  static const String genericError     = 'Something went wrong. Please try again.';
}
