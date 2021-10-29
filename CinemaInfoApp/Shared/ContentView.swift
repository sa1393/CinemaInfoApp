import SwiftUI
import Introspect
import UIKit

struct ContentView: View{
    @EnvironmentObject var baseViewModel: BaseViewModel
    @State var uiTabarController: UITabBarController?
    @Namespace var animation

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.bottom)
            GeometryReader { proxy in
                if !baseViewModel.launchAfter {
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
                                TabButton(tab: .home, systemIcon: "house.fill")
                                TabButton(tab: .search, systemIcon: "magnifyingglass")
                                TabButton(tab: .my, systemIcon: "person.fill")
                            }
                            .frame(height: proxy.size.height / 10)
                            .background(
                                Color.black.opacity(1)
                                    .ignoresSafeArea(.container, edges: .bottom)
                            )
                            , alignment: .bottom
                        )
                    }
                    .navigationViewStyle(.stack)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

extension ContentView {
    @ViewBuilder
    func TabButton(tab: Tab, systemIcon: String) -> some View{
        Button(action: {
            withAnimation{
                baseViewModel.selected = tab
            }
        }) {
            
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 2)
                        .padding(.horizontal, 2)
                    
                    if baseViewModel.selected == tab {
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 2)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                            .padding(.horizontal, 2)
                            .offset(y: 4)
                    }
                }
                
                Spacer()
                
                VStack {
                    Spacer()
                    Image(systemName: systemIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .foregroundColor(baseViewModel.selected == tab ? Color.white : Color(hex: "#767370"))
                    
                    
                    Text(tab.rawValue)
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
        ContentView()
            .environmentObject(BaseViewModel())
        
        ContentView()
            .environmentObject(BaseViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
        
        ContentView()
            .environmentObject(BaseViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        
    }
}
