import Foundation

extension UserDefaults {
    
    static func isFirstLaunch() -> Bool {
        let isFirstLaunchKey = "isFirstLaunch"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: isFirstLaunchKey)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: isFirstLaunchKey)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}
