//
//  ViewController.swift
//  imDb Search
//
//  Created by Kingsley Charles on 29/10/2020.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var textfield : UITextField!
    
    var movieArr = [MovieResults]()
    
  
    
    override func viewDidLoad()
    {
        tableView.register(MovieTableViewCell.uiNib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        textfield.delegate = self
    }
    
    func searchMovies()
    {
        movieArr.removeAll()
        
        textfield.resignFirstResponder()
        
        guard let text = textfield.text , text != ""
        else
        {
            print("text is nil")
            return
        }
        
        let newtext = text.replacingOccurrences(of: " ", with: "%20")
        
        let urlString = "http://www.omdbapi.com/?i=tt3896198&apikey=\(Constant.API_KEY)&s=\(newtext)"
        
        let url = URL(string: urlString)
        
        let urlSession = URLSession.shared
        
        let dataTask = urlSession.dataTask(with: url!) { (data, response, error ) in
            
            guard let data = data , error == nil
            else
            {
                return
                
            }
                do
                {
                    //Creates a json decoder
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(Movie.self, from: data)
                    
                    
                    //Update movies array
                    let finalMovies = result.Search
                    self.movieArr.append(contentsOf: finalMovies)
                    
                    
                    DispatchQueue.main.async
                    {
                        self.tableView.reloadData()
                    }
                    
                }
                
                catch
                {
                    print("Couldn't decode")
                    return
                    
                }
                
            } //End of datatask
        dataTask.resume()
        }
        
        
    }


extension ViewController : UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return movieArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        
        let currentMovie = movieArr[indexPath.row]
        
        cell.configure(movie: currentMovie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentMovie = movieArr[indexPath.row]
        
        let urlString = "https://www.imdb.com/title/\(currentMovie.imdbID)/"
        let url = URL(string: urlString)
        
        guard let urlS = url else
        {
            return
            
        }
        
        let VC = SFSafariViewController(url: urlS)
        present(VC, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        searchMovies()
        return true
    }
    
    
    
    
}

