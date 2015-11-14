//
//  Memories.swift
//  MyStory
//
//  Created by Jason Chen-Ju Hsieh on 11/11/15.
//  Copyright © 2015 Team 19. All rights reserved.
//

import UIKit

class Memories: NSObject, NSCoding {
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var photoDescription: String?
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("memories")
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let photoDescriptionKey = "photoDescription"
    }
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, photoDescription: String?) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.photoDescription = photoDescription
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty {
            return nil
        }
    }

    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(photoDescription, forKey: PropertyKey.photoDescriptionKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        let photoDescription = aDecoder.decodeObjectForKey(PropertyKey.photoDescriptionKey) as? String
        
        self.init(name: name, photo: photo, photoDescription: photoDescription)
    }
}
