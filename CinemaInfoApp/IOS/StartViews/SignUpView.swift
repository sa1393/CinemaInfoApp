import SwiftUI

struct SignInView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var signUpViewModel = SignUpViewModel()
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 10, height: 20)
                            .foregroundColor(.white)
                        
                    })
                    
                    Spacer()
                    
                    Text("회원가입")
                        .foregroundColor(Color.white)
                        .font(.system(size: 18, weight: .bold))
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 18)
                
                VStack(alignment: .leading, spacing: 12) {
                    Spacer()
                    SignTextField(placeHolder: "아이디", secure: false, text: $signUpViewModel.id)
                    SignTextField(placeHolder: "이름", secure: true, text: $signUpViewModel.name)
                    SignTextField(placeHolder: "비밀번호", secure: true, text: $signUpViewModel.pwd)
                    SignTextField(placeHolder: "비밀번호 확인", secure: true, text: $signUpViewModel.pwdCheck)
                    
                    Button(action: {
                        signUpViewModel.SignUp()
                    }, label: {
                        HStack{
                            Spacer()
                            Text("가입하기")
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
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

