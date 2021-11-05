import Foundation
import SwiftUI

struct Msg {
    var title: String
    var msg: String
}

class UserEditViewModel: ObservableObject {
    @Published var pwd: SignField = SignField(text: "", isError: false, errorMsg: "")
    @Published var tab: EditTab = .passwordCheck
    @Published var alert = false
    @Published var msg: Msg = Msg(title: "", msg: "")
    
    //userEdit
    @Published var editPwd: SignField = SignField(text: "", isError: false, errorMsg: "")
    @Published var loading: Bool = false
    
    var id: String = ""
    
    var baseViewModel: BaseViewModel?
    
    func setting(baseViewModel: BaseViewModel) {
        self.baseViewModel = baseViewModel
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
    
    init() {}
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
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished :
                    print("PwCheck Finished")
                    
                case .failure(let error) :
                    print("PwCheck Error : \(error)")
                    self?.alert = true
                    self?.msg = Msg(title: I18N.passwordCheck, msg: I18N.passwordCheckError)
                }
                
                self?.loading = false
            }, receiveValue: { [weak self] value in
                if let id = value.result?.id {
                    self?.id = id
                }
                
                if let userPwd = value.result?.pwd, let pwd = self?.pwd.text{
                    if userPwd == pwd {
                        withAnimation(.easeIn(duration: 0.3)) {
                            self?.tab = .passwordEdit
                        }
                    }
                    else {
                        self?.alert = true
                        self?.msg = Msg(title: I18N.passwordCheck, msg: I18N.passwordCheckFail)
                    }
                }
            })
    }
    
    func userEdit() {
        loading = true
        
        if !checkEditField() {
            loading = false
            return
        }
        MovieDB.userEdit(pwd: editPwd.text)
            .mapError({ (error) -> Error in
                return error
            })
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    print("UserEdit Finished")
                    if KeyChainHelper.standard.read(service: loginService, account: loginAccount) != nil {
                        KeyChainHelper.standard.update(item: SignUser(id: self?.id, pwd: self?.editPwd.text), service: loginService, account: loginAccount)
                    }
                    
                    DispatchQueue.main.async {
                        self?.alert = true
                        self?.msg = Msg(title: I18N.passwordEdit, msg: I18N.passwordEditSucces)
                    }
                    
                case .failure(let error):
                    print("UserEdit Error: \(error)")
                    
                    DispatchQueue.main.async {
                        self?.alert = true
                        self?.msg = Msg(title: I18N.passwordEdit, msg: I18N.passwordEditFail)
                    }
                }
                
                self?.loading = false
            }, receiveValue: { result in
                print(result)
            })
    }
    
}
