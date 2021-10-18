import Foundation

class BaseViewModel: ObservableObject {
    @Published var selected: Tab = .home
    @Published var launchAfter = true // test
    
    @Published var showTabbar = true
    @Published var isLogin = false
    
    
//
//    @Published var afterLaunch: Bool {
//        get {
//            return UserDefaults.standard.bool(forKey: "afterLaunch")
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: "afterLaunch")
//        }
//    }
    
    init() {
//        launchAfter = UserDefaults.standard.bool(forKey: "LaunchAfter")
        launchAfter = false
        print(launchAfter)
    }
}

enum Tab: String {
    case home = "홈"
    case search = "검색"
    case more = "설정"
}
