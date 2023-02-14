//
//  CartView.swift
//  eventi_silvia
//
//  Created by iedstudent on 10/06/22.
//

import SwiftUI

struct CartView: View {
    @StateObject var cart = CartHelper.shared
    
    //var itemsToShow: [CartModel (id:1, name:"evento")]
    
    var body: some View {
        
        
        NavigationView {
           
                VStack (alignment: .leading) {
                   
                    if cart.items.isEmpty{
                        Text("Il carrello è vuoto, procedi all'acquisto")
                        
                    } else {
                        Text("Ticket🎫 \(cart.items.count)")
                    }
                    Text("Totale provvisorio" + cart.totalPriceString )
                        .padding(2)
                    
                    List {
                        ForEach(cart.itemsTogether) { event in
                            HStack {
                                
                            Text(event.nameAndQuantity )
                            Text(event.totalPriceString )
                            }
                        }
                        .onDelete { indexSet in
                            //trasformo indexSet in un event model
                            if let index = indexSet.first {
                                let event = cart.items[index]
                                
                                //tolgo l'evento dal carrello
                                cart.removeAll(item: event)
                            }
                            
                        }
                    }
                    .listStyle(.plain)
                    
                    
                   
                }
                .padding()
                
                
            .navigationTitle("Carello")
            .navigationBarTitleDisplayMode(.inline)
              
        }
        
        
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
