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
                    Image("logo")
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color(.systemGray2))
                    
                    Text ("EventiLenti")
                        .font(.system(size: 24).bold())
                        .foregroundColor(Color("baseColor"))
                    
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
                
                .background(Color("baseColor2"))
                .cornerRadius(16)
                NavigationLink(destination: LoginView()) {
                Text ("Accedi")
                        .font(.system(size:18).bold())
                        .foregroundColor(Color("baseColor2"))
                        .padding()
                        .frame(maxWidth: .infinity)
                    
                    
            }
                .background(.white)
                .cornerRadius(16)
                
            }
            .padding(24)
            .navigationBarHidden(true)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
