//
//  TrieNode.swift
//  CityFilter
//
//  Created by Alexander Kurbanov on 20/09/2017.
//  Copyright © 2017 Alexander Kurbanov. All rights reserved.
//

import UIKit

class TrieNode {
    
    // MARK: - Fields
    
    var key: String!
    var children: Array<TrieNode>
    var isFinal: Bool
    var level: Int
    
    // MARK: - Constructors
    
    init() {
        self.children = Array<TrieNode>()
        self.isFinal = false
        self.level = 0
    }
}
