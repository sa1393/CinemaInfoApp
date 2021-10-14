import Foundation


class MovieDetailVM: ObservableObject {
    @Published var reviews: [Review] = []
    @Published var loading: Bool = true

    var urlStr: String = ""
    
    var movie: MovieProtocol
    init(movie: MovieProtocol = exampleMovie1) {
        self.movie = movie
        self.urlStr = "\(SecretText.baseURL)movies/review?movie_id=\(movie.movie.movieId)"
        
    }
}

extension MovieDetailVM {
    func fetchReviews() {
        MovieDB.getRequest("movies/review?movie_id=", endPoint: "\(movie.movie.movieId)", type: ReviewResponse(reviews: []))
            .mapError({ (error) -> Error in
                print("detail error: \(error)")
                return error
            })
            .sink(receiveCompletion: { [weak self] result in
                print("detail result: \(result)")
                self?.loading = false
            }, receiveValue: { [weak self] value in
                self?.reviews = value.reviews
            })
    }
}
