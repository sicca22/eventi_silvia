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
    //solo per dimostrare che funziona
    @State private var tokenRicevuto = " Fai il log inhahahah "
    

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
            //aggiungi cose text field
            

            Spacer()
            
            
            HStack {
                Spacer()
                Text("\(tokenRicevuto)")
                    .font(.system(size:16, weight:.medium))
                Spacer()
            }
            Spacer()
            VStack {

                HStack(spacing: 0) {

                    Text ("Non hai un account?")

                    Text("Registrati")

                        .bold()

                }

                Button{
                    Task {
                        await login()
                    }
                } label: {

                    Text ("Accedi")

                        .font(.system(size: 18).bold())

                        .foregroundColor(.white)

                        .padding()

                        .frame(maxWidth: .infinity)
                    

                }

                .background(Color(hex: 0xBA3FF4)  )
                .cornerRadius(16)
            }

            

        }

      

        .navigationTitle("Bentornato")

        .padding()

    }
    func login() async {
        //Richiesta di web con DbNetmarketin
        let request = DBNetworking.request(
            url: "https://edu.davidebalistreri.it/app/v2/login",
            type: .post,
            
            parameters: [
                "email":self.email,
                "password":self.password,
            ])
        let response = await request.response(type: ResponseModel.self)
        tokenRicevuto = response.body?.data?.authToken ?? "hai sbagliato ad inserire le credenziali"
        //fake
        withAnimation {
            LoginHelper.shared.save()
        }
    }

}

struct LoginViews_Previews: PreviewProvider {

    static var previews: some View {

        NavigationView {

            LoginView()

        }

    }

}
