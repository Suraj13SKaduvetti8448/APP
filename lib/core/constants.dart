class AppConst {
  static const appName = 'FurniTracker';

  // Roles
  static const roleBusiness = 'business';
  static const roleClient = 'client';
  static const roleDesigner = 'designer';

  // Validation
  static final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  //static final nameRegex = RegExp(r'^[A-Za-z][A-Za-z\s\.\'-]{1,49}$');
  static final RegExp nameRegex = RegExp(r"^[A-Za-z][A-Za-z\s.'-]{1,49}$");
  static final phoneRegex = RegExp(r'^\+?[0-9\s\-()]+$');
  static const minPasswordLen = 8;

  // UI
  static const gridBreakpoint = 800.0;
  static const mockAvatar =
  'https://images.unsplash.com/photo-1601933470928-c1a5c4a2e7b9?w=300&q=60';
  static const mockProduct =
  'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800&q=60';
}

