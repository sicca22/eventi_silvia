//
//  EditProfileView.swift
//  eventi_silvia
//
//  Created by iedstudent on 25/10/22.
//

import SwiftUI
import DBNetworking


struct EditProfileView: View {
    
    //per chiudere la pagina direttamente
    @Environment(\.presentationMode) private var presentationMode
    //variabile per ricaricare la pagine dell'utente
    @Binding var refreshUser: Bool
    @State private var email = ""
    @State private var emailPlaceholder = ""
    @State private var emailError = false
    @State private var name = ""
    @State private var namePlaceholder = ""
    @State private var nameError = false
    @State private var surname = ""
    @State private var surnamePlaceholder = ""
    @State private var surnameError = false
    @State private var bornDate = ""
    @State private var bornDatePlaceholder = ""
    @State private var city = ""
    @State private var cityPlaceholder = ""
    //indica quando è possibile salvarel'utente
    @State private var canSave = true
    
    
    //enum Field: Int, Hashable {
    // case email
    // case name
    // }
    //@FocusState private var focused: Field?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    //Text("Email")
                   // TextField("\(emailPLaceholder)",text: $email)
                      //  .focused($focused, equals: .email)
                    //    .onSubmit {
                           // focused = .name
                        //}
                    
                   CustumTextField(
                   title: "Email", placeholder: "email", text: $email
                   , isError: emailError
                   )
                   .onChange(of: email) { _ in
                       validateForm()
                   }
                    CustumTextField(
                    title: "Nome", placeholder: "Nome", text: $name, isError:nameError
                    )
                    .onChange(of: name) { _ in
                        validateForm()
                    }
                    CustumTextField(
                    title: "Cognome", placeholder: "Cognome", text: $surname, isError:surnameError
                    )
                    .onChange(of: surname) { _ in
                        validateForm()
                    }
                    CustumTextField(
                    title: "Data di nascita", placeholder: "Data di nascita", text: $bornDate
                    )
                    CustumTextField(
                    title: "Città", placeholder: "Città", text: $city
                    )
                    
                
                }
                .padding()
            }
            .navigationTitle("Modifica profilo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                    
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task{
                       await updateUserToServer()
                        }
                    }label: {
                        Image(systemName:  "checkmark")
                            
                    }
                    .disabled(canSave == false)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismissModal()
                    }label: {
                        Image(systemName:  "xmark")
                    }
                }
                }
            .onAppear{
                email = LoginHelper.shared.loggedUser?.email ?? ""
                emailPlaceholder = LoginHelper.shared.loggedUser?.email ?? ""
                name = LoginHelper.shared.loggedUser?.firstName ?? ""
                namePlaceholder = LoginHelper.shared.loggedUser?.firstName ?? ""
                surname = LoginHelper.shared.loggedUser?.lastName ?? ""
                surnamePlaceholder = LoginHelper.shared.loggedUser?.lastName ?? ""
                bornDate = LoginHelper.shared.loggedUser?.birthDate ?? ""
                bornDatePlaceholder = LoginHelper.shared.loggedUser?.birthDate ?? ""
                city = LoginHelper.shared.loggedUser?.city ?? ""
               cityPlaceholder = LoginHelper.shared.loggedUser?.city ?? ""
            }
            
        }
    }
    //funzione da richiamare per chiudere questa pagina
    private func dismissModal() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func validateForm() {
       //il nome deve andare in errore se è vuoto e h ameno di tre caratteri
        emailError = StringHelper.isValidEmail(email) == false
        //aggiorno il pulsante per salvare i dati
        canSave = isFormValid()
    }
    func isFormValid() -> Bool {

     // emailError == false
        return true
    }
   @MainActor func updateUserToServer()async {
//creo la lista dei parametri da inviare al server(solo qulli modifcati )
        var parameters = [String: String]()
        //metto l'email solo se non è vuota
        if email.isEmpty == false {
            parameters["email"] = self.email
           
        }
       if name.isEmpty == false {
           
           parameters["firstName"] = self.name
           
       }
       if surname.isEmpty == false {
           
           parameters["lastName"] = self.surname
           
       }
       if bornDate.isEmpty == false {
          
           parameters["birthDate"] = self.bornDate
           
       }
       if city.isEmpty == false {
          
           parameters["city"] = self.city
       }
       
       
        let request = DBNetworking.request(
            url: "https://edu.davidebalistreri.it/app/v2/user",
            type: .put,
            authToken: LoginHelper.shared.loggedUser?.authToken,
            parameters: parameters
        )
        let response = await request.response(type: ResponseModel.self)
       //controllo se la richiesta è eandata a buon fine
       if let updateUser = response.body?.data {
           //aggiorno l'utente connesso
           LoginHelper.shared.save(userToSave: updateUser)
           refreshUser = true
           //chiudo qyesta pagina
           dismissModal()
       }
    }
}



struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        LoginHelper.shared.load()
        return EditProfileView(refreshUser: .constant(false))
    }
    
}


