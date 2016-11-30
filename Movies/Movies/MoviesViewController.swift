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
    var movies:[Movie] = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        moviesDownload(urlString: urlOMDB) { (array) in
            self.movies = array
            self.tableView.reloadData()
        }
    }
    
    
    func moviesDownload(urlString: String, completion: @escaping (_ array:[Movie])->()) {
        var movies:[Movie] = [Movie]()
        
        let url = URL(string: urlString)
        let session = URLSession.shared
        let request = session.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                if let validData = data {
                    do {
                        let jsonDictionary = try JSONSerialization.jsonObject(with: validData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        
                        let movieArray = jsonDictionary["Search"] as! NSArray
                        
                        for movie in movieArray {
                            let movieDictionary = movie as! NSDictionary
                            
                            let title = movieDictionary["Title"] as! String
                            let year = movieDictionary["Year"] as! String
                            let ID = movieDictionary["imdbID"] as! String
                            let type = movieDictionary["Type"] as! String
                            let thumbnail = movieDictionary["Poster"] as! String
                            
                            let movie = Movie(title: title, year: year, ID: ID, type: type, thumbnail: thumbnail)
                            
                            movies.append(movie)
                        }
                        completion(movies)
                        
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
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        
        let movie = movies[indexPath.row] as Movie
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.year
        
        return cell
    }
    
}
