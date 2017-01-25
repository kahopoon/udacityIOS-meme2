//
//  ViewController.swift
//  MeMe
//
//  Created by Ka Ho Poon on 22/1/2017.
//  Copyright © 2017 Ka Ho Poon. All rights reserved.
//

import UIKit

class AddNewVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextfield, bottomTextfield: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var toolBars: [UIToolbar]!
    
    var memedImage:UIImage!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    enum ButtonType: Int {
        case camera = 0, album
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        texfieldAttributesSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
    }

    @IBAction func imagePickerAction(_ sender: Any) {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        switch ButtonType(rawValue: (sender as! UIBarButtonItem).tag)! {
        case .camera:
            imagePicker.sourceType = .camera
        case .album:
            imagePicker.sourceType = .photoLibrary
        }
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func texfieldAttributesSetup() {

        for textField in textFields {
            
            let memeTextAttributes:[String:Any] = [
                NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                NSStrokeColorAttributeName: UIColor.black,
                NSForegroundColorAttributeName: UIColor.white,
                NSStrokeWidthAttributeName: -2.0]
            
            textField.defaultTextAttributes = memeTextAttributes
            textField.textAlignment         = .center
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == textField.placeholder {
           textField.text?.removeAll()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(_ notification:Notification) {
        
        if bottomTextfield.isEditing {
            // big thanks for this tip :D
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        
        if bottomTextfield.isEditing {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func save() {
        // Create the meme
        let meme = Meme(topText: topTextfield.text!, bottomText: bottomTextfield.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        Singleton.sharedInstace.appendMeMe(meme)
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        showToolbars(false)
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        showToolbars(true)
        
        return memedImage
    }
    
    func showToolbars(_ show: Bool) {
        for toolBar in toolBars {
            toolBar.isHidden = !show
        }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        
        memedImage = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        present(activityViewController, animated: true, completion: nil)
        activityViewController.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    @IBAction func dismissButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

