//
//  CreateEventCoverEvent.swift
//  eventi_silvia
//
//  Created by Silvia Cicala on 06/12/22.
//
import SwiftUI
import DBNetworking
struct CreateEventCoverView: View {
    @State var gotoNext = false
    @State private var isCangingImage = false
    @State var pickedImage : UIImage?
    @State var user = LoginHelper.shared.loggedUser
    @EnvironmentObject var event: CreatingEventModel

    var body: some View {
  
            VStack {
                Spacer()
                VStack {
                    
                    Image(uiImage: pickedImage ?? UIImage())
                    
                        .resizable()
                        .background(Color("baseColor"))
                        .scaledToFill()
                        .frame(height: 200)
                        .cornerRadius(24)
                        .clipped(antialiased: true)
                        .padding()
                
                    
                    Spacer()
                    
                    Button  {
                        isCangingImage.toggle()
                    } label: {
                        Text("Carica immagine")
                            .sheet(isPresented:$isCangingImage ) {
                                GalleryPicker(selectedImage: $pickedImage)
                            }
                            .onChange(of: pickedImage) { _ in
                                //eseguo codice quando un utente vuole cambiare un immagine
                                //self.sendAvatarToServer(avatar: pickedImage)
                                event.photo = pickedImage
                            }
                            .font(.system(size:16).bold())
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color("baseColor"))
                    .cornerRadius(16)
                    .padding(50)
                }
              
                HStack {
                    Button  {
                        gotoNext = true
                    } label: {
                        Text("Avanti")
                            .font(.system(size:16).bold())
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .background(Color("baseColor2"))
                    .cornerRadius(16)
                    .padding()
                    
                   
                }
               
            }
        NavigationLink(destination: CreateEventCheck(), isActive: $gotoNext) {}
            .opacity(0)
        
            .navigationTitle("Carica la Cover")
            
        
        
    }
    func sendAvatarToServer(avatar: UIImage?) {
        guard let avatar = avatar else {
            //non c'è nessun avatar da caricare
            return
        }
        //riduco limmagine
       let resized = UIHelper.resize(image: avatar,
                                     targetSize: CGSize (width: 500, height: 500))
        let compressed = UIHelper.compress(image: resized, compression: 0.8)
        let multipartFile = DBNetworking.MultipartFile(
            parameterName: "avatar",
            fileName: "avatar.jpg",
            mimeType: "avatar/jpg",
            data: compressed
        )
        
        //invio l'immagine al server
        let request = DBNetworking.request(
        url: "https://edu.davidebalistreri.it/app/postman",
        type: .multipartPost,
        authToken:LoginHelper.shared.loggedUser?.authToken,
        multipartFiles: [multipartFile]
        )
        Task{
            let response = await request.response(type:ResponseModel.self)
            if response.success {
                //avatar modificato correttamente
                if let updateUser = response.body?.data {
                    LoginHelper.shared.save(userToSave: updateUser)
                    user = updateUser
                }
                
            } else {
                
            }
        }
    }
}
struct CreateEventCoverView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventCoverView()
    }
}
