import Foundation

class TutorialViewModel: ObservableObject {
    @Published var idString: String = ""
    @Published var pwString: String = ""
    
    init() {
        
    }
}

extension TutorialViewModel {
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
