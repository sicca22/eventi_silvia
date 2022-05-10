//
//  LoginView.swift
//  eventi_silvia
//
//  Created by iedstudent on 10/05/22.
//

import SwiftUI



struct LoginView: View {

    @State private var email: String = ""

    @State private var password: String = ""

    

    var body: some View {

        VStack(alignment: .leading, spacing: 0 ) {

            Text("Inserisci tutti i dati per accedere")

                .padding()

            

            TextField("Email" , text: $email )

                .keyboardType(.emailAddress)

                .textInputAutocapitalization(.never)

                .disableAutocorrection(true)

                .padding()

                .font(.system(size: 16, weight: .medium ))

                .overlay {

                    RoundedRectangle(cornerRadius: 16)

                        .stroke(Color(hex: 0xDDDDDD), lineWidth: 1 )

                }

                .padding(.bottom)

            

            

            

            

            SecureField("Password" , text: $password )

                .padding()

                .font(.system(size: 16, weight: .medium ))

                .overlay {

                    RoundedRectangle(cornerRadius: 16)

                        .stroke(Color(hex: 0xDDDDDD), lineWidth: 1 )

                    

                }

                .padding(.bottom)

            HStack( spacing: 0 ) {

                

                Text ("Password dimenticata?")

                    .foregroundColor(Color(hex: 0x969696))

                Text ("Recuperala")

                    .bold()

            }

            Spacer()

            VStack {

                HStack(spacing: 0) {

                    Text ("Non hai un account?")

                    Text("Rrgistrati")

                        .bold()

                }

                Button{
                    login()
                } label: {

                    Text ("Accedi")

                        .font(.system(size: 18).bold())

                        .foregroundColor(.white)

                        .padding()

                        .frame(maxWidth: .infinity)

                }

                .background(Color(hex: 0xBA3FF4)  )            }

            

        }

      

        .navigationTitle("Bentornato")

        .padding()

    }
    func login() {
        
    }

}

struct LoginViews_Previews: PreviewProvider {

    static var previews: some View {

        NavigationView {

            LoginView()

        }

    }

}
