import PhotosUI
import SwiftUI
import UIKit

struct SignUpView: View {
    @State private var showPickerSheet = false
    @Environment(\.presentationMode) var presentationMode
    @StateObject var signUpViewModel = SignUpViewModel()
    @ObservedObject var mediaItems = PickedMediaItems()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                CustomNavigationBar(title: I18N.signup)
                
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
                                
                                Text(I18N.pickProfile)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        })
                        
                        Spacer()
                    }
                    
                    VStack {
                        SignTextField(placeHolder: I18N.id, secure: false, signField: $signUpViewModel.id)
                        SignTextField(placeHolder: I18N.name, secure: true, signField: $signUpViewModel.name)
                        SignTextField(placeHolder: I18N.pwd, secure: true, signField: $signUpViewModel.pwd)
                    }
                    
                    Button(action: {
                        signUpViewModel.SignUp(profile: mediaItems.item?.photo ?? UIImage(systemName: "person.fill"))
                    }, label: {
                        HStack{
                            Spacer()
                            Text(I18N.join)
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
                }
                Spacer()
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
            Alert(title: Text(I18N.signup), message: Text(I18N.signupFail), dismissButton: .default(Text(I18N.close).foregroundColor(Color.red)))
        }
        .onAppear {
            self.signUpViewModel.cancellable = self.signUpViewModel
               .$offSign
               .sink(receiveValue: { offSign in
                   guard offSign else { return }
                   print("start")

                   DispatchQueue.main.async {
                       print(offSign)
                       self.presentationMode.wrappedValue.dismiss()
                   }
               }
           )
        }
        .sheet(isPresented: $showPickerSheet) {
            PhotoPicker(mediaItems: mediaItems, showPicker: $showPickerSheet)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: SignUpView(), dark: true)
    }
}

