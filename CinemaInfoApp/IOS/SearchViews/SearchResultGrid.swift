import SwiftUI
import Kingfisher

struct SearchResultGrid: View {
    var searchViewModel: SearchVM
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 5, alignment: nil),
        GridItem(.flexible(), spacing: 5, alignment: nil),
        GridItem(.flexible(), spacing: 5, alignment: nil)
    ]

    var body: some View {

        if searchViewModel.searchString.isEmpty {
            VStack() {
                Spacer()
                Text(I18N.searchReady)
                Spacer()
            }
        }
        else if searchViewModel.searchResultMovies.isEmpty {
            VStack() {
                Spacer()
                Text(I18N.searchNone)
                Spacer()
            }
        }
        else {
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(searchViewModel.searchResultMovies.map { $0.movie }, id: \.self) { movie in
                    
                    NavigationLink(destination: NavigationLazyView(MovieDetail(movie: searchViewModel.searchResultMovies.first{
                        $0.movie.movieId == movie.movieId
                    }!))) {
                        StandardHomeMovie(posterImgURL: movie.posterImgURL)
                            .frame(height: UIScreen.screenWidth / 3 / 2 * 3 - 10)
                    }
                }
            }
            .padding(.bottom, UIScreen.tabbarHeight)
        }
        
    }
}

struct SearchResultGrid_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: SearchView(), dark: true)
    }
}
