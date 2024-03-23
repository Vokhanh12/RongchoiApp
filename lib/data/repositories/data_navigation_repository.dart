import 'package:logging/logging.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';

class DataNavigationRepository extends NavigationRepository {
  /// Singleton object of `DataAuthenticationRepository`
  static final DataNavigationRepository _instance = DataNavigationRepository._internal();

  late Logger _logger;

  // Constructors
  DataNavigationRepository._internal() {
    _logger = Logger('DataSettingRepository');
  }

  factory DataNavigationRepository() => _instance;
  
  @override
  Future<void> goToHomePage() {
    // TODO: implement goToHomePage
    throw UnimplementedError();
  }
  
  @override
  Future<void> goToJobsPage() {
    // TODO: implement goToJobsPage
    throw UnimplementedError();
  }
  
  @override
  Future<void> goToLoginPage() {
    // TODO: implement goToLoginPage
    throw UnimplementedError();
  }
  
  @override
  Future<void> goToMapPage() {
    // TODO: implement goToMapPage
    throw UnimplementedError();
  }
  
  @override
  Future<void> goToMediaSocialPage() {
    // TODO: implement goToMediaSocialPage
    throw UnimplementedError();
  }
  
  @override
  Future<void> goToRegisterPage() {
    // TODO: implement goToRegisterPage
    throw UnimplementedError();
  }
  
  @override
  Future<void> goToSplashPage() {
    // TODO: implement goToSplashPage
    throw UnimplementedError();
  }

 
}
