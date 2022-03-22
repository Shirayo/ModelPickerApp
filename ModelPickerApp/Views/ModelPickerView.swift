//
//  ModelPickerView.swift
//  ModelPickerApp
//
//  Created by Vasili on 17.03.22.
//

import SwiftUI
import ARKit
import RealityKit
import Combine

struct ModelPickerView: View {
    
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    
    @State var progress: Double = 0
    @State var isModelLoading = false
    @State private var observation: NSKeyValueObservation?
    
    @Environment(\.presentationMode) var presentationMode
    
    var models: [String] = ["https://devimages-cdn.apple.com/ar/photogrammetry/AirForce.usdz",
    "https://devimages-cdn.apple.com/ar/photogrammetry/PegasusTrail.usdz",
    "https://developer.apple.com/augmented-reality/quick-look/models/biplane/toy_biplane.usdz",
    "https://developer.apple.com/augmented-reality/quick-look/models/drummertoy/toy_drummer.usdz"]
    
    var body: some View {
        GeometryReader { proxy in
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: proxy.size.width / 2 - 8, maximum: 600), spacing: 0),
            ], spacing: 0, content: {
                ForEach(models, id: \.self) { model in
                    Button {
                        let url = URL(string: model)!
                        print(model)
                        presentationMode.wrappedValue.dismiss()
                        loadFileAsync(url: url, isModelExist: $isModelLoading) { url, error in
                            guard let url = url else {
                                return
                            }
                            DispatchQueue.main.async {
                                var cancellable: AnyCancellable? = nil
                                cancellable = ModelEntity.loadModelAsync(contentsOf: url).sink { completion in
                                    cancellable?.cancel()
                                } receiveValue: { entity in
                                    isModelLoading = false
                                    isPlacementEnabled = true
                                    selectedModel = .init(entity: entity)
                                    cancellable?.cancel()
                                }
                            }
                            print(url.path)
                        }
                    } label: {
                        Image(systemName: "checkmark")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .background(.clear)
                            .frame(width: 150, height: 150)
                            .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }
            })
        }
        .background(BackgroundClearView())
    }
    
    func loadFileAsync(url: URL, isModelExist: Binding<Bool>, completion: @escaping (URL?, Error?) -> Void) {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            isModelExist.wrappedValue = true
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl, nil)
        }
        else
        {
            isModelExist.wrappedValue = false
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler:
            {
                data, response, error in
                observation?.invalidate()
                if error == nil
                {
                    if let response = response as? HTTPURLResponse
                    {
                        if response.statusCode == 200
                        {
                            if let data = data
                            {
                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                {
                                    completion(destinationUrl, error)
                                }
                                else
                                {
                                    completion(destinationUrl, error)
                                }
                            }
                            else
                            {
                                completion(destinationUrl, error)
                            }
                        }
                    }
                }
                else
                {
                    completion(destinationUrl, error)
                }
            })
//            observation = task.observe(\.fractionCompleted, changeHandler: { observationProgress, _ in
//                DispatchQueue.main.async {
//                    progress = observationProgress.fractionCompleted
//                }
//            })
            task.resume()
        }
    }

}

//func downloadFile(from url: URL, completion: @escaping (URL?, Error?) -> ()) {
//    var pathURL: URL? = nil
//    let session = URLSession.shared
//    let downloadTask = session.dataTask(with: url, completionHandler: T##(Data?, URLResponse?, Error?) -> Void)
//        guard let fileURL = url else { return }
//        completion(fileURL, nil)
//        }
//    downloadTask.resume()
//}
    


