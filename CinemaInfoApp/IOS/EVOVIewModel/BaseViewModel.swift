import Foundation
import Combine

class BaseViewModel: ObservableObject {
    @Published var selected: Tab = .home
    @Published var launchAfter = true // test

    @Published var isLogin = false{
        
        didSet {
            if isLogin {
                getUser()
            }
        }
    }
    @Published var user: User?
    
    @Published var autoLogin = false
    
    let didChange = PassthroughSubject<BaseViewModel,Never>()

    
//    @Published var afterLaunch: Bool {
//        get {
//            return UserDefaults.standard.bool(forKey: "afterLaunch")
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: "afterLaunch")
//        }
//    }
    
    init() {
        launchAfter = UserDefaults.standard.bool(forKey: "LaunchAfter")
        launchAfter = false
        print(launchAfter)
        
    }
}

//test
extension BaseViewModel {
    
    func TestSignIn() {
        MovieDB.SignIn(id: "test", pwd: "1234")
            .mapError({ (error) -> Error in
                print("SignIn error \(error)")
                return error
            })
            .sink(receiveCompletion: {
                print("SignIn Result: \($0)")
            }, receiveValue: {
                print("SignIn Value: \($0)")
            })
    }
    
}

extension BaseViewModel {
    func getUser() {
        MovieDB.loginCheck()
            .mapError({ (error) -> Error in
                print("LoginCheck error: \(error)")
                return error
            })
            .sink(receiveCompletion: { result in
                
            }, receiveValue: { [weak self] value in
                
                self?.user = value.result
            })
    }
    
    func SignOut() {
        MovieDB.SignOut()
            .mapError({ (error) -> Error in
                print("signOut error: \(error)")
                return error
            })
            .sink(receiveCompletion: { [weak self] result in
                self?.isLogin = false
                print("signOut result: \(result)")
            }, receiveValue: {
                print("signOut value: \($0)")
            })
    }
}

enum Tab: String {
    case home = "홈"
    case search = "검색"
    case my = "내 정보"
}
