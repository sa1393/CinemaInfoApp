
import Foundation
import Combine

class ReviewEditViewModel: ObservableObject {
    @Published var comment: String = ""
    
    @Published var offReview = false
    var cancellable: AnyCancellable?
    
    @Published var loading: Bool = false

    func offReviewView() {
        offReview = true
    }
    
    init() {
        
    }
}

extension ReviewEditViewModel {
    func ReviewEdit(movieId: String?, idx: Int?, rating: Int) {
        loading = true
        if let movieId = movieId, let idx = idx {
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
                    
                    self?.loading = false
                }, receiveValue: {
                    print("review Write value: \($0)")
                })
        }
        
    }
}
