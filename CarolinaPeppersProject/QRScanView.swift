//
//  ScanQRView.swift
//  CarolinaPeppersProject
//
//  Created by Emanuele Bazzicalupo on 09/11/24.
//

import SwiftUI
import CodeScanner

struct QRScanView: View {
    
    var body: some View {
        CodeScannerView(codeTypes: [.qr], scanMode: .oncePerCode) { _ in
            print("Memanuele")
        }
    }
}

struct ScanQRView_Previews: PreviewProvider {
    static var previews: some View {
        QRScanView()
    }
}
