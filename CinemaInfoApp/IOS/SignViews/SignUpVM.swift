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
    @Published var offSign = false
    @Published var showingFailAlert: Bool = false
    
    var defaultImageData = UIImage(systemName: "person.fill")?.pngData()
    
    var signUpCancellationToken: AnyCancellable?
    var cancellable: AnyCancellable?
    
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
    
    init() {}
}

extension SignUpViewModel {
    func SignUp(profile: UIImage?) {
        loading = true
        if !checkField() {
            loading = false
            return
        }

        signUpCancellationToken = MovieDB.signUp(id: id.text, name: name.text, pwd: pwd.text, profile: profile ?? UIImage(systemName: "person.fill")!)
            .mapError( { (error) -> Error in
                return error
            })
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished :
                    print("SignUp Finished")
                    
                    DispatchQueue.main.async {
                        self?.offSign = true
                    }
                    
                case .failure(let error) :
                    
                    DispatchQueue.main.async {
                        self?.showingFailAlert = true
                    }
                    
                    print("SignUp Error: \(error)")
                }
                
                DispatchQueue.main.async {
                    self?.loading = false
                }

            }, receiveValue: { _ in
                
            })
    }
}
