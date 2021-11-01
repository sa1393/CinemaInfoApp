import SwiftUI

struct HomeCategoryList: View {
    var listName: String
    
    @StateObject var homeCategoryListViewModel = HomeCategoryListViewModel()
    var title: String?
    var genore: GenoreType?
    var rated: AgeType?
    var size: Int?
    
    @Environment(\.scenePhase) var scenePhase
    
//    init(listName: String, title: String?, genore: GenoreType?, rated: AgeType?, size: Int?) {
//        self.listName = listName
//        self.title = title
//        self.genore = genore
//        self.rated = rated
//        self.size = size
//
//        self.homeCategoryListViewModel.setting(title: title, genore: genore, rated: rated, size: size)
//    }
//
    
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
                    if homeCategoryListViewModel.loading {
                        HStack {
                            Spacer()
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(width: 30, height: 30)
                            Spacer()
                        }
                        .frame(width: UIScreen.screenWidth)
                        
                    }
                    else {
                        LazyHStack {
                            ForEach(homeCategoryListViewModel.movies.map{$0.movie}, id: \.self) { movie in
                                
                                NavigationLink(destination: NavigationLazyView(MovieDetail(movie: homeCategoryListViewModel.movies.first{
                                    $0.movie.movieId == movie.movieId
                                }!))) {
                                    StandardHomeMovie(posterImgURL: movie.posterImgURL)
                                        .frame(width: UIScreen.screenWidth / 3, height: UIScreen.screenWidth / 3 / 2 * 3)
                                        .scaledToFill()
                                }
                                
                            }
                        }
                    }
                    
                }
                .frame(height: UIScreen.screenWidth / 3 / 2 * 3)
            }
        }
        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
        .onChange(of: scenePhase) { phase in
            switch phase {
                case .inactive :
                print("inactive")
                case .active :
                self.homeCategoryListViewModel.fetchSearch()
                case .background :
                    print("background")
            }
        }
        .onAppear {
            self.homeCategoryListViewModel.setting(title: title, genore: genore, rated: rated, size: size)
        }
    }
}

struct HomeCategoryList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                HomeCategoryList(listName: "test", title: nil, genore: GenoreType.action, rated: nil, size: 5)
            }
            
        }
    }
}


