import SwiftUI
import Kingfisher

struct SearchResultGrid: View {
    var movies: [MovieProtocol]
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 5, alignment: nil),
        GridItem(.flexible(), spacing: 5, alignment: nil),
        GridItem(.flexible(), spacing: 5, alignment: nil)
    ]

    var body: some View {
        GeometryReader { proxy in
            if movies.isEmpty {
                VStack() {
                    Text("검색한 영화가 없습니다.")
                }
            }
            else {
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(movies.map { $0.movie }, id: \.self) { movie in
                        
                        NavigationLink(destination: NavigationLazyView(MovieDetail(movie: movies.first{
                            $0.movie.movieId == movie.movieId
                        }!))) {
                            StandardHomeMovie(posterImgURL: movie.posterImgURL)
                                .frame(height: proxy.size.width / 3 / 2 * 3 - 10)
                        }
                        .navigationTitle("")
                    }
                }
                .padding(.bottom, UIScreen.tabbarHeight)
            }
        }
        
    }
}

struct SearchResultGrid_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(BaseViewModel())
    }
}
