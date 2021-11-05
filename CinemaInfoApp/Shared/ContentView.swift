import SwiftUI
import Introspect
import UIKit

struct ContentView: View{
    @EnvironmentObject var baseViewModel: BaseViewModel
    @Namespace private var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack {
            if !baseViewModel.afterLaunch {
                TutorialView()
            }
            else {
                NavigationView {
                    TabView(selection: $baseViewModel.selected) {
                        HomeView()
                            .tag(Tab.home)
                            
                        SearchView()
                            .tag(Tab.search)
                            
                        MyInfoView()
                            .tag(Tab.my)
                    }
                    .overlay(
                        HStack {
                            TabButton(tab: .home, systemIcon: "house.fill", tabTitle: I18N.home)
                            TabButton(tab: .search, systemIcon: "magnifyingglass", tabTitle: I18N.search)
                            TabButton(tab: .my, systemIcon: "person.fill", tabTitle: I18N.myInfo)
                        }
                        .frame(height: UIScreen.tabbarHeight)
                        .background(
                            Color.black.opacity(0.9)
                                .ignoresSafeArea(.container, edges: .bottom)
                        )
                        , alignment: .bottom
                    )
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .ignoresSafeArea(.keyboard)
                }
                .navigationViewStyle(.stack)
                .navigationBarHidden(true)
            }
        }
        .preferredColorScheme(.dark)
    }
}

extension ContentView {
    @ViewBuilder
    func TabButton(tab: Tab, systemIcon: String, tabTitle: String) -> some View{
        Button(action: {
            withAnimation {
                baseViewModel.selected = tab
            }
        }) {
            
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 2)
                    .padding(.horizontal, 2)
                
                if  baseViewModel.selected == tab {
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 2)
                        .padding(.horizontal, 2)
                        .matchedGeometryEffect(id: "tab", in: animation)
                }
                
                Spacer()
                
                VStack {
                    Spacer()
                    Image(systemName: systemIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(baseViewModel.selected == tab ? Color.white : Color(hex: "#767370"))
                    
                    Text(tabTitle)
                        .foregroundColor(baseViewModel.selected == tab ? Color.white : Color(hex: "#767370"))
                        .font(.system(size: 11, weight: .bold, design: .rounded))

                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: ContentView(), dark: true)
            .environmentObject(BaseViewModel())
        
    }
}
