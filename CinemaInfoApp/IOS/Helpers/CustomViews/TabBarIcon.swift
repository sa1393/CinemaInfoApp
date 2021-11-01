import SwiftUI

struct TabBarIcon: View {
    let title: String
    let width, height: CGFloat
    let systemIconName, tabName, assignedIconName: String
    var animation: Namespace.ID
    
    @Binding var selectedTab : String
    
    var geometry: GeometryProxy
    
    var body: some View {
        
        Button(action: {
            withAnimation{
                selectedTab = title
            }
        }) {
            
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 2)
                        .padding(.horizontal, 2)
                    
                    if title == selectedTab {
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 2)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                            .padding(.horizontal, 2)
                    }
                }
                
                Spacer()
                
                VStack {
                    Spacer()
                    Image(systemName: assignedIconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(title == selectedTab ? Color.white : Color(hex: "#767370"))
                        .frame(width: geometry.size.width / width / 3, height: geometry.size.height / height / 3)
                    
                    
                    Text(tabName)
                        .foregroundColor(title == selectedTab ? Color.white : Color(hex: "#767370"))
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                    
                }
                Spacer()
            }
        }
        .frame(width: geometry.size.width / width, height: geometry.size.height / height)
    }
}




