//
//  ARView.swift
//  Eventi Balistreri
//
//  Created by Balistreri Davide on 15/01/23.
//
//
//  ARView.swift
//  Eventi Balistreri
//
//  Created by Balistreri Davide on 15/01/23.
//

import SwiftUI
import UIKit

// Framework per la realtÃ  aumentata:
import ARKit
import SceneKit

struct ARView: UIViewRepresentable {
    
    /// Lista dei marker che la view deve riconoscere e degli oggetti 3D che deve aggiungere.
    public var contents: [ARContent] = []
    
    
    private let sceneView = ARSCNView()
    
    func makeUIView(context: Context) -> ARSCNView {
        sceneView.delegate = context.coordinator
        
        // Configurazione
        let configuration = ARImageTrackingConfiguration()
        configuration.maximumNumberOfTrackedImages = 3
        
        // Configuro la sessione
        sceneView.antialiasingMode = .multisampling4X
        sceneView.automaticallyUpdatesLighting = true
        sceneView.autoenablesDefaultLighting = true
        
        // Tap recognizer per riconoscere quando vengono tappati gli oggetti 3D
        sceneView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.tapRecognizer(_:))
            )
        )
        
        // Avvio la sessione AR
        sceneView.session.run(configuration)
        
        Task { try? await setupContents() }
        
        return sceneView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    static func dismantleUIView(_ sceneView: ARSCNView, coordinator: ()) {
        sceneView.session.pause()
    }
    
    func makeCoordinator() -> Coordinator {
        // La classe "coordinatore" creata qui sotto
        // sarÃ  il delegate della scene view AR
        return Coordinator(self)
    }
    
    
    class Coordinator: NSObject, ARSCNViewDelegate {
        
        let parent: ARView
        
        init(_ parent: ARView) {
            self.parent = parent
        }
        
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            // Proseguo solo se ha riconosciuto una delle reference image
            guard let imageAnchor = anchor as? ARImageAnchor else { return }
            
            Task { @MainActor in
                // Prendo il content relativo alla reference image riconosciuta
                let content = parent.contents.first {
                    $0.markerUrl == imageAnchor.referenceImage.name ||
                    $0.markerName == imageAnchor.referenceImage.name
                }
                
                print("Marker trovato: \(content?.markerUrl ?? content?.markerName ?? "")")
                
                if content?.onAddNode != nil {
                    // Richiamo la funzione custom
                    content?.onAddNode?(node, anchor)
                } else if content != nil {
                    // Aggiungo l'oggetto 3D sulla scena AR
                    addContent(content!, to: node)
                }
            }
        }
        
        /// Funzione che viene richiamata quando viene tappato un oggetto sulla SceneView
        @objc func tapRecognizer(_ sender: UIGestureRecognizer) {
            let sceneView = parent.sceneView
            
            // Prendo la posizione del tocco all'interno della SceneView
            let location = sender.location(in: sender.view)
            
            // Prendo gli oggetti 3D alla posizione tappata
            let results = sceneView.hitTest(location, options: [.boundingBoxOnly: true])
            
            // Controllo se esiste un content relativo all'oggetto 3D tappato
            let content = parent.contents.first { $0.nodeName == results.first?.node.name }
            
            if content != nil {
                print("Oggetto 3D toccato: \(content?.nodeName ?? "")")
                
                // Eseguo la funzione onTap
                content?.onTap?()
            }
        }
        
        private func addContent(_ content: ARContent, to node: SCNNode) {
            var scene: SCNScene?
            
            if content.markerUrl?.isEmpty == false {
                // Oggetto da internet
                guard let fileUrl = ARView.locate(url: content.scnObjectUrl) else { return }
                scene = try? SCNScene(url: fileUrl)
            } else {
                scene = SCNScene(named: content.scnName ?? "")
            }
            
            guard scene != nil else {
                print("Oggetto 3D non valido")
                return
            }
            
            // Creo l'oggetto 3D da aggiungere alla scena AR
            let childNode = scene?.rootNode.childNode(withName: content.nodeName ?? "", recursively: false)
            
            guard childNode != nil else {
                print("Node name non valido")
                return
            }
            
            // Ridimensiono l'oggetto 3D prima di aggiungerlo alla scena
            let scaleFactor = content.nodeScaleFactor ?? 0.05
            childNode?.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
            
            // Spostamento
            childNode?.position.x = content.nodePositionX ?? 0
            childNode?.position.y = content.nodePositionY ?? 0
            childNode?.position.z = content.nodePositionZ ?? 0
            
            // Rotazione
            childNode?.eulerAngles.x = (content.nodeRotationX ?? 0) * .pi / 180
            childNode?.eulerAngles.y = (content.nodeRotationY ?? 0) * .pi / 180
            childNode?.eulerAngles.z = (content.nodeRotationZ ?? 0) * .pi / 180
            
            // Lo aggiungo alla scena
            node.addChildNode(childNode!)
            print("Oggetto 3D aggiunto: \(content.nodeName ?? "")!")
        }
    }
    
}


