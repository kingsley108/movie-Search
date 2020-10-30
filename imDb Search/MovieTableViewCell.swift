//
//  CustomTableViewCell.swift
//  imDb Search
//
//  Created by Kingsley Charles on 29/10/2020.
//

import UIKit

class MovieTableViewCell: UITableViewCell
{
    @IBOutlet var movieTitleLabel : UILabel!
    @IBOutlet var yearTitleLabel : UILabel!
    @IBOutlet var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static var identifier = "movieCellId"
    
    static func uiNib () -> UINib
    {
        return UINib(nibName: "MovieTableViewCell", bundle: nil)
        
    }
    
    func configure(movie : MovieResults)
    {
        movieTitleLabel.text = movie.Title
        yearTitleLabel.text = movie.Year
        let urlString = movie.Poster
        let url = URL(string: urlString)
        guard url != nil else
        {
            return
            
        }
        do
        {
            let data = try Data(contentsOf: url!)
            
            
            movieImageView.image = UIImage(data: data)
            
            
            
        }
        catch
        {
            return
            
        }
        
        // Added a comment
        
    }
    
}
