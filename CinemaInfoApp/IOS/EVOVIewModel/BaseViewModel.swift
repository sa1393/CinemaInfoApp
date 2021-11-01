import Foundation
import Combine

class BaseViewModel: ObservableObject {
    @Published var selected: Tab = .home

    @Published var isLogin = false{
        
        didSet {
            if isLogin {
                getUser()
            }
        }
    }
    @Published var user: User?
    
    @Published var autoLogin = false {
        didSet {
            UserDefaults.standard.set(autoLogin, forKey: "AutoLogin")
            print(autoLogin)
            
        }
    }
    
    let didChange = PassthroughSubject<BaseViewModel,Never>()

    //false = firstLaunch
    @Published var afterLaunch: Bool
    
    init() {
        afterLaunch = UserDefaults.standard.bool(forKey: "LaunchAfter")
        autoLogin = UserDefaults.standard.bool(forKey: "AutoLogin")
        
        if afterLaunch {
            
        }
        
        if autoLogin {
            autoSignIn()

        }
    }
}

//test
extension BaseViewModel {
    
    func autoSignIn() {
        if let user = readLoginData() {
            print(user)
            if let id = user.id, let pwd = user.pwd {
                print("id: \(id)")
                print("pwd: \(pwd)")
                MovieDB.SignIn(id: id, pwd: pwd)
                    .mapError({ (error) -> Error in
                        return error
                    })
                    .sink(receiveCompletion: { [weak self] result in
                        switch result {
                        case .finished :
                            self?.isLogin = true
                            print("Auto SignIn Finished")
                        case .failure(let error) :
                            print("Auto SignIn error \(error)")
                        }
                    }, receiveValue: {
                        print("Auto SignIn Value: \($0)")
                    })
            }
            
        }
        
    }
}

extension BaseViewModel {
    func getUser() {
        MovieDB.loginCheck()
            .mapError({ (error) -> Error in
                
                return error
            })
            .sink(receiveCompletion: { result in
                switch result {
                case .finished :
                    print("LoginCheck Finished")
                case .failure(let error) :
                    print("LoginCheck Error : \(error)")
                }
            }, receiveValue: { [weak self] value in
                self?.user = value.result
            })
    }
    
    func SignOut() {
        MovieDB.SignOut()
            .mapError({ (error) -> Error in
                return error
            })
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished :
                    self?.isLogin = false
                    self?.autoLogin = false
                    deleteLoginDate()
                    print("SignOut Finished")
                case .failure(let error) :
                    print("SignOut Error: \(error)")
                }
            }, receiveValue: {
                print("SignOut value: \($0)")
            })
    }
}

func readLoginData() -> SignUser?{
    KeyChainHelper.standard.read(service: loginService, account: loginAccount, type: SignUser.self)
}

func deleteLoginDate() {
    KeyChainHelper.standard.delete(service: loginService, account: loginAccount)
}

enum Tab: String {
    case home = "홈"
    case search = "검색"
    case my = "내 정보"
}
