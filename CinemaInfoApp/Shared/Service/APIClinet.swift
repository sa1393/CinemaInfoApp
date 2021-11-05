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
    
    func loadData<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
                    .dataTaskPublisher(for: request)
                    .subscribe(on:  DispatchQueue.global(qos: .background))
                    .tryMap { result -> Response<T> in
                        let value = try JSONDecoder().decode(T.self, from: result.data)
                        return Response(value: value, response: result.response)
                    }
                    .receive(on: DispatchQueue.global(qos: .background))
                    .eraseToAnyPublisher()
    }

}
