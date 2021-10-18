import Foundation
import Combine

class HomeVM : ObservableObject{
    @Published var categoryMovies: [String: [MovieProtocol]] = [:]
    @Published var selectCategory: String = ""
    
    @Published var ratingMovies: [RatingMovie] = []
    @Published var rankMovies: [RankMovie] = []
    
    @Published var loading: Bool = false
    
    var rankCancellationToken: AnyCancellable?
    var ratingCancellationToken: AnyCancellable?
    var genoreCancellationToken: AnyCancellable?
    var loginCancellationToken: AnyCancellable?
    
    public var allCategories: [String] {
        categoryMovies.map { $0.key }
    }
    
    public func setCategories() {
        categoryMovies["판타지 & 액션"] = filterGenore(genore: .action, movies: filterGenore(genore: .fantasy, movies: ratingMovies))
        categoryMovies["애니메이션 영화 추천"] = filterGenore(genore: .animation, movies: ratingMovies)
        categoryMovies["웃긴 코미디 영화 추천"] = filterGenore(genore: .comedy, movies: ratingMovies)
        categoryMovies["공포 영화 추천"] = filterGenore(genore: .horror, movies: ratingMovies)
    }
    
    init() {
        self.fetchRatingMovies()
        self.fetchRankMovies()
        
        self.testLogin()
        print("test")
    }
}

extension HomeVM {
    private func filterGenore(genore: GenoreType, movies: [MovieProtocol]) -> [MovieProtocol]{
        return movies.filter{$0.movie.allGenore.map{$0?.rawValue ?? "" == genore.rawValue}.contains(true)}
    }
    
    public func getGirlSorted(movies: [RatingMovie]) -> [Movie]{
        movies.sorted(by: {$0.jqplotSex.fem > $1.jqplotSex.fem})
            .map{$0.movie}
    }
    
    public func getBoySorted(movies: [RatingMovie]) -> [Movie]{
        movies.sorted(by: {$0.jqplotSex.mal > $1.jqplotSex.mal})
            .map{$0.movie}
    }
    
    public func getCountryFilter(movies: [MovieProtocol], country: String) -> [MovieProtocol] {
        movies.filter{$0.movie.productionCountry.contains(country)}
    }
    
    public func getMemoFilter(movies: [MovieProtocol], memo: String) -> [MovieProtocol]{
        movies.filter{$0.movie.memo.contains(memo)}
    }
    
    public func getAgeSorted(movies: [RatingMovie], jqplotAge: Int) -> [Movie]{
        switch jqplotAge {
        case 10:
            return movies.sorted{$0.jqplotAge.oneAge < $1.jqplotAge.oneAge}
            .map{$0.movie}
        case 20:
            return movies.sorted{$0.jqplotAge.twoAge < $1.jqplotAge.twoAge}
            .map{$0.movie}
        case 30:
            return movies.sorted{$0.jqplotAge.threeAge < $1.jqplotAge.threeAge}
            .map{$0.movie}
        case 40:
            return movies.sorted{$0.jqplotAge.fourAge < $1.jqplotAge.fourAge}
            .map{$0.movie}
        case 50:
            return movies.sorted{$0.jqplotAge.fiveAge < $1.jqplotAge.fiveAge}
            .map{$0.movie}
        default:
            return movies.sorted{$0.jqplotAge.oneAge < $1.jqplotAge.oneAge}
            .map{$0.movie}
        }
    }
}

extension HomeVM {
    func fetchRankMovies() {
        rankCancellationToken = MovieDB.getRequest("movies/", endPoint: "rank", type: MovieRankResponse(movies: []))
            .mapError({ (error) -> Error in
                print("rank error: \(error)")
                return error
            })
            .sink(receiveCompletion: { [weak self] result in 
                print("rank result: \(result)")
                print(self?.rankMovies.count ?? 0)
                
            }, receiveValue: { [weak self] value in
                
                print(value.movies.count)
                self?.rankMovies = value.movies.filter{$0.movie.posterImgURL != nil}
                
            })
    }
}

extension HomeVM {
    func fetchRatingMovies() {
        ratingCancellationToken = MovieDB.getRequest("movies/", endPoint: "rating", type: MovieRatingResponse(movies: []))
            .mapError({ (error) -> Error in
                print("rating error: \(error)")
                return error
            })
            .sink(receiveCompletion: { [weak self] result in
                print("rating result: \(result)")
                self?.setCategories()
                self?.loading = true
            }, receiveValue: { [weak self] value in
                self?.ratingMovies = value.movies.filter{$0.movie.posterImgURL != nil}
            })
    }
}

extension HomeVM {
    func fecthGenoreMovies(genore: GenoreType) {
        genoreCancellationToken = MovieDB.getRequest("movies/genore?genore=", endPoint: "\(genore.rawValue)", type: MovieResponse(movies: []))
            .mapError({ (error) -> Error in
                print("genore error: \(error)")
                return error
            })
            .sink(receiveCompletion: {
                print("genore result: \($0)")
            }, receiveValue: { value in
                print(value.movies.count)
            })
    }
}

extension HomeVM {
    func testLogin() {
        loginCancellationToken = MovieDB.login()
            .mapError({ (error) -> Error in
                print("login error: \(error)")
                return error
            })
            .sink(receiveCompletion: {
                print("login result: \($0)")
            }, receiveValue: { value in
                print(value)
            })
    }
}
