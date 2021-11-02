import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    @StateObject var signInViewModel = SigninViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                CustomNavigationBar(title: I18N.signin)
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack(spacing: 12) {
                        SignTextField(placeHolder: I18N.id, secure: false, signField: $signInViewModel.id)
                        SignTextField(placeHolder: I18N.pwd, secure: true, signField: $signInViewModel.pwd)
                    }
                   
                    
                    HStack {
                        Button(action: {
                            signInViewModel.autoLogin.toggle()
                        }, label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 25, height: 25)
                                
                                if signInViewModel.autoLogin {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.blue)
                                }
                            }
                            
                        })
                            .padding(.horizontal, 4)
                        
                        Text(I18N.autoLogin)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color.white)
                            .padding(.leading, 12)
                    }
                    .padding(.vertical, 6)
                    
                    VStack(spacing: 12) {
                        Button(action: {
                            signInViewModel.SignIn()
                        }, label: {
                            HStack{
                                Spacer()
                                Text(I18N.signin)
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
                        
                        NavigationLink(destination: {
                            SignUpView()
                        }, label: {
                            HStack{
                                Spacer()
                                Text(I18N.signup)
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
                    }
                   
                    Spacer()
                }
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
            Alert(title: Text(I18N.signin), message: Text(I18N.signinFail), dismissButton: .default(Text(I18N.close)))
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
        Preview(source: SignInView().environmentObject(BaseViewModel()), dark: true)
    }
}
