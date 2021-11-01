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
                    
                    Text(I18N.signup)
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
                                Text(I18N.pickProfile)
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                
                            }
                        })
                        
                        Spacer()
                        
                    }
                    
                    SignTextField(placeHolder: I18N.id, secure: false, signField: $signUpViewModel.id)
                    SignTextField(placeHolder: I18N.name, secure: true, signField: $signUpViewModel.name)
                    SignTextField(placeHolder: I18N.pwd, secure: true, signField: $signUpViewModel.pwd)
                    
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
            Alert(title: Text(I18N.signup), message: Text(I18N.signupFail), dismissButton: .default(Text(I18N.close).foregroundColor(Color.red)))
        }
        .onAppear {
            self.signUpViewModel.cancellable = self.signUpViewModel
               .$offSign
               .sink(receiveValue: { offSign in
                   guard offSign else { return }
                   
                   DispatchQueue.main.async {
                       print("phpPciker 닫기 \(self)")
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

