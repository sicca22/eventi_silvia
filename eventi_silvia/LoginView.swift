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
    @State private var tokenRicevuto = "  "
    

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
    
    //@MainActor serve ad eseguire le operazioni di aggiornamento UI sempre sul tread principale
    @MainActor func login() async {
        //Richiesta di web con DbNetmarketin
        let request = DBNetworking.request(
            url: "https://edu.davidebalistreri.it/app/v2/login",
            type: .post,
            
            parameters: [
                "email":self.email,
                "password":self.password,
            ])
        let response = await request.response(type: ResponseModel.self)
        
        //controllo se la richiesta è andata a buon fine
        if let descrizioneErrore = response.body?.error?.description {
            tokenRicevuto = descrizioneErrore
            return
        }
        tokenRicevuto = response.body?.data?.authToken ?? "Hai sbagliato ad inserire le credenziali!"
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
