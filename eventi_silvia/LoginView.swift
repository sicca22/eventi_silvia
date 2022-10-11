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
    
    //attivare o disattivare la password
    @State private var isSecure = true
    
    //stabilisco i campi di testo della pagina
    enum Field: Int, Hashable {
        case email
        case password
    }
     //var che indica il campo di testo selezionato
    @FocusState private var focused: Field?
    
    //mostra o nasconde la 'modale' del web registrati
    @State private var isShowingSingup = false
    var body: some View {

        VStack(alignment: .leading, spacing: 0 ) {

            Text("Inserisci tutti i dati per accedere")
                .padding()

      
            TextField("Email" , text: $email )
            //focused e onsubmit ti fa passsare da email a password con invio
            //nuova cosa apple
                .focused($focused, equals: .email)
                .onSubmit {
                    focused = .password
                }
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

            HStack {
                Group {
                //mostro la secure  o la text in base a isSecure
                if self.isSecure {
                    SecureField("Password" , text: $password )
                } else {
                    TextField("Password" , text: $password )
                }
                }
                .focused($focused, equals: .password)
                .onSubmit {
                    buttonLogin()
                }
                
                Button {
                    //codic e da eseguire quando si preme il bottone, emoji
                    //e per farlo bisogna invertire il boolean()true  isSecure
                    self.isSecure.toggle()
                } label: {
                
                    Image(systemName: isSecure ? "eye" : "eye.slash")
                            .tint(.black)
                    
                }
                    
            }
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
                //'link'questo metodo ti esce dalla tua appa e entra su internet
                Link(destination: URL(string:"https://www.google.it")!) {
                Text ("Recuperala")
                    .bold()
                    .foregroundColor(.blue)
                }
                
            }
            //aggiungi cose text field
            

            Spacer()
            
            
        
            Spacer()
            VStack {

                HStack(spacing: 0) {
                    Text ("Non hai un account?")
                    
                    Button {
                        //apro la modal con la sheet view
                        isShowingSingup = true
                    }label:{
                    Text("Registrati")
                        .bold()
                        .foregroundColor(.blue)
                        .sheet(isPresented: $isShowingSingup) {
                          
                            NavigationView {
                                WebView()
                                    .navigationBarTitleDisplayMode(.inline)
                                    .navigationTitle("Registrati")
                                    .toolbar {
                                        ToolbarItem(placement: .navigationBarTrailing) {
                                            Button {
                                                isShowingSingup = false
                                            }label: {
                                                Image(systemName: "xmark")
                                            }
                                        }
                                    }
                            }
                                //se lo metti decidi tu senno quello di sistema
                                //.foregroundColor(.blue)
                        }
                    }
                }

                Button{
                    buttonLogin()
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
    private func buttonLogin() {
        Task {
            //richiamo la funzione di log in
            await login()
        }
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
