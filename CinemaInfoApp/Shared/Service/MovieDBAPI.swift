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
    
}
