
import Foundation
import Combine

class ReviewEditViewModel: ObservableObject {
    @Published var comment: String = ""
    @Published var loading: Bool = false
    @Published var offReview = false
    
    var reviewEditCancellable: AnyCancellable?
    var cancellable: AnyCancellable?
    
    func offReviewView() {
        offReview = true
    }
    
    func stop() {
        reviewEditCancellable?.cancel()
    }
    
    init() {}
}

extension ReviewEditViewModel {
    func ReviewEdit(movieId: String?, idx: Int?, rating: Int) {
        loading = true
        if let movieId = movieId, let idx = idx {
            reviewEditCancellable = MovieDB.editReview(idx: idx, movieId: movieId, comment: comment, ratingNum: rating)
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
                    
                    DispatchQueue.main.async {
                        self?.loading = false
                    }
                    
                }, receiveValue: {
                    print("review Write value: \($0)")
                })
        }
        
    }
}
