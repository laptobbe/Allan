import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var database: CBLDatabase?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        let manager = CBLManager.sharedInstance()
        var error: NSError?
        self.database = manager.databaseNamed("tasks", error: &error)
        if self.database == nil {
            //TODO Show error dialog
        }
        return true
    }

}