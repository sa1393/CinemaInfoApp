import SwiftUI

struct TutorialView: View {
    @EnvironmentObject var baseViewModel: BaseViewModel
    @StateObject var startViewModel = TutorialViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                //top menu
                VStack {
                    HStack {
                        Image(systemName: "tortoise.fill")
                            .resizable()
                            .frame(width: 50, height: 30)
                            .scaledToFit()
                            .foregroundColor(Color.blue)
                        
                        Spacer()
                        NavigationLink(destination: {
                            LoginView()
                                .environmentObject(startViewModel)
                        }, label: {
                            Text("로그인")
                                .foregroundColor(Color.white)
                                .font(.system(size: 20, weight: .bold))
                        })
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 8)
//                    .background(Color.white) //test
                    Spacer()
                }
                
                //page tab bar and button
                VStack(alignment: .trailing) {
                    
                    VStack {
                        
                    }
                    Spacer()
                    VStack {
                        Button(action: {
                            baseViewModel.launchAfter = true
                            UserDefaults.standard.set(baseViewModel.launchAfter, forKey: "LaunchAfter")
                        }, label: {
                            HStack {
                                Spacer()
                                Text("시작하기")
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
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
        
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
