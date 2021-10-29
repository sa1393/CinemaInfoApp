
import Foundation
import Combine

class ReviewEditViewModel: ObservableObject {
    @Published var comment: String = ""
    
    @Published var offReview = false
    var cancellable: AnyCancellable?

    func offReviewView() {
        offReview = true
    }
    
    init() {
        
    }
}

extension ReviewEditViewModel {
    func ReviewEdit(movieId: String, idx: Int, rating: Int) {
        MovieDB.editReview(idx: idx, movieId: movieId, comment: comment, ratingNum: rating)
            .mapError{ (error) -> Error in
                
                return error
            }
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished :
                    print("ReviewWrite Finished")
                    self?.offReviewView()
                case .failure(let error) :
                    print("ReviewWrite Error: \(error)")
                }
                
            }, receiveValue: {
                print("review Write value: \($0)")
            })
    }
}
