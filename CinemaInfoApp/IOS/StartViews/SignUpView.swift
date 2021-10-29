import PhotosUI
import SwiftUI
import UIKit

struct SignUpView: View {
    @State private var showPickerSheet = false
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var signUpViewModel = SignUpViewModel()
    
    @ObservedObject var mediaItems = PickedMediaItems()
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 35) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 10, height: 20)
                            .foregroundColor(.white)
                    })
                    
                    Text("회원 가입")
                        .foregroundColor(Color.white)
                        .font(.system(size: 26, weight: .bold))
                    
                    Spacer()
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 18)
                
                
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Spacer()
                        
                        
                        Button(action: {
                            showPickerSheet = true
                        }, label: {
                            VStack(alignment: .center) {
                                
                                if mediaItems.item != nil {
                                    
                                    Image(uiImage: mediaItems.item?.photo ?? UIImage())
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                    
                                }
                                else {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(Color.white)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                }
                                Text("이미지 고르기")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                
                            }
                        })
                        
                        Spacer()
                        
                    }
                    
                    SignTextField(placeHolder: "아이디", secure: false, signField: $signUpViewModel.id)
                    SignTextField(placeHolder: "이름", secure: true, signField: $signUpViewModel.name)
                    SignTextField(placeHolder: "비밀번호", secure: true, signField: $signUpViewModel.pwd)
                    
                    Button(action: {
                        signUpViewModel.SignUp(profile: mediaItems.item?.photo ?? UIImage(systemName: "person.fill"))
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
                .padding(.top, 100)
            }
            if signUpViewModel.loading {
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
        .alert(isPresented: $signUpViewModel.showingFailAlert) {
            Alert(title: Text("로그인"), message: Text("회원가입에 실패했습니다."), dismissButton: .default(Text("Dismiss").foregroundColor(Color.red)))
        }
        .onAppear {
            self.signUpViewModel.cancellable = self.signUpViewModel
               .$offSign
               .sink(receiveValue: { offSign in
                   guard offSign else { return }
                   
                   DispatchQueue.main.async {
                       self.presentationMode.wrappedValue.dismiss()
                   }
               }
           )
        }
        .sheet(isPresented: $showPickerSheet) {
            PhotoPicker(mediaItems: mediaItems) { didSelectionItem in
                
                showPickerSheet = false
            }
        }
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

