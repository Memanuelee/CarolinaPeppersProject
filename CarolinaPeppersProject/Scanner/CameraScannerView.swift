//
//  CameraScannerView.swift
//  CarolinaPeppersProject
//
//  Created by Emanuele Bazzicalupo on 19/11/24.
//

import SwiftUI
import CoreML
import Vision
import AVFoundation

struct CameraScannerView: View {
    @State private var isPresentingCamera = false
    @State private var image: UIImage?
    @State private var resultText: String = "Scan a plastic item to check recyclability"
    @State private var showPermissionAlert = false

    var body: some View {
        VStack {
            Text("Plastic Bottle Scanner")
                .font(.largeTitle)
                .padding()

            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            }

            Text(resultText)
                .font(.headline)
                .padding()

            Button("Scan item") {
                checkCameraAuthorization()
            }
            .padding()
            .sheet(isPresented: $isPresentingCamera) {
                ImagePicker(image: $image, onImagePicked: classifyImage)
            }
            .alert(isPresented: $showPermissionAlert) {
                Alert(
                    title: Text("Camera Access Required"),
                    message: Text("Please enable camera access in Settings to use this feature."),
                    primaryButton: .default(Text("Open Settings")) {
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(settingsURL)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }

    func checkCameraAuthorization() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            isPresentingCamera = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        isPresentingCamera = true
                    } else {
                        showPermissionAlert = true
                    }
                }
            }
        case .denied, .restricted:
            showPermissionAlert = true
        @unknown default:
            showPermissionAlert = true
        }
    }

    func classifyImage(image: UIImage?) {
        guard let image = image else {
            resultText = "No image to classify."
            return
        }

        // Use the new `init(configuration:)` for model configuration
        let configuration = MLModelConfiguration()
        guard let model = try? VNCoreMLModel(for: Plasticclassifier(configuration: configuration).model) else {
            resultText = "Failed to load the model."
            return
        }

        guard let ciImage = CIImage(image: image) else {
            resultText = "Invalid image."
            return
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation], let topResult = results.first {
                DispatchQueue.main.async {
                    if topResult.confidence > 0.7 {
                        resultText = "This item is \(topResult.identifier)"
                    } else {
                        resultText = "Could not determine recyclability."
                    }
                }
            } else {
                DispatchQueue.main.async {
                    resultText = "Prediction error: \(error?.localizedDescription ?? "Unknown error")."
                }
            }
        }

        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        DispatchQueue.global().async {
            do {
                try handler.perform([request])
            } catch {
                DispatchQueue.main.async {
                    resultText = "Failed to perform classification: \(error.localizedDescription)"
                }
            }
        }
    }
}
