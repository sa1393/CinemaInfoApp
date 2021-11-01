
import Foundation
import Combine

class ReviewWriteViewModel: ObservableObject {
    @Published var comment: String = ""
    
    @Published var loding: Bool = false
    
    @Published var offReview = false
    var cancellable: AnyCancellable?

    func offReviewView() {
        offReview = true
    }
    
    init() {
        
    }
    
}

extension ReviewWriteViewModel {
    func ReviewWrite(movieId: String?, rating: Int) {
        self.loding = true
        
        if let movieId = movieId {
            MovieDB.writeReview(movieId: movieId, comment: comment, ratingNum: rating)
                .mapError{ (error) -> Error in
                    
                    return error
                }
                .sink(receiveCompletion: { [weak self] result in
                    switch result {
                    case .finished :
                        print("ReviewWrite Finished")
                    case .failure(let error) :
                        print("ReviewWrite Error: \(error)")
                    }
                    self?.loding = false
                    self?.offReviewView()
                    
                }, receiveValue: {
                    print("review Write value: \($0)")
                })
        }
        
    }
}
