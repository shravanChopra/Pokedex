//
//  Pokemon.swift
//  Pokedex
//
//  Created by Shravan Chopra on 09/12/17.
//  Copyright © 2017 Shravan Chopra. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _id: String
    private var _name: String
    
    init (id: String, name: String) {
        _id = id
        _name = name
    }
    
    // public getters
    public var id: String {
        get { return _id}
    }
    
    public var name: String {
        get {return _name }
    }
}
