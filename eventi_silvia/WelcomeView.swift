//
//  WelcomeView.swift
//  eventi_silvia
//
//  Created by iedstudent on 10/05/22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack {
                    Circle()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color(.systemGray2))
                    
                    Text ("NomeApp")
                        .font(.system(size: 24).bold())
                    
                }
                Spacer()
                Button {
                    //codice da eseguire quando di preme il bottone
                } label: {
                Text ("Registrati")
                        .font(.system(size:18).bold())
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                    
                    
            }
                
                .background(Color (hex : 0xBA3FF4))
                .cornerRadius(16)
                NavigationLink(destination: LoginView()) {
                Text ("Accedi")
                        .font(.system(size:18).bold())
                        .foregroundColor(Color (hex : 0xBA3FF4))
                        .padding()
                        .frame(maxWidth: .infinity)
                    
                    
            }
                .background(.white)
                .cornerRadius(16)
                
            }
            .padding(24)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
