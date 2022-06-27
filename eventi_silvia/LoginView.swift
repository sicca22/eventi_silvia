//
//  LoginView.swift
//  eventi_silvia
//
//  Created by iedstudent on 10/05/22.
//

import SwiftUI



struct LoginView: View {

    @State private var email: String = "silvia@email.it"

    @State private var password: String = "password"
    //solo per dimostrare che funziona

    

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

                .background(Color("baseColor2")  )
                .cornerRadius(16)
            }

        }

      

        .navigationTitle("Bentornato")
        .navigationBarHidden(true)
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
            //TODO: mostrare alert di errore
            
            
            return
        }
        
        //codice che certifica che il token è certificato
        
        
       if let user = response.body?.data {
           withAnimation{
               //sdalvo tutti i dati dell'utente
               LoginHelper.shared.save(userToSave: user)
           }
       } else {
           
       }
        //"Hai sbagliato ad inserire le credenziali!"
        //fake
        
    }

}

struct LoginViews_Previews: PreviewProvider {

    static var previews: some View {

        NavigationView {

            LoginView()

        }

    }

}
