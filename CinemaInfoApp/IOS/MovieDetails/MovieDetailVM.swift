import Foundation
import SwiftUI

class MovieDetailVM: ObservableObject {
    @Published var reviews: [Review] = []
    @Published var loading: Bool = false
    
    
    @Published var myReviewLoading: Bool = false
    
    @Published var myReview: Review?
    
    var reviewEndIndex: Int = 0
    
    var urlStr: String = ""
    
    var movie: MovieProtocol
    init(movie: MovieProtocol = exampleMovie1) {
        self.movie = movie
        self.urlStr = "\(SecretText.baseURL)movies/review?movie_id=\(movie.movie.movieId)"
    }

    func previewComment() {
        fetchReviews(offset: 0, size: 4)
    }
}

extension MovieDetailVM {
    func fetchReviews(offset: Int, size: Int) {
        loading = true
        let sizeURL = "&offset=\(offset)&size=\(size)"
        
        guard let movieId = movie.movie.movieId else{return}
        print(movieId)
        MovieDB.getRequest("movies/review?movie_id=", endPoint: "\(movieId)", size: sizeURL, type: ReviewResponse(reviews: []))
            .mapError({ (error) -> Error in
                return error
            })
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished :
                    print("\(self?.movie.movie.title) Deatil Finished")
                case .failure(let error) :
                    print("\(self?.movie.movie.title) Detail Error: \(error)")
                }
                self?.loading = false
            }, receiveValue: { [weak self] value in
                self?.reviews = []
                
                if let reviews = value.reviews {
                    self?.reviews = reviews
                }
            })
    }

    func fetchMyReviews() {
        myReviewLoading = true
        MovieDB.myReview()
            .mapError({ (error) -> Error in
                return error
            })
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished :
                    print("MyReviews Finished")
                case .failure(let error) :
                    print("MyReviews error: \(error)")
                }
                self?.myReviewLoading = false
            }, receiveValue: { [weak self] result in
                self?.myReview = nil
                if let reviews = result.reviews {
                    for (review) in reviews {
                        if self?.movie.movie.movieId == review.movie_id {
                            self?.myReview = review
                        }
                    }
                }
                
            })
    }
}
