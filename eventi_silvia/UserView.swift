//
//  UserView.swift
//  eventi_silvia
//
//  Created by Silvia Cicala on 10/01/23.
//
import DBNetworking

import SwiftUI

struct UserView: View {
    var userToShow : UserModel
    @State var eventsToShow: [EventModel] = []
    @State private var isSendingEvent = false

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 16) {
                ImageView(url:userToShow.avatarUrl ?? "https://images.unsplash.com/photo-1675055621614-145f5e549106?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80" )
                    .frame(width: 160, height:160)
                    .clipShape(Circle())
                    .padding(.bottom)
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(userToShow.firstName ?? "").bold()
                //uiImage: event.photo ?? UIImage()
                 // Image(uiImage: event.photo ?? UUImage())
                    //   .resizable()
                      //  .scaledToFill()
                        //.frame(height: 200)
                        //.cornerRadius(24)
                        //.clipped()
                }
                
                VStack(alignment: .leading) {
                    Text(userToShow.lastName ?? "").bold()
                    
                        .foregroundColor(Color("secondaryColor"))
                }
                
                VStack(alignment: .leading) {
                    Text(userToShow.birthDate ?? "").bold()
                    
                        .foregroundColor(Color("secondaryColor"))
                }
                
                VStack(alignment: .leading) {
                    Text(userToShow.city ?? "").bold()
                    
                        .foregroundColor(Color("secondaryColor"))
                }
                Text("eventi creati \(eventsToShow.count)")
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack{
                        
                        ForEach(eventsToShow){ event in
                            //card event
                            HStack{
                                ImageView(url: event.coverUrl ?? "")
                                    .frame(width: 100, height:100)
                                    .clipShape(Circle())

                                VStack (alignment: .leading){
                                    Text("\(event.name ?? "")")
                                        .bold()
                                    Text("Prezzo \(event.price ?? 0)€")
                                }
                                
                                
                            }
                            
                            .padding()
                            .background(.black.opacity(0.1))
                            .cornerRadius(12)
                            
                        }
                        
                    }
                    .padding(16)
                }
                //$eventToShow.user.firstName ?? user?.lastName ?? ""
            
                
               
                NavigationLink(destination: CameraView(contents: [userToShow.ar ?? ARContent()])) {
                    Text("visualizza ogetto ar ")
                        .foregroundColor(.red)
                }
                .onAppear{
                    Task{
                        await updateEvents()
                    }
                    
                }
                                
                
                
                
            }
            .padding(24)
         
            
            
        }
    }
    @MainActor func updateEvents() async {
        eventsToShow = await DBNetworking
            .request(url: "https://edu.davidebalistreri.it/app/v2/user/\(userToShow.id ?? 1)/events")
            .response(type: EventResponse.self)
            .body?.data ?? []
    }
}



struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        LoginHelper.shared.load()
        return UserView (
            userToShow: UserModel(
                id:1,
                email: "mail@mail.com",
                firstName:"silvia",
                lastName:"cicala",
                birthDate:"06/03/2002",
                city:"Roma"
            )
        )
        
    }
}
//40
