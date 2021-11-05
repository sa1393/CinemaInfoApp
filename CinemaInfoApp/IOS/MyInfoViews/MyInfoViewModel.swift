import Foundation

class MyInfoViewModel: ObservableObject {
    @Published var loading: Bool = false
    @Published var user: User?
    
    var baseViewModel: BaseViewModel?
    
    init() {
        
    }
    
    func setting(baseViewModel: BaseViewModel) {
        self.baseViewModel = baseViewModel
    }
}

extension MyInfoViewModel {
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
                print(value)
                self?.user = value.result
                
                print(self?.user)
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
                        self?.baseViewModel?.isLogin = false
                        self?.baseViewModel?.autoLogin = false
                        self?.baseViewModel?.user = nil
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




