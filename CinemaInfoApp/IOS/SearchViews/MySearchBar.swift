
import SwiftUI

struct MySearchBar: View {
    @Binding var text: String
    @State var isTapped = false
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(hex: "#818181"))

                TextField(I18N.searchHint, text: $text)
                    .foregroundColor(Color.white)

                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill").foregroundColor(Color(hex: "#818181"))
                    })
                } else {
                    EmptyView()
                }
                
            }
            .frame(height: 30)
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(Color.black)
            .background(Color(hex: "#323232"))
            .cornerRadius(6.0)
        }
    }
}

struct MySearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


