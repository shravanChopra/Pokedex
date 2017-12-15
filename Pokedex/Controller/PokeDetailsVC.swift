//
//  PokemonDetailsVC.swift
//  Pokedex
//
//  Created by Shravan Chopra on 12/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import UIKit
import Alamofire

class PokeDetailsVC: UIViewController {

    // to store the pokemon whose details are going to be displayed
    private var _pokemon: Pokemon!
    public var pokemon: Pokemon {
        get { return _pokemon}
        set { _pokemon = newValue }
    }
    
    // basic details of incoming pokemon
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var pokeIDLbl: UILabel!
    
    // to store pokemon attributes
    var type: String!
    var hp: Int = 0
    var height: Int = 0
    var weight: Int = 0
    var attack: Int = 0
    var defense: Int = 0
    
    // UI to store and display pokemon attributes obtained from API call
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var hpLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()

        fetchPokemonData {
            self.updateAttributesUI()
        }
    }
    
    // Function: Sets up initial UI with details of passed in pokemon
    private func initUI() {
        
        // TODO: replace back button with a nice image, hiding for now
        self.navigationItem.hidesBackButton = true
        
        self.title = _pokemon.name.capitalized
        pokeImg.image = UIImage(named: _pokemon.id)
        pokeIDLbl.text = "#\(_pokemon.id)"
    }
    
    // Function: Performs a GET API call with id of passed in pokemon
    private func fetchPokemonData(completed: @escaping DownloadComplete) {
        
        let urlString = "\(BASE_URL)\(POKE_ATTRIB_URL)\(_pokemon.id)"
        let url = URL(string: urlString)!
    
        Alamofire.request(url).responseJSON { response in
            
            if let resultsDict = response.value as? Dictionary<String, Any> {
                
                
                // accessing stats for attack, defense and HP
                if let stats = resultsDict["stats"] as? [Dictionary<String, Any>] {
                    
                    // defense
                    if let defense = stats[3]["base_stat"] as? Int {
                        self.defense = defense
                    }
                    
                    // attack
                    if let attack = stats[4]["base_stat"] as? Int {
                        self.attack = attack
                    }
                    
                    // HP
                    if let hp = stats[5]["base_stat"] as? Int {
                        self.hp = hp
                    }
                }
                
                // getting height
                if let height = resultsDict["height"] as? Int {
                    self.height = height
                }
                
                // getting weight
                if let weight = resultsDict["weight"] as? Int {
                    self.weight = weight
                }
            
            }
            
            completed()
        }
    }
    
    // Function: Updates pokemon details UI with results obtained from API call
    private func updateAttributesUI() {
        
        hpLbl.text = "\(hp)"
        attackLbl.text = "Attack: \(attack)"
        defenseLbl.text = "Defense: \(defense)"
        heightLbl.text = "Height: \(height)"
        weightLbl.text = "Weight: \(weight)"
    }
}
