//
//  MovieWebViewController.swift
//  Movies
//
//  Created by Dulio Denis on 12/3/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit

class MovieWebViewController: UIViewController {
    
    @IBOutlet weak var movieWebView: UIWebView!
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(movie?.title)
    }
    
    
}
