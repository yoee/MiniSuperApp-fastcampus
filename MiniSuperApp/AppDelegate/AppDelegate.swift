import UIKit
import ModernRIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  private var launchRouter: LaunchRouting?
  private var urlHandler: URLHandler?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    self.window = window
    
    let result = AppRootBuilder(dependency: AppComponent()).build()
    self.launchRouter = result.launchRouter
    self.urlHandler = result.urlHandler
    launchRouter?.launch(from: window) // 앱의 맨 처음 리블렛에만 사용한다.
    // 얘가 interactor의 didBecomeActive를 호출
    
    return true
  }
  
}

protocol URLHandler: AnyObject {
  func handle(_ url: URL)
}
