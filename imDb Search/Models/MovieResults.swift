//
//  MovieResults.swift
//  imDb Search
//
//  Created by Kingsley Charles on 29/10/2020.
//

import Foundation

struct MovieResults : Codable
{
    let Title : String
    let Year : String
    let imdbID : String
    let Poster : String
    
    
    private enum Codingkeys : String , CodingKey
    {
        
    case Title , Year , ImdbID , Poster
        
    }
    
    
    
}
