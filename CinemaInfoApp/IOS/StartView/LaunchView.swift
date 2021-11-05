////
////  LaunchView.swift
////  CinemaInfoApp
////
////  Created by 박태양 on 2021/11/04.
////
//
//import SwiftUI
//
//struct LaunchView: View {
//    @EnvironmentObject var baseViewModel: BaseViewModel
//
//    var body: some View {
//
//            NavigationView {
//                TabView(selection: $baseViewModel.selected) {
//                    HomeView()
//                        .tag(Tab.home)
//
//                    SearchView()
//                        .tag(Tab.search)
//
//                    MyInfoView()
//                        .tag(Tab.my)
//                }
//                .overlay(
//                    HStack {
//                        TabButton(tab: .home, systemIcon: "house.fill")
//                        TabButton(tab: .search, systemIcon: "magnifyingglass")
//                        TabButton(tab: .my, systemIcon: "person.fill")
//                    }
//                    .frame(height: UIScreen.tabbarHeight)
//                    .background(
//                        Color.black.opacity(0.9)
//                            .ignoresSafeArea(.container, edges: .bottom)
//                    )
//                    , alignment: .bottom
//                )
//                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//                .ignoresSafeArea(.keyboard)
//            }
//            .navigationViewStyle(.stack)
//            .navigationBarHidden(true)
//    }
//}
//
//extension LaunchView {
//    @ViewBuilder
//    func TabButton(tab: Tab, systemIcon: String) -> some View{
//        Button(action: {
//            withAnimation {
//                baseViewModel.selected = tab
//            }
//        }) {
//
//            VStack(spacing: 0) {
//                Rectangle()
//                    .fill(Color.clear)
//                    .frame(height: 2)
//                    .padding(.horizontal, 2)
//
//                if  baseViewModel.selected == tab {
//                    Rectangle()
//                        .fill(Color.white)
//                        .frame(height: 2)
//                        .padding(.horizontal, 2)
//                        .matchedGeometryEffect(id: "tab", in: animation)
//                }
//
//
//                Spacer()
//
//                VStack {
//                    Spacer()
//                    Image(systemName: systemIcon)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 30, height: 30)
//                        .foregroundColor(baseViewModel.selected == tab ? Color.white : Color(hex: "#767370"))
//
//                    Text(tab.rawValue)
//                        .foregroundColor(baseViewModel.selected == tab ? Color.white : Color(hex: "#767370"))
//                        .font(.system(size: 11, weight: .bold, design: .rounded))
//
//                }
//                Spacer()
//            }
//        }
//    }
//}
//
//struct LaunchView_Previews: PreviewProvider {
//    static var previews: some View {
//        Preview(source: LaunchView(), dark: true)
//            .environmentObject(BaseViewModel())
//    }
//}
