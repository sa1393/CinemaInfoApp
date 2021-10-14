import Foundation

class BaseViewModel: ObservableObject {
    @Published var selected: Tab = .home
    @Published var launchAfter = true
    
    init() {
        launchAfter = UserDefaults.standard.bool(forKey: "LaunchAfter")
        print(launchAfter)
    }
}

enum Tab: String {
    case home = "홈"
    case search = "검색"
    case more = "설정"
}
