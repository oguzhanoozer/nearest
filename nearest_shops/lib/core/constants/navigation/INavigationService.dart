abstract class INavigationService {
  Future<void> navigateToPage({ String? path,required Object? data});
  Future<void> navigateToPageClear({ String? path,required Object? data});
}
