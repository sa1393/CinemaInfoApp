import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case unownedError
    case decodingError
}

struct APIClinet {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func loadData<T: Decodable>(_ request: URLRequest, dispatch: DispatchQueue = DispatchQueue.main) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
                    .dataTaskPublisher(for: request)
                    .subscribe(on:  DispatchQueue.global(qos: .background))
                    .tryMap { result -> Response<T> in
                        let value = try JSONDecoder().decode(T.self, from: result.data)
                        return Response(value: value, response: result.response)
                    }
                    .receive(on: dispatch)
                    .eraseToAnyPublisher()
    }
    
    func signUpLoad(_ request: URLRequest, dispatch: DispatchQueue = DispatchQueue.main) -> AnyPublisher<Response<Bool>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .subscribe(on:  DispatchQueue.global(qos: .background))
            .tryMap { result -> Response<Bool> in
                return Response(value: true, response: result.response)
            }
            .receive(on: dispatch)
            .eraseToAnyPublisher()
    }
}
