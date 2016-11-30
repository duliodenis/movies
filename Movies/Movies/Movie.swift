//
//  Movie.swift
//  Movies
//
//  Created by Dulio Denis on 11/30/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit

class Movie: NSObject {
    
    var title: String?
    var year: String?
    var imdbID: String?
    var type: String?
    var thumbnail: String?
    
    init(title: String, year: String, ID: String, type: String, thumbnail: String) {
        self.title = title
        self.year = year
        self.imdbID = ID
        self.type = type
        self.thumbnail = thumbnail
    }
    
}
