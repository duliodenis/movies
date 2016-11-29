//
//  MoviesViewController.swift
//  Movies
//
//  Created by Dulio Denis on 11/26/16.
//  Copyright © 2016 Dulio Denis. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var urlOMDB = "https://www.omdbapi.com/?s=Antitrust"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        moviesDownload(urlString: urlOMDB) { (array) in
            // TODO
        }
    }
    
    
    func moviesDownload(urlString: String, completion: (_ array:NSArray)->()) {
        let url = URL(string: urlString)
        let session = URLSession.shared
        let request = session.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                if let validData = data {
                    do {
                        let jsonDictionary = try JSONSerialization.jsonObject(with: validData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        
                        let movieArray = jsonDictionary["Search"] as! NSArray
                        print(movieArray)
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        request.resume()
    }
    
}


// MARK: - TableView Delegate and Data Source Methods

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        cell.textLabel?.text = "Movie \(indexPath.row + 1)"
        return cell
    }
    
}
