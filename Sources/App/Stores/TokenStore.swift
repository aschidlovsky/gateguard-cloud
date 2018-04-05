//
//  TokenStore.swift
//  gateguardcloud
//
//  Created by Sławek Peszke on 05/04/2018.
//  Copyright © 2018 inFullMobile. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol TokenStore {
    func register(token: Token)
    func token(withId: Int) -> Token?
}

// MARK: - Implementation

final class TokenStoreImpl: TokenStore {
    
    // MARK: Properties
    
    private var tokens: [Token] = []
    
    // MARK: Token management
    
    func register(token: Token) {
        self.tokens.insert(token, at: 0)
        self.tokens.removeLast(max(self.tokens.count - Constants.maxElements, 0))
    }
    
    func token(withId: Int) -> Token? {
        return self.tokens.filter({ (token) -> Bool in token.id == withId }).first
    }
}

// MARK: - Constants

private struct Constants {
    static let maxElements: Int = 10
}