struct ARContent: Codable {
    
    /// Es: "MarkerImage1"
    var markerName: String?
    
    /// Se presente, l'immagine del marker verrÃ  scaricata da internet
    var markerUrl: String?
    
    /// Es: 0.05 metri
    var markerPhysicalWidth: Double? = 0.05
    
    /// Es: "book.scn"
    var scnName: String?
    
    /// Se presente, l'oggetto 3D verrÃ  scaricato da internet
    var scnObjectUrl: String?
    
    /// Se presente, la texture dell'oggetto 3D verrÃ  scaricata da internet
    var scnTextureUrl: String?
    
    /// Versione multi-texture: se presenti, le texture dell'oggetto 3D verranno scaricate da internet
    var scnTextureUrls: [String]?
    
    /// Es: "book"
    var nodeName: String?
    
    /// Es: 0.05
    var nodeScaleFactor: Double? = 0.05
    
    /// Rotazione (es: 90 gradi)
    var nodeRotationX: Float? = 0
    var nodeRotationY: Float? = 0
    var nodeRotationZ: Float? = 0
    
    /// Traslazione (es. 0.02)
    var nodePositionX: Float? = 0
    var nodePositionY: Float? = 0.02
    var nodePositionZ: Float? = 0
    
    private enum CodingKeys: String, CodingKey {
        case markerName, markerUrl, markerPhysicalWidth, scnName, scnObjectUrl, scnTextureUrl, scnTextureUrls, nodeName, nodeScaleFactor, nodeRotationX, nodeRotationY, nodeRotationZ, nodePositionX, nodePositionY, nodePositionZ
    }
    
    /// Quando viene tappato l'oggetto 3D
    var onTap: (() -> Void)?
    
    /// Per aggiungere un oggetto 3D custom
    var onAddNode: ((_ node: SCNNode, _ anchor: ARAnchor) -> Void)?
    
}


extension ARView {
    
    private func setupContents() async throws {
        let session = await sceneView.session
        
        guard
            let configuration = session.configuration as? ARImageTrackingConfiguration
        else {
            return
        }
        
        var referenceImages: [ARReferenceImage] = []
        
        for content in contents {
            if content.markerUrl?.isEmpty == false {
                // Async content
                guard
                    let markerUrl = try await ARView.downloadAndSave(url: content.markerUrl)
                else {
                    continue
                }
                
                try await ARView.downloadAndSave(url: content.scnObjectUrl)
                try await ARView.downloadAndSave(url: content.scnTextureUrl)
                
                // Multiple textures
                for url in content.scnTextureUrls ?? [] {
                    try await ARView.downloadAndSave(url: url)
                }
                
                guard
                    let markerImage = UIImage(contentsOfFile: markerUrl.path)?.cgImage
                else {
                    continue
                }
                
                let referenceImage = ARReferenceImage(
                    markerImage,
                    orientation: CGImagePropertyOrientation.up,
                    physicalWidth: content.markerPhysicalWidth ?? 0.05
                )
                
                referenceImage.name = content.markerUrl
                referenceImages.append(referenceImage)
            } else {
                // Continuo solo se ci sono tutti i dati necessari
                guard
                    let image = UIImage(named: content.markerName ?? "")?.cgImage
                else {
                    continue
                }
                
                // Creo una reference image per ogni "content" specificato
                let referenceImage = ARReferenceImage(
                    image,
                    orientation: CGImagePropertyOrientation.up,
                    physicalWidth: content.markerPhysicalWidth ?? 0.05
                )
                
                referenceImage.name = content.markerName
                referenceImages.append(referenceImage)
            }
        }
        
        configuration.trackingImages = Set(referenceImages)
        session.run(configuration)
    }
    
    @discardableResult
    static func downloadAndSave(url urlString: String?) async throws -> URL? {
        // Download
        guard let url = URL(string: urlString ?? "") else { return nil }
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        // Save
        guard let fileURL = ARView.locate(url: urlString) else { return nil }
        try data.write(to: fileURL)
        
        // Return path
        return fileURL
    }
    
    static func locate(url urlString: String?) -> URL? {
        guard let url = URL(string: urlString ?? "") else { return nil }
        let fileName = url.lastPathComponent
        
        let fileURL = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ).appendingPathComponent(fileName, isDirectory: false)
        
        return fileURL
    }
}
