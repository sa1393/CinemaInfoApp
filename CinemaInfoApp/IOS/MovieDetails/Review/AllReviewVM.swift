import Foundation
import SwiftUI
import Combine

class AllReviewViewModel: ObservableObject {
    @Published var reviews: [Review] = []
    @Published var reviewLoading: Bool = false
    @Published var editMode: Bool = false
    
    var menuControl: Binding<Bool>?
    var allReviewCancellable: AnyCancellable?
    
    var page: Int = 0
    var last: Bool = false
    
    func loadMoreComment(movieId: String?) {
        let thresholdIndex = self.reviews.index(self.reviews.endIndex, offsetBy: -1)
        self.page += 10
        fetchReviews(offset: thresholdIndex, size: 10, movieId: movieId, first: false)
    }
    
    func firstLoadComment(movieId: String?, size: Int) {
        self.page += size
        fetchReviews(offset: 0, size: size, movieId: movieId, first: true)
    }
    
    func stop() {
        allReviewCancellable?.cancel()
    }
}

extension AllReviewViewModel{
    func fetchReviews(offset: Int, size: Int, movieId: String?, first: Bool) {
        reviewLoading = true
        let sizeURL = "&offset=\(offset)&size=\(size)"
        if let movieId = movieId {
            allReviewCancellable = MovieDB.getRequest("movies/review?movie_id=", endPoint: "\(movieId)", size: sizeURL, type: ReviewResponse(reviews: []))
                .mapError({ (error) -> Error in
                    return error
                })
                .sink(receiveCompletion: { [weak self] result in
                    switch result {
                    case .finished :
                        print("AllMoviesFirst Finished")
                    case .failure(let error) :
                        print("AllMoviesFirst error: \(error)")
                    }

                    self?.reviewLoading = false
                }, receiveValue: { [weak self] value in
                    if let reviews = value.reviews {
                        if reviews.isEmpty {
                            self?.last = true
                        }
                        if first {
                            self?.reviews = reviews
                        }
                        else {
                            self?.reviews.append(contentsOf: reviews)
                        }
                    }
                })
        }
    }
    
    func ReviewEdit(idx: Int?, movieId: String?, comment: String?, ratingNum: Int){
        
        if let idx = idx, let movieId = movieId, let comment = comment {
            MovieDB.editReview(idx: idx, movieId: movieId, comment: comment, ratingNum: ratingNum)
                .mapError({(error) -> Error in
                    return error
                })
                .sink(receiveCompletion: { result in
                    switch result {
                    case .finished :
                        print("EditReview Finished")
                    case .failure(let error) :
                        print("EditReview Error: \(error)")
                    }
                    
                }, receiveValue: {
                    print("edit Review Value: \($0)")
                })
        }
        
        
    }
    
    func DeleteReview(idx: Int?, movieId: String?, realoadData:@escaping () -> Void) {
        if let idx = idx, let movieId = movieId {
            MovieDB.deleteReview(idx: idx, movieId: movieId)
                .mapError({(error) -> Error in
                    return error
                })
                .sink(receiveCompletion: { result in
                    switch result {
                    case .finished :
                        print("DeleteReview Finished")
                        DispatchQueue.main.async {
                            realoadData()
                        }
                        
                    case .failure(let error) :
                        print("DeleteReview Error: \(error)")
                    }
                }, receiveValue: {
                    print("DeleteReview Value: \($0)")
                })
        }
        
    }
}

