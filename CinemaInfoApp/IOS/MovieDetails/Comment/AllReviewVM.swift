import Foundation
import SwiftUI

class AllReviewViewModel: ObservableObject {
    @Published var reviews: [Review] = []
    @Published var reviewLoading: Bool = false
    @Published var editMode: Bool = false
    
    var menuControl: Binding<Bool>?
    
    var page: Int = 0
    var last: Bool = false
    
    func loadMoreComment(movieId: String) {
        let thresholdIndex = self.reviews.index(self.reviews.endIndex, offsetBy: -1)
        self.page += 10
        fetchReviews(offset: thresholdIndex, size: 10, movieId: movieId, first: false)
    }
    
    func firstLoadComment(movieId: String, size: Int) {
        self.page += size
        fetchReviews(offset: 0, size: size, movieId: movieId, first: true)
    }
}

extension AllReviewViewModel{
    func fetchReviews(offset: Int, size: Int, movieId: String, first: Bool) {
        reviewLoading = true
        let sizeURL = "&offset=\(offset)&size=\(size)"
        MovieDB.getRequest("movies/review?movie_id=", endPoint: "\(movieId)", size: sizeURL, type: ReviewResponse(reviews: []))
            .mapError({ (error) -> Error in
                print("detail error: \(error)")
                return error
            })
            .sink(receiveCompletion: { [weak self] result in
                print("detail result: \(result)")
                
                self?.reviewLoading = false
            }, receiveValue: { [weak self] value in
                if value.reviews.isEmpty {
                    self?.last = true
                }
                if first {
                    self?.reviews = value.reviews
                }
                else {
                    self?.reviews.append(contentsOf: value.reviews)
                }
               
            })
    }
    
    func ReviewEdit(idx: Int, movieId: String, comment: String, ratingNum: Int){
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
    
    func DeleteReview(idx: Int, movieId: String, realoadData:@escaping () -> Void) {
        MovieDB.deleteReview(idx: idx, movieId: movieId)
            .mapError({(error) -> Error in
                return error
            })
            .sink(receiveCompletion: { result in
                switch result {
                case .finished :
                    print("DeleteReview Finished")
                    realoadData()
                case .failure(let error) :
                    print("DeleteReview Error: \(error)")
                }
            }, receiveValue: {
                print("DeleteReview Value: \($0)")
            })
    }
}

