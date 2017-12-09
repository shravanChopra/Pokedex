//
//  ViewController.swift
//  Pokedex
//
//  Created by Shravan Chopra on 09/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    var pokemonData: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pokemonData = loadPokemonData(fileName: "pokemon")
        
        if let pokemonData = pokemonData {
             print(pokemonData)
        }
    }

    // Function: reads the pokemon data file and returns the contents as a single string
    func loadPokemonData(fileName: String) -> String! {
        
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "csv")
            else {
                return nil
            }
        
        do {
            let contents = try String(contentsOfFile: filePath)
            return contents
        } catch {
            print("File Read Error for file \(filePath)")
            return nil
        }
    }
    
    
    
}

