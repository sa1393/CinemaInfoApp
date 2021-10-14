import SwiftUI

struct HomeCategoryList: View {
    var movies: [MovieProtocol]
    var listName: String
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        VStack {
            HStack {
                Text(listName)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movies.map {$0.movie}, id: \.self) { movie in
                        NavigationLink(destination: NavigationLazyView(MovieDetail(movie: movies.first{
                            $0.movie.movieId == movie.movieId
                        }!))) {
                            StandardHomeMovie(posterImgURL: movie.posterImgURL)
                                .frame(width: screen.width / 3, height: screen.width / 3 / 2 * 3)
                                .scaledToFill()
                        } 
                    }
                }
            }
        }
        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
    }
}

struct HomeCategoryList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                HomeCategoryList(movies: [exampleMovie1, exampleMovie2, exampleMovie3], listName: "example1")
            }
            
        }
    }
}


