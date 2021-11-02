import SwiftUI

struct MyInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 45) {
                VStack(spacing: 40) {
                    if let image = baseViewModel.user?.profile {
                        Image(uiImage: UIImage(data: image) ?? UIImage())
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        
                    }
                    else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.white)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    }
                    
                    if baseViewModel.isLogin {
                        HStack {
                            Text(baseViewModel.user?.name ?? "???")
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
                }
                
                if baseViewModel.isLogin {
                    VStack(alignment: .leading, spacing: 25) {
                        Text(I18N.userInfo)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        
                        Rectangle()
                            .frame(width: UIScreen.screenWidth, height: 1)
                            .padding(.vertical, 4)
                            .foregroundColor(.gray)
                        
                        HStack {
                            Text(I18N.name)
                                .frame(width: 80, alignment: .leading)
                            
                            Text(baseViewModel.user?.name ?? "")
                            
                            Spacer()
                            
                            NavigationLink(destination: {
                                NavigationLazyView(UserEditView())
                            }, label: {
                                HStack {
                                    Text(I18N.userEdit)
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundColor(.white)
                                
                            })
                        }
                        HStack {
                            Text(I18N.id)
                                .frame(width: 80, alignment: .leading)
                            Text(baseViewModel.user?.id ?? "")
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text(I18N.pwd)
                                .frame(width: 80, alignment: .leading)
                            Text(baseViewModel.user?.pwd ?? "")
                            
                            Spacer()
                        }
                        
                        Rectangle()
                            .frame(width: UIScreen.screenWidth, height: 1)
                            .padding(.vertical, 4)
                            .foregroundColor(.gray)
                        
                    }
                    .foregroundColor(.gray)
                    .font(.system(size: 20, weight: .bold))
                    
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
                        Rectangle()
                            .frame(width: UIScreen.screenWidth * 0.97, height: 1)
                            .padding(.vertical, 4)
                            .foregroundColor(.gray)
                    }
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
                    
                Spacer()
                
                
            }
            .navigationBarHidden(true)
            .foregroundColor(.white)
        }
        
    }
}

struct MyInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: MyInfoView().environmentObject(BaseViewModel()), dark: true)
        
    }
}
