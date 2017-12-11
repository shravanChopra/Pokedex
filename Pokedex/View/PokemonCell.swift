//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Shravan Chopra on 10/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImg: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    // Function: updates cell UI from the pokemon passed in
    func updateUI(from pokemon: Pokemon) {
        pokemonImg.image = UIImage(named: pokemon.id)
        pokemonNameLabel.text = pokemon.name.capitalized
    }
}
