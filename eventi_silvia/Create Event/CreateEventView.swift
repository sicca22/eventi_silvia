//
//  CreateEventView.swift
//  eventi_silvia
//
//  Created by iedstudent on 15/11/22.
//

import SwiftUI
import DBNetworking

//@State var goToNext = true

struct CreateEventView: View {
    var body: some View {
        NavigationView {
            
           
                Text("pagina uno nome descrizione prezzo")
          
            
            //   NavigationLink (destination: CreateEventAdressView(),
                              // isActive: $goToNext)
                .navigationTitle("Crea il tuo evento")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                        
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            //dismissModal()
                        }label: {
                            Image(systemName:  "xmark")
                        }
                        Button {
                          
                        }label: {
                            Image(systemName:  "xmark")
                        }
                        
                       
                    }
                    }
        }
        
       
        
    }
    
}

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
    }
}
