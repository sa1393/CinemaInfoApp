import Foundation
import Combine

class SearchVM: ObservableObject {
    @Published var searchResultMovies: [MovieProtocol] = []
    @Published var searchLoading: Bool = false
    
    @Published var searchString = ""
    var searchCancellationToken: AnyCancellable?
    
    var allGenore: [GenoreType] = [.horror, .thriller, .action, .comedy, .sf, .crime, .mistery, .family, .documentory, .war, .adventure, .fantasy, .animation, .ero, .drama, .guitar, .all]
    
    public func searchMovies(movies: [Movie], genore: [GenoreType], searchText: String) -> [Movie]{
        if searchText == "" {
            return []
        }
        return movies.filter{$0.allGenore.map{genore.contains($0 ?? GenoreType.guitar)}.contains(true)}
    }
    
    init() {
        
    }
}

extension SearchVM {
    func fetchMovies(searchText: String) {
        searchCancellationToken?.cancel()
        
        let search = searchText.trimmingCharacters(in: [" "])
        if search.isEmpty{
            self.searchResultMovies = []
            return
        }
        
        searchCancellationToken = MovieDB.getRequest("movies/search?text=", endPoint: "\(search)", type: MovieResponse(movies: []))
            .mapError({ (error) -> Error in
                print("search error: \(error)")
                return error
            })
            .sink(receiveCompletion: { [weak self] result in
                print("search result: \(result)")
                self?.searchLoading = false
            }, receiveValue: { [weak self] value in
                self?.searchResultMovies = value.movies.filter{$0.movie.posterImgURL != nil}
            })
        
    }
}
