import SwiftUI

struct HomeView: View {
    @Environment(\.isPreview) var isPreview
    @Environment(\.scenePhase) var scenePhase
    @StateObject var homeVM: HomeVM = HomeVM()
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    @State var refresh = Refresh(started: false, released: false)
    
    var body: some View {
        VStack {
            if refresh.started && refresh.released {
               ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(height: 20)
            }
  
            ScrollView(.vertical, showsIndicators: false){
                CustomPullToScroll(refresh: $refresh) {
                    updateData()
                }

                ZStack {
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
                                    HStack() {
                                        Image(systemName: "tortoise.fill")
                                            .resizable()
                                            .frame(width: 50, height: 30)
                                            .foregroundColor(.blue)
                                        
                                        Spacer()
                                        
                                    }
                                    .padding(.horizontal, 8)
                                    .frame(height: 50)
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                            }
                        }
                        
                        ForEach(homeVM.allCategories, id: \.self) { key in
                            
                            HomeCategoryList(listName: key, title: homeVM.categoryMovies[key]?.title, genore: homeVM.categoryMovies[key]?.genore, rated: homeVM.categoryMovies[key]?.rated, size: homeVM.categoryMovies[key]?.size)
                                .environmentObject(homeVM)
                        }
                        .padding(.horizontal, 6)
                    }
                    .padding(.bottom, UIScreen.tabbarHeight)
                    
                }
                .offset(y: refresh.started && !refresh.released ? 28 : 0)
            }
            .opacity(baseViewModel.launching ? 0 : 1)
        }
        .foregroundColor(.white)
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.automatic)
        .onAppear {
            if !homeVM.initHasRun {
                homeVM.fetchRankMovies(size: 8)
                
                homeVM.initHasRun = true
            }
        }
        .onDisappear {
            homeVM.stop()
        }
//        .opacity(baseViewModel.launching ? 0 : 1)

    }
    
    func updateData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            homeVM.fetchRankMovies(size: 8)
            homeVM.setCategories()
            homeVM.categoryiesFetch()
            
            withAnimation(Animation.linear) {
                refresh.started = false
                refresh.released = false
            }
        }
    }
}

struct Refresh {
    var startOffset: CGFloat = 0
    var offset: CGFloat = 0
    var started: Bool
    var released: Bool
}

enum ScreeningState: String, CaseIterable {
    case screening = "상영중"
    case all = "모든 영화"
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Preview(source: HomeView(), dark: true)
                .environmentObject(BaseViewModel())
            
            Preview(source: HomeView(), dark: true)
                .environmentObject(BaseViewModel())
                
        }
        
    }
}


