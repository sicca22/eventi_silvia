//
//  ImageView.swift
//  eventi_silvia
//
//  Created by iedstudent on 10/06/22.
//

import SwiftUI

struct ImageView: View {
    var url:String?
    
    var body: some View {
        AsyncImage(
            url:URL(string: url ?? ""),
            content: { image in
                //p/workaround per le proporzioni delle immagini
                
                VStack {}
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay {
                    image.resizable().scaledToFill()
                }
            },
            placeholder: {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            })
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
