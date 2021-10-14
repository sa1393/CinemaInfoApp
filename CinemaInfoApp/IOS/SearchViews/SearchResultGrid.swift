import SwiftUI
import Kingfisher

struct SearchResultGrid: View {
    var movies: [MovieProtocol]
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0, alignment: nil),
        GridItem(.flexible(), spacing: 0, alignment: nil),
        GridItem(.flexible(), spacing: 0, alignment: nil)
    ]
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        if movies.isEmpty {
            VStack() {
                Text("검색한 영화가 없습니다.")
            }
        }
        else {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(movies.map { $0.movie }, id: \.self) { movie in
                    NavigationLink(destination: NavigationLazyView(MovieDetail(movie: movies.first{
                        $0.movie.movieId == movie.movieId
                    }!))) {
                        StandardHomeMovie(posterImgURL: movie.posterImgURL)
                            .scaledToFit()
                            .frame(width: screen.width / 3 - 10, height: (screen.width / 3 - 10) / 2 * 3)
                    }
                    .navigationTitle("")
                }
            }
            
        }
    }
}

struct SearchResultGrid_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(BaseViewModel())
    }
}
