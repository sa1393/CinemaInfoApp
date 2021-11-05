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
    
    func removeMovie(movie: Movie) {
        if let index = searchResultMovies.firstIndex { $0.movie.movieId == movie.movieId} {
            searchResultMovies.remove(at: index)
        }
    }
    
    init() {}
}

extension SearchVM {
    func fetchMovies(searchText: String?) {
        searchLoading = true
        searchCancellationToken?.cancel()
        
        if let searchText = searchText {
            let search = searchText.trimmingCharacters(in: [" "])
            if search.isEmpty{
                
                self.searchResultMovies = []
                searchLoading = false
                return
            }
            
            searchCancellationToken = MovieDB.getRequest("movies/search?text=", endPoint: "\(search)", type: MovieResponse(movies: []))
                .mapError({ (error) -> Error in
                    return error
                })
                .sink(receiveCompletion: { [weak self] result in
                    switch result {
                    case .finished:
                        print("Search Finished")
                        break
                    case .failure:
                        print("Search Error: \(result)")
                        break
                    }
                    DispatchQueue.main.async {
                        self?.searchLoading = false
                    }
                    
                }, receiveValue: { [weak self] value in
                    DispatchQueue.main.async {
                        if let movies = value.movies {
                            self?.searchResultMovies = movies.filter{$0.movie.posterImgURL != nil}
                        }
                    }
                })
        }
        
        
        
    }
}
