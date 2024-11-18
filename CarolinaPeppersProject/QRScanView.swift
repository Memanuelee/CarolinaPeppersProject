////
////  ScanQRView.swift
////  CarolinaPeppersProject
////
////  Created by Emanuele Bazzicalupo on 09/11/24.
////
//
//import SwiftUI
//import CodeScanner
//
//func convertImage(image: UIImage) -> CVPixelBuffer? {
//      
//        let newSize = CGSize(width: 224.0, height: 224.0)
//        UIGraphicsBeginImageContext(newSize)
//        image.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
//        
//        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
//            return nil
//        }
//        
//        UIGraphicsEndImageContext()
//        
//        // convert to pixel buffer
//        
//        let attributes = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
//                          kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
//        var pixelBuffer: CVPixelBuffer?
//        let status = CVPixelBufferCreate(kCFAllocatorDefault,
//                                         Int(newSize.width),
//                                         Int(newSize.height),
//                                         kCVPixelFormatType_32ARGB,
//                                         attributes,
//                                         &pixelBuffer)
//        
//        guard let createdPixelBuffer = pixelBuffer, status == kCVReturnSuccess else {
//            return nil
//        }
//        
//        CVPixelBufferLockBaseAddress(createdPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
//        let pixelData = CVPixelBufferGetBaseAddress(createdPixelBuffer)
//        
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        guard let context = CGContext(data: pixelData,
//                                      width: Int(newSize.width),
//                                      height: Int(newSize.height),
//                                      bitsPerComponent: 8,
//                                      bytesPerRow: CVPixelBufferGetBytesPerRow(createdPixelBuffer),
//                                      space: colorSpace,
//                                      bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) else {
//                                        return nil
//        }
//        
//        context.translateBy(x: 0, y: newSize.height)
//        context.scaleBy(x: 1.0, y: -1.0)
//        
//        UIGraphicsPushContext(context)
//        resizedImage.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
//        UIGraphicsPopContext()
//        CVPixelBufferUnlockBaseAddress(createdPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
//        
//        return createdPixelBuffer
//    }
//
//let resultLable : UILabel = {
//    let resultLable = UILabel()
//    resultLable.textColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
//    resultLable.text = "Select an Image"
//    resultLable.font = UIFont.boldSystemFont(ofSize: 30)
//    resultLable.translatesAutoresizingMaskIntoConstraints = false
//    return resultLable
//}()
//
//struct QRScanView: View {
//    
//    @Environment(\.dismiss) var dismiss
//
//    let mobilenet = MobileNetV2()
//    
//    func predictImage(image:UIImage) {
//        if let imagebuffer = convertImage(image: image) {
//            do {
//                let predection = try mobilenet.prediction(image: imagebuffer)
//                resultLable.text = predection.classLabel
//            } catch let error {
//                print("ERROR", error)
//            }
//        }
//    }
//    
//    var body: some View {
////        CodeScannerView(codeTypes: [.qr], show scanMode: .once) { _ in
////            print("Polo")
////            dismiss()
////        }
//        
//        CodeScannerView(codeTypes: [.qr], showViewfinder: true, simulatedData: "Paul Hudson") { response in
//            switch response {
//            case .success(let result):
//                print("Found code: \(result.string)")
////                predictImage(image: response)
//                dismiss()
//                
//            case .failure(let error):
//                print(error.localizedDescription)
//                dismiss()
//            }
//        }
//    }
//}
//
//struct QRScanView_Previews: PreviewProvider {
//    static var previews: some View {
//        QRScanView()
//    }
//}
