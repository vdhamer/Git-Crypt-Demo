//
//  GitCryptDemoApp.swift
//  GitCryptDemo
//
//  Created by Peter van den Hamer on 30/07/2022.
//

import SwiftUI

@main
struct GitCryptDemoApp: App {

    let secretFileName = "Secret.txt"
    let unSecretFileName = "Unsecret.txt"

    var body: some Scene {
        WindowGroup {
            ContentView(secretFileName: secretFileName, unSecretFileName: unSecretFileName)
        }
    }
}
