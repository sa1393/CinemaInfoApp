import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var name: String = ""
    @Published var pwd: String = ""
    @Published var pwdCheck: String = ""
    @Published var profile: String = ""
    
    var signUpCancellationToken: AnyCancellable?
    
    init() {
    }
}

extension SignUpViewModel {
    func SignUp() {
        signUpCancellationToken = MovieDB.SignUp(id: id, name: name, pwd: pwd, profileURL: profile)
            .mapError( { (error) -> Error in
                
                print("SignUp Error: \(error)")
                return error
            })
            .sink(receiveCompletion: {
                print("SignUp Result: \($0)")
            }, receiveValue: {
                print("SignUp Value: \($0)")
            })
    }
}
