import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var database: CBLDatabase?
    var peerConnect: PeerConnect?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        let manager = CBLManager.sharedInstance()
        var error: NSError?
        self.database = manager.databaseNamed("tasks", error: &error)
        if self.database == nil {
            //TODO Show error dialog
        }
        
        self.peerConnect = PeerConnect(credentials: nil, accept: { (completion) -> Void in
            completion(true)
        }, found: { (data) -> Void in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        })
        
        self.peerConnect?.findSync()
        
        return true
    }

}