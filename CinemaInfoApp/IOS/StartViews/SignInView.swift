import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    @StateObject var signInViewModel = SigninViewModel()
    
    @State var autoLogin = false
    var body: some View {
        ZStack {
            Color.black
                
            VStack {
                HStack(spacing: 35) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 10, height: 20)
                            .foregroundColor(.white)
                    })
                    
                    Text("로그인")
                        .foregroundColor(Color.white)
                        .font(.system(size: 26, weight: .bold))
                    
                    Spacer()
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 18)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Spacer()
                SignTextField(placeHolder: "아이디", secure: false, signField: $signInViewModel.id)
                SignTextField(placeHolder: "비밀번호", secure: true, signField: $signInViewModel.pwd)
                
                Button(action: {
                    signInViewModel.SignIn()
                }, label: {
                    HStack{
                        Spacer()
                        Text("로그인")
                            .foregroundColor(Color.white)
                            .font(.system(size: 18, weight: .bold))
                        Spacer()
                    }
                    .frame(height: 50)
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(hex: "#1f1f1f"), lineWidth: 4)
                    )
                })
                
//                HStack {
//                    Button(action: {
//                        autoLogin.toggle()
//                    }, label: {
//                        ZStack {
//                            Rectangle()
//                                .fill(Color.white)
//                                .frame(width: 25, height: 25)
//
//                            if autoLogin {
//                                Image(systemName: "checkmark")
//                                    .font(.system(size: 20, weight: .bold))
//                                    .foregroundColor(.blue)
//                            }
//                        }
//
//                    })
//                        .padding(.horizontal, 4)
//
//                    Text("자동 로그인")
//                        .font(.system(size: 18, weight: .bold))
//                        .foregroundColor(Color.white)
//                        .padding(.leading, 12)
//                }
//                .padding(.vertical, 6)
                
                NavigationLink(destination: {
                    SignUpView()
                }, label: {
                    HStack{
                        Spacer()
                        Text("회원가입")
                            .foregroundColor(Color.black)
                            .font(.system(size: 16, weight: .bold))
                        Spacer()
                    }
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(hex: "#1f1f1f"), lineWidth: 4)
                    )
                })
                
                Spacer()
            }
            
            if signInViewModel.loading {
                VStack {
                    
                    Spacer()
                    HStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(width: 30, height: 30)
                        Spacer()
                    }
                    Spacer()
                }
                .background(Color.black.opacity(0.9))
            }
            
            
        }
        .navigationBarHidden(true)
        .alert(isPresented: $signInViewModel.showingFailAlert) {
            Alert(title: Text("로그인"), message: Text("로그인에 실패했습니다."), dismissButton: .default(Text("Dismiss")))
        }
        .onAppear {
            self.signInViewModel.baseViewModel = self.baseViewModel
            self.signInViewModel.cancellable = self.signInViewModel
               .$offSign
               .sink(receiveValue: { offSign in
                   guard offSign else { return }
                   
                   DispatchQueue.main.async {
                       self.presentationMode.wrappedValue.dismiss()
                   }
               }
           )
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(BaseViewModel())
    }
}
