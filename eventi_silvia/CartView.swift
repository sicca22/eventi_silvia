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
           
                VStack {
                   
                    if cart.items.isEmpty{
                        Text("il carrello è vuoto")
                        
                    } else {
                        Text("hai \(cart.items.count)")
                    }
                    Text("costo totale" + cart.totalPriceString )
                        .padding(2)
                    
                    List {
                        ForEach(cart.items) { event in
                            HStack {
                            Text(event.name ?? "nessun evento")
                            Text(event.priceString )
                            }
                        }
                        .onDelete { indexSet in
                            //trasformo indexSet in un event model
                            if let index = indexSet.first {
                                let event = cart.items[index]
                                
                                //tolgo l'evento dal carrello
                                cart.remove(item: event)
                            }
                            
                        }
                    }
                    
                    
                   
                }
                
                
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
