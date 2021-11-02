import Foundation
import SwiftUI

class UserEditViewModel: ObservableObject {
    @Published var pwd: SignField = SignField(text: "", isError: false, errorMsg: "")
    @Published var tab: EditTab = .passwordCheck
    @Published var pwdCheckAlert = false
    @Published var pwdCHeckErrorAlert = false
    
    //userEdit
    @Published var editPwd: SignField = SignField(text: "", isError: false, errorMsg: "")
    
    var loading: Bool = false

    init() {
    }
    
    func checkField() -> Bool{
        var result = true
        if pwd.text.isEmpty {
            pwd.isError = true
            pwd.errorMsg = "비밀번호를 입력하세요."
            result = false
        }

        return result
    }
    
    func checkEditField() -> Bool {
        var result = true
        if editPwd.text.isEmpty {
            editPwd.isError = true
            editPwd.errorMsg = "비밀번호를 입력하세요."
            result = false
        }
        
        return result
    }

}

extension UserEditViewModel {
    func passwordCheck() {
        loading = true
        
        if !checkField() {
            loading = false
            return
        }
        
        MovieDB.loginCheck()
            .mapError({ (error) -> Error in
                return error
            })
            .sink(receiveCompletion: { result in
                switch result {
                case .finished :
                    print("PwCheck Finished")
                    
                case .failure(let error) :
                    print("PwCheck Error : \(error)")
                }
            }, receiveValue: { [weak self] value in
                if let userPwd = value.result?.pwd, let pwd = self?.pwd.text{
                    if userPwd == pwd {
                        
                        withAnimation(.easeIn.speed(0.6)) {
                            self?.tab = .passwordEdit
                        }
                    }
                    else {
                        self?.pwdCheckAlert = true
                    }
                }
            })
    }
    
    func userEdit() {
        loading = true
        
        loading = false
    }
    
}
