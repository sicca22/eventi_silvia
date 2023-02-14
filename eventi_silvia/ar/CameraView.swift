//
//  CameraView.swift
//  eventi_silvia
//
//  Created by Silvia Cicala on 17/01/23.
//

import SwiftUI
import AVFoundation
  import SceneKit
  import ARKit


struct CameraView: View {
    var contents:[ARContent] = []
    
  //  let videoPlayer: AVPlayer = {
    //        guard let url = Bundle.main.url(
    //            forResource: "snowboarding",
    //            withExtension: "mp4"
    //      ) else {
    //          return AVPlayer()
    //      }
           
    //         return AVPlayer(url: url)
    //  }()

    
    var body: some View {
        
        ARView(contents: contents)
      /*  ARView(
        contents: [
        ARContent(
        markerName: "MarkerImage1",
        scnName: "book.scn",
        nodeName: "book"
        
        ),
        ARContent(
        markerUrl: "https://edu.davidebalistreri.it/app/files/ar/MarkerImage2.jpg",
        scnObjectUrl: "https://edu.davidebalistreri.it/app/files/ar/mario.scn",
        scnTextureUrl: "https://edu.davidebalistreri.it/app/files/ar/marioD.jpg",
        nodeName: "mario",
        nodeScaleFactor: 0.0005,
        nodeRotationX: -90,
        nodePositionX: 0.02,
        nodePositionY: 0,
        nodePositionZ: 0.02
        ),
        ARContent(
            markerName: "MarkerImage3",
            scnName: "robot.scn",
            nodeName: "robot",
            nodeScaleFactor: 0.1,
            nodePositionX: 0,
            nodePositionY: 0,
            nodePositionZ: 0
            
        ),
        ARContent(
              markerName: "snowboarding",
              nodeRotationX: 90,
              onAddNode: { node, anchor in
                  guard let imageAnchor = anchor as? ARImageAnchor else { return }
                  
                  // Detected plane
                  let plane = SCNPlane(
                      width: imageAnchor.referenceImage.physicalSize.width,
                      height: imageAnchor.referenceImage.physicalSize.height
                  )
                  
                  plane.firstMaterial?.diffuse.contents = self.videoPlayer
                  
                  let planeNode = SCNNode(geometry: plane)
                  planeNode.eulerAngles.x = -.pi / 2
                  
                  node.addChildNode(planeNode)
                  
                  self.videoPlayer.play()
              }
          )
        
        ]
       ) */
        .background(.black)
        .ignoresSafeArea()
        
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
