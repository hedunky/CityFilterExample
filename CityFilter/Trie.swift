//
//  Trie.swift
//  CityFilter
//
//  Created by Alexander Kurbanov on 20/09/2017.
//  Copyright © 2017 Alexander Kurbanov. All rights reserved.
//

import UIKit

class Trie {
    
    // MARK: - Fields
    
    private let root = TrieNode()
    
    // MARK: - Trie methods
    
    func addWord(keyword: String) {
        guard !keyword.isEmpty else { return }
        
        var current: TrieNode = root
        
        while (keyword.characters.count != current.level) {
            
            var childToUse: TrieNode!
            let index = keyword.index(keyword.startIndex, offsetBy: current.level + 1)
            let searchKey: String = keyword.substring(to: index)
            
            for child in current.children {
                if (child.key == searchKey) {
                    childToUse = child
                    break
                }
            }
            
            if (childToUse == nil) {
                childToUse = TrieNode()
                childToUse.key = searchKey
                childToUse.level = current.level + 1
                current.children.append(childToUse)
            }
            current = childToUse
        }
        
        if (keyword.characters.count == current.level) {
            current.isFinal = true
        }
    }
    
    func findWord(keyword: String) -> Array<String>! {
        guard !keyword.isEmpty else { return nil }
        
        var current: TrieNode = root
        var wordList: Array<String> = Array<String>()
        
        while (keyword.characters.count != current.level) {
            
            var childToUse: TrieNode!
            let index = keyword.index(keyword.startIndex, offsetBy: current.level + 1)
            let searchKey: String = keyword.substring(to: index)
            
            for child in current.children {
                if child.key == searchKey {
                    childToUse = child
                    current = childToUse
                    break
                }
            }
            
            if childToUse == nil {
                return nil
            }
            
        }
        
        if current.key.hasPrefix(keyword) {
            wordList.append(current.key)
        }
        
        for child in current.children {
            if (child.isFinal == true) {
                wordList.append(child.key)
            }
        }
        return wordList
    }
}
