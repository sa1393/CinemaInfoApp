import Foundation
import Combine
import PhotosUI

enum MovieDB {
    static let apiClient = APIClinet()
    static let baseURL = SecretText.baseURL
}

extension MovieDB {
    static func getRequest<T : Codable>(_ path: String, endPoint: String, size: String = "", type: T) -> AnyPublisher<T, Error> {
        var urlStr = "\(baseURL)\(path)\(endPoint)"
        if !size.isEmpty {
            urlStr.append(contentsOf: size)
        }

        
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

//login
extension MovieDB {
    static func SignIn(id: String, pwd: String) -> AnyPublisher<UserResponse, Error>{
        let url = URL(string: "\(baseURL)auth/local")
        
        var request = URLRequest(url: url ?? URL(string: "")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let user = LoginUser(id: id, pwd: pwd)
        
        guard let httpBody = try? JSONEncoder().encode(user) else {
            fatalError("no url")
        }
        
        request.httpBody = httpBody
        
        return apiClient.loadData(request, dispatch: DispatchQueue.global(qos: .utility))
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func SignOut() -> AnyPublisher<ResultStringResponse, Error>{
        let url = URL(string: "\(baseURL)auth/logout")
        
        var request = URLRequest(url: url ?? URL(string: "")!)
        request.httpMethod = "GET"
        
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
    
    static func SignUp(id: String, name: String, pwd: String, profile: UIImage) -> AnyPublisher<ResultBoolResponse, Error> {
        let url = URL(string: "\(baseURL)users/signup")
        let boundary = generateBoundary()
        
        var request = URLRequest(url: url ?? URL(string: "")!)
        
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: String] = [
            "id": id,
            "name" : name,
            "pwd" : pwd,
        ]
        
        guard let imageData = ImageData(withImage: profile, forKey: "img") else {fatalError()}

        var httpBody = Data()
        httpBody = appendBody(parameters: parameters, boundary: boundary, imageData: imageData, body: httpBody)
        request.httpBody = httpBody
        
        print("httpBody: \(String(data: httpBody, encoding: .utf8))")
        
        return apiClient.loadData(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

//review
extension MovieDB {
    static func myReview() -> AnyPublisher<MyReviewResponse, Error>  {
        let resultURL = URL(string:"\(baseURL)users/review")
        
        var request = URLRequest(url: resultURL ?? URL(string: "")!)
        request.httpMethod = "GET"
        
        return apiClient.loadData(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func myMovieReview(movieTitle: String) -> AnyPublisher<MovieResponse, Error>  {
        
        let urlStr = "\(baseURL)users/search/beta?title=\(movieTitle)"

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
    
    static func writeReview(movieId: String, comment: String, ratingNum: Int) -> AnyPublisher<ResultBoolResponse, Error>  {
        let url = URL(string: "\(baseURL)movies/review/write")
        let boundary = generateBoundary()
        
        var request = URLRequest(url: url ?? URL(string: "")!)
        
        
        request.httpMethod = "PUT"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: String] = [
            "movie_id": movieId,
            "comment" : comment,
            "rating_num" : String(ratingNum)
        ]
        
        var httpBody = Data()
        httpBody = appendBody(parameters: parameters, boundary: boundary, body: httpBody)
        request.httpBody = httpBody
        print("httpBody: \(String(data: httpBody, encoding: .utf8))")
        
        return apiClient.loadData(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func editReview(idx: Int, movieId: String, comment: String, ratingNum: Int) -> AnyPublisher<UserResponse, Error> {
        let url = URL(string: "\(baseURL)movies/review/edit")
        
        let boundary = generateBoundary()
        
        var request = URLRequest(url: url ?? URL(string: "")!)
        
        
        request.httpMethod = "PUT"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: String] = [
            "idx": String(idx),
            "movie_id" : movieId,
            "comment" : comment,
            "rating_num" : String(ratingNum)
        ]
        
        var httpBody = Data()
        httpBody = appendBody(parameters: parameters, boundary: boundary, body: httpBody)
        request.httpBody = httpBody
        
        return apiClient.loadData(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func deleteReview(idx: Int, movieId: String) -> AnyPublisher<ResultBoolResponse, Error> {
        let url = URL(string: "\(baseURL)movies/review/delete")
        
        let boundary = generateBoundary()
        
        var request = URLRequest(url: url ?? URL(string: "")!)
        
        request.httpMethod = "PUT"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: String] = [
            "idx": String(idx),
            "movie_id" : movieId
        ]
        
        var httpBody = Data()
        httpBody = appendBody(parameters: parameters, boundary: boundary, body: httpBody)
        request.httpBody = httpBody
        
        return apiClient.loadData(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

// help
extension MovieDB {
    static func generateBoundary() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    static func appendBody(parameters: [String: String], boundary: String, imageData: ImageData? = nil, body: Data) -> Data {
        var body = body
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        if let imageData = imageData {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(imageData.key)\"; filename=\"\(imageData.filename)\r\n".data(using: .utf8)!)
            body.append("Content-Type: \(imageData.mimeType)\r\n\r\n".data(using: .utf8)!)
            body.append(imageData.data)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body as Data
    }
}
