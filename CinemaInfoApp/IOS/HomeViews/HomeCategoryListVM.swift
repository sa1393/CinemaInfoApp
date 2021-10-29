
import Foundation

class HomeCategoryListViewModel: ObservableObject {
    @Published var movies: [MovieProtocol] = []
    @Published var loading: Bool = false
    
    var title: String?
    var genore: GenoreType?
    var rated: AgeType?
    var size: Int?
    
    init() {
        
    }
    
    func setting(title: String? = nil, genore: GenoreType? = nil, rated: AgeType? = nil, size: Int? = nil) {
        self.title = title
        self.genore = genore
        self.rated = rated
        self.size = size
    }
    
    func resultOption() -> String {
        var resultStr = ""
        if let title = title {
            resultStr.append(contentsOf: "&title=\(title)")
        }
        
        if let genore = genore {
            resultStr.append(contentsOf: "&genore=\(genore.rawValue)")
        }
        
        if let rated = rated {
            resultStr.append(contentsOf: "&rated=\(rated.rawValue)")
        }
        
        if let size = size {
            resultStr.append(contentsOf: "&offset=0&size=\(String(size))")
        }
        
        let start = resultStr.index(resultStr.startIndex, offsetBy: 1)
        let end = resultStr.index(resultStr.endIndex, offsetBy: -1)
        
        resultStr = String(resultStr[start...end])
        return resultStr
    }
}

extension HomeCategoryListViewModel {
    
    func fetchSearch() {
        self.loading = true
        var optionString = resultOption()
        MovieDB.getRequest("movies/search/beta?", endPoint: "\(optionString)", type: MovieResponse(movies: []))
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
                self?.loading = false
            }, receiveValue: { [weak self] value in
                self?.movies = value.movies.filter{$0.movie.posterImgURL != nil}
            })
    }
}
