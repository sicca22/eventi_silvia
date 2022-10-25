//
//  EditProfileView.swift
//  eventi_silvia
//
//  Created by iedstudent on 25/10/22.
//

import SwiftUI


struct EditProfileView: View {
    
    @State private var email = " "
    @State private var emailPLaceholder = "silvia@email.it"
    @State private var name = " "
    @State private var namePLaceholder = "silviacicala"
    //per chiudere la pagina direttamente
    @Environment(\.presentationMode) private var presentationMode
    
    enum Field: Int, Hashable {
        case email
        case name
    }
    @FocusState private var focused: Field?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Email")
                    TextField("\(emailPLaceholder)",text: $email)
                        .focused($focused, equals: .email)
                        .onSubmit {
                            focused = .name
                        }
                    
                    Text("Nome")
                    TextField("\(namePLaceholder)",text: $name)
                    
                    Text("Cognome")
                    TextField("\(emailPLaceholder)",text: $email)
                    
                    Text("Data di nascita")
                    TextField("\(emailPLaceholder)",text: $email)
                    
                    Text("Città")
                    TextField("\(emailPLaceholder)",text: $email)
                }
                .padding()
            }
            .navigationTitle("Modifica profilo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismissModal()
                        }label: {
                            Image(systemName:  "xmark")
                        }
                    }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismissModal()
                    }label: {
                        Image(systemName:  "checkmark")
                    }
                }
                }
            .onAppear{
                email = LoginHelper.shared.loggedUser?.email ?? ""
            }
            
        }
    }
    //funzione da richiamare per chiudere questa pagina
    private func dismissModal() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        LoginHelper.shared.load()
        return EditProfileView()
    }
    
}
