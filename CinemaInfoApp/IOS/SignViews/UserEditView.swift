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
                    }
                    
                    VStack {
                        SignTextField(placeHolder: "", secure: false, signField: $userEditViewModel.editPwd)
                        
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
                    .offset(x: userEditViewModel.tab == .passwordCheck ? UIScreen.screenWidth : 0)
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .navigationBarHidden(true)
        }
        .alert(isPresented: $userEditViewModel.pwdCheckAlert) {
            Alert(title: Text(I18N.passwordCheck), message: Text(I18N.passwordCheckFail), dismissButton: .default(Text(I18N.close)))
        }
    }
}

struct UserEditView_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: UserEditView().environmentObject(BaseViewModel()), dark: true)
    }
}
