import Foundation
import Combine
import PhotosUI
import SwiftUI

struct SignField {
    var text: String
    var isError: Bool
    var errorMsg: String
}

class SignUpViewModel: ObservableObject {
    @Published var id: SignField = SignField(text: "", isError: false, errorMsg: "")
    @Published var name: SignField = SignField(text: "", isError: false, errorMsg: "")
    @Published var pwd: SignField = SignField(text: "", isError: false, errorMsg: "")
    
    @Published var loading: Bool = false
    
    var defaultImageData = UIImage(systemName: "person.fill")?.pngData()
    
    var signUpCancellationToken: AnyCancellable?
    
    @Published var offSign = false
    var cancellable: AnyCancellable?
    
    @Published var showingFailAlert: Bool = false

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
        if name.text.isEmpty {
            name.isError = true
            name.errorMsg = "이름을 입력하세요."
            result = false
        }
        if pwd.text.isEmpty {
            pwd.isError = true
            pwd.errorMsg = "비밀번호를 입력하세요."
            result = false
        }

        return result
    }
    
    init() {
        
    }
}

extension SignUpViewModel {
    func SignUp(profile: UIImage?) {
        loading = true
        if !checkField() {
            loading = false
            return
        }
        
        print("signUP Start")
        print("------------------------------------------------------------------")
        signUpCancellationToken = MovieDB.SignUp(id: id.text, name: name.text, pwd: pwd.text, profile: profile ?? UIImage(systemName: "person.fill")!)
            .mapError( { (error) -> Error in
                return error
            })
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished :
                    print("SignUp Finished")
                    
                    self?.offSignView()
                case .failure(let error) :
                    self?.showingFailAlert = true
                    print("SignUp Error: \(error)")
                }

                self?.loading = false
            }, receiveValue: { _ in
                
            })
    }
}
