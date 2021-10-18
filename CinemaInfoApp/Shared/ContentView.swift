import SwiftUI

struct ContentView: View{
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    @Namespace var animation
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            GeometryReader { proxy in

                TabView(selection: $baseViewModel.selected) {
                    HomeView()
                        .tag(Tab.home)
                    SearchView()
                        .tag(Tab.search)

                    Color.black
                        .edgesIgnoringSafeArea(.all)
                        .tag(Tab.more)

                }
                .overlay(
                    HStack {
                        if baseViewModel.showTabbar {
                            TabButton(tab: .home, systemIcon: "house.fill")
                            TabButton(tab: .search, systemIcon: "magnifyingglass")
                            TabButton(tab: .more, systemIcon: "text.justify")
                        }
                        else {
                            Rectangle()
                                .foregroundColor(Color.black)
                        }
                    }
                    .frame(height: proxy.size.height / 10)
                    .background(
                        Color.black.opacity(1)
                            .ignoresSafeArea(.container, edges: .bottom)
                    )
                    
                    , alignment: .bottom
                )
            }
        
            if !baseViewModel.launchAfter {
                TutorialView()
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
        
    }
}


