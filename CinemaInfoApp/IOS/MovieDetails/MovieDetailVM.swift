import Foundation
import SwiftUI

class MovieDetailVM: ObservableObject {
    @Published var reviews: [Review] = []
    @Published var myReview: Review?
    @Published var loading: Bool = false
    @Published var myReviewLoading: Bool = false
    
    var reviewEndIndex: Int = 0
    var urlStr: String = ""
    
    var movie: MovieProtocol
    
    func previewComment() {
        fetchReviews(offset: 0, size: 4)
    }
    
    init(movie: MovieProtocol = exampleMovie1) {
        self.movie = movie
        self.urlStr = "\(SecretText.baseURL)movies/review?movie_id=\(movie.movie.movieId)"
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
                
                DispatchQueue.main.async {
                    self?.loading = false
                }
            }, receiveValue: { [weak self] value in
                DispatchQueue.main.async {
                    self?.reviews = []
                    
                    if let reviews = value.reviews {
                        self?.reviews = reviews
                    }
                }
            })
    }
    
    func fetchMyReview(movieId: String?) {
        myReviewLoading = true
        guard let movieId = movieId else {
            myReviewLoading = false
            return
        }
        
        MovieDB.myMovieReview(movieId: movieId)
            .mapError({ (error) -> Error in
                return error
            })
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished :
                    print("MyReview Finished")
                case .failure(let error) :
                    print("MyReview error: \(error)")
                }
                self?.myReviewLoading = false
            }, receiveValue: { [weak self] result in
                self?.myReview = nil
                if let reviews = result.reviews {
                    if reviews.count > 0 {
                        self?.myReview = reviews[0]
                    }
                }
                
                
            })
    }

}
