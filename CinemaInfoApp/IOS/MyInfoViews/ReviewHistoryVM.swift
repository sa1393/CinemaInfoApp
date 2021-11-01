import Foundation
import Combine

class ReviewHistoryViewModel: ObservableObject {
    @Published var myReviews: [AllMovie: Review] = [:]
    var myReviewCancellationToken: AnyCancellable?
    
    @Published var loading: Bool = false
    
    init() {
        
    }
    
    func myReviewMovieId() -> [AllMovie] {
        myReviews.map{$0.key}
    }
    
    func stop() {
        myReviewCancellationToken?.cancel()
    }
}

extension ReviewHistoryViewModel {
    func fetchMyReviews() {
        self.loading = true
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
                
                self?.loading = false
            }, receiveValue: { [weak self] result in
                self?.myReviews = [:]
                if let movies = result.movies, let reviews = result.reviews {
                    for (index) in 0..<movies.count {
                        self?.myReviews[movies[index]] = reviews.first(where: {$0.movie_id == movies[index].movieId})
                        
                    }
//                    if let myReviews = self?.myReviews {
//                        self?.myReviews = self?.myReviews.sorted { $0.value.id > $1.value.id }
//                        print("정렬")
//                    }
                    
                }
                
            })
    }
}
