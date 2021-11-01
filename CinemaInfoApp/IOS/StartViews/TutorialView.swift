import SwiftUI

struct TutorialView: View {
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    TabView() {
                        ZStack {
                            Image("tutorial_movie")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.screenWidth)
                                .clipped()
                            
                            VStack(alignment: .leading) {
                                Spacer()
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(I18N.movieInfo)
                                            .font(.system(size: 36, weight: .bold))
                                            .foregroundColor(Color.white)
                                            .padding(.vertical, 12)
                                        
                                        Text(I18N.tutorialMovieInfoContent)
                                            .font(.system(size: 18, weight: .bold))
                                            .foregroundColor(Color.white.opacity(0.8))
                                    }
                            
                                    .offset(y: 170)
                                    
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 8)
                        }                    
                        
                        ZStack {
                            Image("tutorial_comment")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.screenWidth)
                                .clipped()
                            
                            VStack(alignment: .leading) {
                                Spacer()
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(I18N.reviewWirte)
                                            .font(.system(size: 36, weight: .bold))
                                            .foregroundColor(Color.black)
                                            .padding(.vertical, 12)
                                        
                                        Text(I18N.tutorialReviewContent)
                                            .font(.system(size: 18, weight: .bold))
                                            .foregroundColor(Color.black.opacity(0.8))
                                    }
                                    .offset(y: 170)
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal, 8)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))

                }

                VStack(alignment: .trailing) {
                    Spacer()
                    VStack {
                        Button(action: {
                            baseViewModel.afterLaunch = true
                            UserDefaults.standard.set(baseViewModel.afterLaunch, forKey: "LaunchAfter")
                        }, label: {
                            HStack {
                                Spacer()
                                Text(baseViewModel.isLogin ? I18N.signin : I18N.noLoginStart)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(Color.white)
                                Spacer()
                            }
                            .padding(.vertical, 16)
                            .background(Color.red)
                        })
                    }
                    .padding(.bottom, 12)
                    .padding(.horizontal, 8)
                    
                }
                
                //top menu
                VStack {
                    HStack {
                        Image(systemName: "tortoise.fill")
                            .resizable()
                            .frame(width: 50, height: 30)
                            .scaledToFit()
                            .foregroundColor(Color.blue)
                        
                        Spacer()
                        if !baseViewModel.isLogin {
                            NavigationLink(destination: {
                                SignInView()

                            }, label: {
                                Text(I18N.signin)
                                    .foregroundColor(Color.white)
                                    .font(.system(size: 20, weight: .bold))
                            })
                        }
                        
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 8)
                    .background(Color.black)
                    Spacer()
                }
                
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
        .preferredColorScheme(.dark)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
            .environmentObject(BaseViewModel())
    }
}
