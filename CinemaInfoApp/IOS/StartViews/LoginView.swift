//
//  LoginVIew.swift
//  CinemaInfoApp
//
//  Created by MEESEON KANG on 2021/10/13.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var startViewModel: TutorialViewModel
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true)
            VStack {
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
                    
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Help")
                            .foregroundColor(Color.white)
                            .font(.system(size: 18, weight: .bold))
                    })
                
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 18)
                
                Spacer()
            }
                
            VStack(spacing: 18) {
                Spacer()
                SignTextField(placeHolder: "아이디", secure: false, text: $startViewModel.idString)
                SignTextField(placeHolder: "비밀번호", secure: true, text: $startViewModel.pwString)
                
                Button(action: {
                    
                }, label: {
                    HStack{
                        Spacer()
                        Text("로그인")
                            .foregroundColor(Color.white)
                            .font(.system(size: 18, weight: .bold))
                        Spacer()
                    }
                    .frame(height: 60)
                    .border(Color(hex: "#1f1f1f"), width: 2)
                    
                    
                })
                    
                Spacer()
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(TutorialViewModel())
    }
}
