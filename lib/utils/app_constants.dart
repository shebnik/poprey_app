// ignore_for_file: constant_identifier_names

enum Plans {
  Likes,
  Followers,
  AutoLikesPosts,
  AutoLikesSubs,
  Views,
  Comments,
  // PageLikes,
  // PlaylistFollowers,
  // GroupFollowers,
  // PostLikes
}

enum Types {
  Instant,
  Gradual,
  Normal,
  Premium,
  Random,
  Custom,
}

class AppConstants {
  static const InstagramPlansAPI = 'https://core.poprey.com/api/get_plans.php';
  static const AdditionalServicesAPI =
      'https://core.poprey.com/api/additional_services.php';

  static const appName = 'Poprey';

  static const SFProDisplay = 'SFProDisplay';
  static const SFProText = 'SFProText';

  static const Instagram = 'Instagram';
  static const OtherSM = 'Other SM';

  static const All = 'All';
  static const YouTube = 'YouTube';
  static const TikTok = 'TikTok';
  static const Facebook = 'Facebook';
  static const Spotify = 'Spotify';
  static const Twitter = 'Twitter';
  static const VK = 'VK';

  static const INSTAGRAM_MODEL = 'INSTAGRAM_MODEL';
  static const ADDITIONAL_PLANS_MODEL = 'ADDITIONAL_PLANS_MODEL';
  static const INSTAGRAM_PROFILES = 'INSTAGRAM_PROFILES';
  static const USER_EMAIL = 'USER_EMAIL';

  static const email = 'Email';

  static const instagramPostUrl = 'https://www.instagram.com/p/';

  static const Map<String, List<String>> TypesDescription = {
    'Instant': [
      'instant start',
      'instant delivery',
      'permanent',
      'real looking'
    ],
    'Gradual': [
      'instant start',
      'gradual delivery',
      'permanent',
      'real looking'
    ],
    'Normal': [
      'start in 12h',
      'gradual delivery',
      'no guarantee',
      'real looking'
    ],
    'Premium': [
      'instant start',
      'gradual delivery',
      '30d warranty',
      'real looking'
    ],
    'Random': [
      'instant start',
      'instant delivery',
      'permanent',
      'real looking'
    ],
    'Custom': [
      'instant start',
      'gradual delivery',
      'permanent',
      'real looking'
    ],
  };
}
