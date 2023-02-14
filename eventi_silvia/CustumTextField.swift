//
//  CustumTextField.swift
//  eventi_silvia
//
//  Created by iedstudent on 15/11/22.
//

import SwiftUI

struct CustumTextField: View{
    var title: String
    var placeholder: String
   @Binding var text: String
    
    var isError = false
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).bold()
            TextField(placeholder,text: $text)
                .padding()
                .font(.system(size: 16, weight: .medium))
                .overlay {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(
                            isError ? .red : .gray
                       ,
                        lineWidth: 1
                        )
                }
                .padding(.bottom)
                
            
        }
    }
}

struct CustumTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustumTextField(
            title:"titolo di prova",
            placeholder: "",
            text: .constant("")
        )
        .padding()
    }
}
