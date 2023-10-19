//
//  UploadVC.swift
//  TheFirebaseAuthenticationJourneyOfTheDaringDuck
//
//  Created by Cenker Soyak on 18.10.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let uploadView = UIImageView()
    let uploadButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.uploadButton.isEnabled = false
    }
    func createUI(){
        view.backgroundColor = .white
        
        let photo = UIImage(systemName: "photo.artframe.circle")
        uploadView.image = photo
        uploadView.layer.borderColor = UIColor.black.cgColor
        uploadView.layer.borderWidth = 1
        uploadView.tintColor = .red
        uploadView.contentMode = .scaleAspectFit
        let gesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        uploadView.addGestureRecognizer(gesture)
        uploadView.isUserInteractionEnabled = true
        view.addSubview(uploadView)
        uploadView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.safeAreaLayoutGuide.snp.width).offset(-100)
            make.height.equalTo(view.safeAreaLayoutGuide.snp.height).offset(-410)
        }
        uploadButton.setTitle("Upload", for: .normal)
        uploadButton.isEnabled = false
        uploadButton.configuration = .filled()
        view.addSubview(uploadButton)
        uploadButton.addTarget(self, action: #selector(uploadButtonClicked), for: .touchUpInside)
        uploadButton.snp.makeConstraints { make in
            make.top.equalTo(uploadView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(uploadView.snp.width).dividedBy(2)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    @objc func chooseImage(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
        self.uploadButton.isEnabled = true
    }
    @objc func uploadButtonClicked(){
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("media")
        if let imageData = uploadView.image?.jpegData(compressionQuality: 0.5){
            let imageUUID = UUID().uuidString
            let imageReference = mediaFolder.child("\(imageUUID).jpeg")
            imageReference.putData(imageData) { metadata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            //Database
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreRef: DocumentReference?
                            
                            let firestorePost = ["imageUrl": imageUrl, "postedBy": Auth.auth().currentUser?.email!, "date": FieldValue.serverTimestamp()] as [String: Any]
                            
                            firestoreRef = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil{
                                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                } else{
                                    self.uploadView.image = UIImage(systemName: "photo.artframe.circle")
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                        }
                    }
                }
            }
        }
    }
}
