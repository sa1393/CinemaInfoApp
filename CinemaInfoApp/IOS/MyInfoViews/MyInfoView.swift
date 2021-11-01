import SwiftUI

struct MyInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 55) {
                
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                
                if baseViewModel.isLogin {
                    HStack {
                        Text(baseViewModel.user?.name ?? "")
                            .font(.system(size: 24, weight: .bold))
                    }
                }
                else {
                    NavigationLink(destination: {
                        NavigationLazyView(SignInView())
                        
                    }, label: {
                        HStack {
                            Text(I18N.signin)
                                .font(.system(size: 24, weight: .bold))
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 22, weight: .bold))
                                .frame(width: 20, height: 25)
                                .foregroundColor(.gray)
                        }
                    })
                }
                if baseViewModel.isLogin {
                    VStack(alignment: .leading, spacing: 35) {
                        NavigationLink(destination: {
                            SettingView()
                        }, label: {
                            HStack {
                                Image(systemName: "gearshape.fill")
                                    .font(.system(size: 22, weight: .bold))
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.gray)
                                Text(I18N.setting)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.gray)
                                    .padding(4)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                        })
                        
                        NavigationLink(destination: {
                            NavigationLazyView(ReviewHistoryView())
                            
                        }, label: {
                            HStack {
                                Image(systemName: "note.text")
                                    .font(.system(size: 22, weight: .bold))
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.gray)
                                Text(I18N.reviewHistory)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.gray)
                                    .padding(4)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                            
                        })
                        
                        HStack {
                            Spacer()
                            
                            if baseViewModel.isLogin {
                                Button(action: {
                                    baseViewModel.SignOut()
                                }, label: {
                                    HStack {
                                        Text(I18N.signOut)
                                            .font(.system(size: 18, weight: .bold))
                                        
                                    }
                                })
                            }
                            Spacer()
                        }
                    }
                }
                
                Spacer()
            }
            .padding(.top, 50)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .foregroundColor(.white)
        }
    }
}

struct MyInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: MyInfoView().environmentObject(BaseViewModel()), dark: true)
        
    }
}
