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
        
        MovieDB.getRequest("movies/review?movie_id=", endPoint: "\(movie.movie.movieId)", size: sizeURL, type: ReviewResponse(reviews: []))
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
                self?.reviews = value.reviews
            })
    }
    
//    func fetchMyReivew() {
//        print(movie.movie.title)
//
//        MovieDB.myMovieReview(movieTitle: "\(movie.movie.title)")
//            .mapError({ (error) -> Error in
//                return error
//            })
//            .sink(receiveCompletion: { result in
//                switch result {
//                case .finished :
//                    print("\(self.movie.movie.title) MyMovieReview Finished")
//                case .failure(let error) :
//                    print("\(self.movie.movie.title) MyMovieReview Error: \(error)")
//                }
//                self.loading = false
//            }, receiveValue: { [weak self] value in
//
//                print(value)
//            })
//    }
    
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
                for (review) in result.reviews {
                    if self?.movie.movie.movieId == review.movie_id {
                        self?.myReview = review
                    }
                }
            })
    }
}
