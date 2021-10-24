import Foundation

class LoginViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var pwd: String = ""
    
    init() {
    }
}

extension LoginViewModel {
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
}
