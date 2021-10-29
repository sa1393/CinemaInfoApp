import Foundation
import Combine

struct MovieOption {
    var title: String?
    var genore: GenoreType?
    var rated: AgeType?
    var size: Int?
}

class HomeVM : ObservableObject{
    @Published var categoryMovies: [String: MovieOption] = [:]
    @Published var selectCategory: String = ""
    
    @Published var ratingMovies: [RatingMovie] = []
    @Published var rankMovies: [RankMovie] = []
    
    @Published var loading: Bool = false
    
    @Published var rankLoading: Bool = false
    
    var rankCancellationToken: AnyCancellable?
    
    public var allCategories: [String] {
        categoryMovies.map { $0.key }
    }
    
    public func setCategories() {
        categoryMovies["성인&액션 영화"] = MovieOption(title: nil, genore: .action, rated: .adult, size: 12)
        categoryMovies["판타지 영화"] = MovieOption(title: nil, genore: .fantasy, rated: .adult, size: 12)
        categoryMovies["따뜻한 가족 영화"] = MovieOption(title: nil, genore: .family, rated: .adult, size: 12)
        categoryMovies["오싹한 공포 영화"] = MovieOption(title: nil, genore: .horror, rated: .adult, size: 12)
        categoryMovies["청불&범죄 영화"] = MovieOption(title: nil, genore: .crime, rated: .adult, size: 12)
        categoryMovies["짜릿한 스릴러 영화"] = MovieOption(title: nil, genore: .thriller, rated: .adult, size: 12)
    }
    
    init() {
        setCategories()
    }
}

extension HomeVM {
    func fetchRankMovies(size: Int?) {
        rankLoading = true
        rankCancellationToken = MovieDB.getRequest("movies/", endPoint: "rank",  type: MovieRankResponse(movies: []))
            .mapError({ (error) -> Error in
                return error
            })
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished :
                    print("RankFinish")
                case .failure(let error) :
                    print("RankFail: \(error)")
                }
                
                self?.rankLoading = false
                
            }, receiveValue: { [weak self] value in
                if let movies = value.movies {
                    self?.rankMovies = movies
                }
                
            })
    }
}
