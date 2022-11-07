//
//  KeyChainService.swift
//  PatientHealthChart
//
//  Created by laputer on 11/5/22.
//

import Foundation

import KeychainSwift

class KeyChainService{
    var _keyChain = KeychainSwift()
    
    var keyChain: KeychainSwift {
        get {
            return _keyChain
        }
        set {
            _keyChain = newValue
        }
    }
    
}
