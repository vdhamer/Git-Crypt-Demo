//
//  ContentView.swift
//  GitCryptDemo
//
//  Created by Peter van den Hamer on 24/07/2022.
//

import SwiftUI

struct ContentView: View {
    private var payload: String = "" // contain the actual Secret or a dummy (unsecret), "" is overwritten in init()

    init(secretFileName: String, unSecretFileName: String) {
        payload = getFileAsString(secretFilename: secretFileName, unsecretFileName: unSecretFileName)
    }

    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                Text(payload) // in theory this might get localized
                    .multilineTextAlignment(.center)
                    .lineLimit(4)
                    .foregroundColor(.primary)
                    .font(.title)
        }
        .frame(width: 300, height: 200)
        .border(.primary, width: 1)
    }

    private func getFileAsString(secretFilename: String, unsecretFileName: String) -> String {
        if let secret = readLineFromLocalFile(fileNameWithExtension: secretFilename) {
            return secret
        } else {
            if let unsecret = readLineFromLocalFile(fileNameWithExtension: unsecretFileName) {
                return unsecret
            } else {
                return "file \(unsecretFileName) looks encrypted"
            }
        }
    }

    private func readLineFromLocalFile(fileNameWithExtension: String) -> String? {
        let fileName = fileNameWithExtension.fileName()
        let fileExtension = fileNameWithExtension.fileExtension()
        if let filepath = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
            do {
                let firstLine = try String(contentsOfFile: filepath).components(separatedBy: "\n")[0]
                return firstLine // encypted version starts with hex 00 47 49 54 43 52 59 50 54 00 and is not a String
            } catch {
                print("Warning: \(error.localizedDescription) File is not a text file.")
                return nil
            }
        } else {
            print("Cannot find file \(fileNameWithExtension) from bundle")
            return("File missing!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let secretFileName = "Secret.txt"
    static let unSecretFileName = "Unsecret.txt"

    static var previews: some View {
        ContentView(secretFileName: secretFileName, unSecretFileName: unSecretFileName)
    }
}
