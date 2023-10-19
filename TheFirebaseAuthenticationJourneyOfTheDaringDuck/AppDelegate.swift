//
//  AppDelegate.swift
//  TheFirebaseAuthenticationJourneyOfTheDaringDuck
//
//  Created by Cenker Soyak on 18.10.2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    override init() {
        FirebaseApp.configure()
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        if Auth.auth().currentUser != nil {
            window?.rootViewController = TabBarVC()
        } else {
            window?.rootViewController = RegisterVC()
        }
        window?.makeKeyAndVisible()
        let db = Firestore.firestore()
        return true
    }
}
