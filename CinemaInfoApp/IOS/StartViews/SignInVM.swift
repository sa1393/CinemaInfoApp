import Foundation
import Combine

class SigninViewModel: ObservableObject {
    @Published var id: SignField = SignField(text: "", isError: false, errorMsg: "")
    @Published var pwd: SignField = SignField(text: "", isError: false, errorMsg: "")
    
    @Published var loading: Bool = false
    @Published var showingFailAlert: Bool = false
    var baseViewModel: BaseViewModel?
    
    @Published var offSign = false
    var cancellable: AnyCancellable?

    func offSignView() {
        offSign = true
    }
    
    func checkField() -> Bool{
        var result = true
        if id.text.isEmpty {
            id.isError = true
            id.errorMsg = "id를 입력하세요."
            result = false
        }

        if pwd.text.isEmpty {
            pwd.isError = true
            pwd.errorMsg = "비밀번호를 입력하세요."
            result = false
        }
        
        return result
    }
    
    func initField() {
        id.isError = false
        pwd.isError = false
    }

    init() {
        
    }
    
    func setUp(_ baseViewModel: BaseViewModel) {
        self.baseViewModel = baseViewModel
    }
}

extension SigninViewModel {
    func CheckLogin() {
        MovieDB.loginCheck()
            .mapError({ (error) -> Error in
                print("error \(error)")
                return error
            })
            .sink(receiveCompletion: {
                print("tuResult: \($0)")
            }, receiveValue: {
                print("tuValue: \($0)")
            })
    }
    
    func SignIn() {
        loading = true
        initField()
        if !checkField() {
            loading = false
            return
        }
        MovieDB.SignIn(id: id.text, pwd: pwd.text)
            .mapError({ (error) -> Error in
                return error
            })
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    print("SignIn Finished")
                    
                    DispatchQueue.main.async {
                        self?.offSignView()
                        self?.baseViewModel?.isLogin = true
                    }
                    
                    break
                case .failure(let error):
                    self?.showingFailAlert = true
                    
                    print("SignIn error: \(error)")
                }
                
                DispatchQueue.main.async {
                    self?.loading = false
                }
                
            }, receiveValue: { [weak self] value in
                print("SignIn Value: \(value)")
            })
    }
}
