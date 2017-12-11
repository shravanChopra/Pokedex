//
//  ViewController.swift
//  Pokedex
//
//  Created by Shravan Chopra on 09/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // to store and display pokemon data
    var pokemon: [Pokemon]!
    @IBOutlet weak var pokeCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load pokemon data on startup
        startUp()
    }

    // Function: hooks up collection view to this VC, and loads pokemon data from csv file
    func startUp() {
        pokeCollectionView.dataSource = self
        pokeCollectionView.delegate = self
        pokemon = loadPokemonData(fileName: "pokemon")
    }
    
    // Function: reads the pokemon data csv file and returns the contents as a pokemon array
    func loadPokemonData(fileName: String) -> [Pokemon]! {
        
        var results = [Pokemon]()
        
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "csv")
            else {
                return nil
            }
        
        do {
            let contents = try String(contentsOfFile: filePath, encoding: .utf8)
            let pokeItems = contents.components(separatedBy: "\r")
            
            for item in pokeItems {
                
                let pokeData = item.components(separatedBy: ",")
                let newPokemon = Pokemon(id: pokeData[0], name: pokeData[1])
                results.append(newPokemon)
            }
           
        } catch {
            print("File Read Error for file \(filePath)")
            return nil
        }
        
        print ("\(results.count) pokemon loaded")
        
        return results
    }
    
    // ----------------------------- Collection view delegate methods ------------------------------
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let pokeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as? PokemonCell{
            
            pokeCell.updateUI(from: pokemon[indexPath.row])
            return pokeCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 110, height: 110)
    }
    
    // ---------------------------------------------------------------------------------------------
    

}

