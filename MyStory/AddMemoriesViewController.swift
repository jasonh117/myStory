//
//  AddMemoriesViewController.swift
//  MyStory
//
//  Created by Jason Chen-Ju Hsieh on 11/12/15.
//  Copyright © 2015 Team 19. All rights reserved.
//

import UIKit

class AddMemoriesViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var peopleInMemory: UITextField!
    @IBOutlet weak var photoOfMemory: UIImageView!
    @IBOutlet weak var infoAboutMemory: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var memory: Memories?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleInMemory.delegate = self
        infoAboutMemory.delegate = self
        
        if let memory = memory {
            navigationItem.title = memory.name
            peopleInMemory.text = memory.name
            photoOfMemory.image = memory.photo
            infoAboutMemory.text = memory.photoDescription
        }
        
        checkValidMemoryName()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMemoryName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidMemoryName() {
        // Disable the Save button if the text field is empty.
        let text = peopleInMemory.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    // MARK: UITextViewDelegate
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            infoAboutMemory.resignFirstResponder()
            return false
        }
        return true
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoOfMemory.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMemoryMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMemoryMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = peopleInMemory.text ?? ""
            let photo = photoOfMemory.image
            let photoDescription = infoAboutMemory.text ?? ""

            memory = Memories(name: name, photo: photo, photoDescription: photoDescription)
        }
    }

    
    // MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        peopleInMemory.resignFirstResponder()
        infoAboutMemory.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
}
