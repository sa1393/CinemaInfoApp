import Foundation
import Combine
import SwiftUI

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
            print("autoLoginSet \(autoLogin)")
            
        }
    }
    @Published var loading: Bool = false
    @Published var launching: Bool = true

    //false = firstLaunch
    @Published var afterLaunch: Bool
    
    init() {
        afterLaunch = UserDefaults.standard.bool(forKey: "LaunchAfter")
        autoLogin = UserDefaults.standard.bool(forKey: "AutoLogin")
        
        if afterLaunch {
            
        }
        
        if autoLogin {
            print("autoSignStart")
            autoSignIn()

        }
        else {
            
            withAnimation {
                launching = false
            }
        }
    
    }
}

extension BaseViewModel {
    func autoSignIn() {
        if let user = readLoginData() {
            print(user)
            if let id = user.id, let pwd = user.pwd {
                print("id: \(id)")
                print("pwd: \(pwd)")
                MovieDB.signin(id: id, pwd: pwd)
                    .mapError({ (error) -> Error in
                        return error
                    })
                    .sink(receiveCompletion: { [weak self] result in
                        switch result {
                        case .finished :
                            print("Auto SignIn Finished")
                            self?.getUser()
                            
                            DispatchQueue.main.async {
                                self?.isLogin = true
                            }
                            
                        case .failure(let error) :
                            print("Auto SignIn error \(error)")
                            
                            DispatchQueue.main.async {
                                withAnimation {
                                    self?.launching = false
                                }
                            }
                            
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
                    
                    DispatchQueue.main.async {
                        withAnimation {
                            self.launching = false
                        }
                    }
                    
                case .failure(let error) :
                    print("LoginCheck Error : \(error)")
                }
                
                
            }, receiveValue: { [weak self] value in
                self?.user = value.result
            })
    }
    
    func SignOut() {
        loading = true
        MovieDB.signout()
            .mapError({ (error) -> Error in
                return error
            })
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished :
                    DispatchQueue.main.async {
                        self?.isLogin = false
                        self?.autoLogin = false
                        self?.user = nil
                    }
                    
                    print("SignOut Finished")
                case .failure(let error) :
                    print("SignOut Error: \(error)")
                }
                
                DispatchQueue.main.async {
                    self?.loading = false
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

enum Tab {
    case home
    case search
    case my
}
