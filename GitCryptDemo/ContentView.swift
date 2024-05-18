//
//  ContentView.swift
//  GitCryptDemo
//
//  Created by Peter van den Hamer on 24/07/2022.
//

import SwiftUI

struct ContentView: View {
    private var payload: String = "" // contain the actual Secret or a dummy (unsecret), "" is overwirtten in init()

    init(secretFileName: String, unSecretFileName: String) {
        payload = getFileAsString(secretFilename: secretFileName, unsecretFileName: unSecretFileName)
    }

    var body: some View {

        ZStack {
            Color(.lightGray)
            VStack {
                Image(systemName: "globe")
                    .resizable()
                    .foregroundColor(.blue)
                    .frame(width: 50, height: 50)
                Text(payload) // in theory this might get localized
                    .foregroundColor(.black)
                    .font(.title)
            }
        }
        .frame(width: 300, height: 300)
        .border(.white)
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
    static let secretFileName = "Unsecret.txt"
    static let unSecretFileName = "Unsecret.txt"

    static var previews: some View {
        ContentView(secretFileName: secretFileName, unSecretFileName: unSecretFileName)
    }
}
