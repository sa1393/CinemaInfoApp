//
//  UserEditView.swift
//  CinemaInfoApp
//
//  Created by 박태양 on 2021/11/02.
//

import SwiftUI

enum EditTab {
    case passwordCheck
    case passwordEdit
}

struct UserEditView: View {
    @EnvironmentObject var baseViewModel: BaseViewModel
    @Environment(\.presentationMode) var presentationMode
    @StateObject var userEditViewModel = UserEditViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 35) {
                CustomNavigationBar(title: I18N.userEdit)
                ZStack {
                    VStack(alignment: .leading) {
                        Text(I18N.passwordCheck)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        VStack(alignment: .center, spacing: 25) {
                            SignTextField(placeHolder: I18N.pwd, secure: false, signField: $userEditViewModel.pwd)
                            
                            Button(action: {
                                userEditViewModel.passwordCheck()
                            }, label: {
                                Text(I18N.check)
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 18, weight: .bold))
                                    .frame(width: 120, height: 40)
                                    .cornerRadius(4)
                                    .background(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color(hex: "#1f1f1f"), lineWidth: 4)
                                    )
                            })
                        }
                        Spacer()
                    }
                    .offset(x: userEditViewModel.tab == .passwordCheck ? 0 : -UIScreen.screenWidth)
                    .opacity(userEditViewModel.tab == .passwordCheck ? 1 : 0)
                    
                    VStack(alignment: .leading) {
                        Text(I18N.passwordEdit)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        SignTextField(placeHolder: "", secure: false, signField: $userEditViewModel.editPwd)
                        
                        VStack(alignment: .center, spacing: 25) {
                            Button(action: {
                                userEditViewModel.userEdit()
                            }, label: {
                                Text(I18N.edit)
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 18, weight: .bold))
                                    .frame(width: 120, height: 40)
                                    .cornerRadius(4)
                                    .background(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color(hex: "#1f1f1f"), lineWidth: 4)
                                    )
                            })
                        }
                        
                        Spacer()
                    }
                    .background(Color.black)
                    .offset(x: userEditViewModel.tab == .passwordCheck ? UIScreen.screenWidth : 0)
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .navigationBarHidden(true)
            
            if userEditViewModel.loading {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        Spacer()
                    }
                    
                    Spacer()
                }
                .background(Color.black.opacity(0.9))
            }
        }
        .alert(isPresented: $userEditViewModel.alert) {
            Alert(title: Text(userEditViewModel.msg.title), message: Text(userEditViewModel.msg.msg), dismissButton: .default(Text(I18N.close), action: {
                baseViewModel.getUser()
                presentationMode.wrappedValue.dismiss()
                
            }))
        }
    }
}

struct UserEditView_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: UserEditView().environmentObject(BaseViewModel()), dark: true)
    }
}
