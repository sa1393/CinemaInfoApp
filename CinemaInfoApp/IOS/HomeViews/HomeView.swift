import SwiftUI

struct HomeView: View {
    @Environment(\.isPreview) var isPreview
    @Environment(\.scenePhase) var scenePhase
    @StateObject var homeVM: HomeVM = HomeVM()
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false){
                VStack {
                    ZStack {
                        VStack(alignment: .leading) {
                            if homeVM.rankLoading {
                                VStack(alignment: .center) {
                                    HStack(alignment: .center){
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                            .frame(width: 30, height: 30)
                                    }
                                }
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth / 2 * 3)
                            }
                            else {
                                if homeVM.rankMovies.count > 0 {
                                    HomeRankMovieSlide(movies: homeVM.rankMovies)
                                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth / 2 * 3)
                                    
                                }
                            }
                        }
                        
                        VStack {
                            VStack {
                                HStack(alignment: .top) {
                                    Image(systemName: "tortoise.fill")
                                        .resizable()
                                        .frame(width: 50, height: 30)
                                        .foregroundColor(.blue)
                                    
                                    Spacer()
                                    
                                }
                                .padding(.horizontal, 8)
                                Spacer()
                            }
                            .frame(height: 40)
                            
                            Spacer()
                        }
                    }
                    
                    ForEach(homeVM.allCategories, id: \.self) { key in
                        
                        HomeCategoryList(listName: key, title: homeVM.categoryMovies[key]?.title, genore: homeVM.categoryMovies[key]?.genore, rated: homeVM.categoryMovies[key]?.rated, size: homeVM.categoryMovies[key]?.size)
                    }
                    .padding(.horizontal, 6)
                    
                }
                .padding(.bottom, UIScreen.tabbarHeight)
            }
        }
        .foregroundColor(.white)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active :
                homeVM.fetchRankMovies(size: 5)
            case .inactive :
                print("inactive")
            case .background :
                print("background")
            }
        }

    }
}

enum ScreeningState: String, CaseIterable {
    case screening = "상영중"
    case all = "모든 영화"
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: HomeView(), dark: true)
    }
}

