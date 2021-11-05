import Foundation
import Combine

struct myReviewAndMovie: Hashable {
    var movie: AllMovie
    var review: Review
}

class ReviewHistoryViewModel: ObservableObject {
    @Published var myReviews: [myReviewAndMovie] = []
    @Published var loading: Bool = false
    @Published var refresh = Refresh(started: false, released: false)
    
    var myReviewCancellationToken: AnyCancellable?

    func stop() {
        myReviewCancellationToken?.cancel()
    }
    
    init() {}
}

extension ReviewHistoryViewModel {
    func fetchMyReviews() {
        if !refresh.released {
            self.loading = true
        }
        
        myReviewCancellationToken = MovieDB.myReview()
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
                
                DispatchQueue.main.async {
                    self?.loading = false
                    self?.refresh.started = false
                    self?.refresh.released = false
                }
            }, receiveValue: { [weak self] result in
                DispatchQueue.main.async {
                    self?.myReviews = []
                    if let movies = result.movies, let reviews = result.reviews {
                        for (index) in 0..<movies.count {
                            let myReviewAndMovie = myReviewAndMovie(movie: movies[index], review: reviews.first(where: {$0.movie_id == movies[index].movieId})!)
                            
                            self?.myReviews.append(myReviewAndMovie)
                            
                        }
                        
                    }
                }
                
                
            })
    }
}
