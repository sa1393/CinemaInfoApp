import Foundation
import Combine

enum MovieDB {
    static let apiClient = APIClinet()
    static let baseURL = SecretText.baseURL
    
}

extension MovieDB {
    static func getRequest<T : Codable>(_ path: String, endPoint: String, type: T) -> AnyPublisher<T, Error> {
        let urlStr = "\(baseURL)\(path)\(endPoint)"
        var resultURL: URL?
        if let encodedStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            resultURL = URL(string: encodedStr)!
        }
        else {
            resultURL = nil
        }
   
        var request = URLRequest(url: resultURL ?? URL(string: "")!)
        request.httpMethod = "GET"
    
        return apiClient.loadData(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }

    static func login() -> AnyPublisher<UserResponse, Error>{
        let url = URL(string: "\(baseURL)auth/local")

        var request = URLRequest(url: url ?? URL(string: "")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let firstUser = LoginUser(id: "testerff", pwd: "1234")

        guard let httpBody = try? JSONEncoder().encode(firstUser) else {
            fatalError("no url")
        }

        request.httpBody = httpBody

        return apiClient.loadData(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func loginCheck() -> AnyPublisher<UserResponse, Error>{
        let url = URL(string: "\(baseURL)")

        var request = URLRequest(url: url ?? URL(string: "")!)
        request.httpMethod = "GET"

        return apiClient.loadData(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    
    static func writeReview() {
        
    }
    
    static func editReview() {
        
    }
    
    static func deleteReview() {
        
    }
    
}
