//
//  ActionButton+Protocols.swift
//  ActionSheet
//
//  Created by William Connelly on 28/1/20.
//

import Foundation

protocol ActionButtonProtocol {
    var nibName: String { get }
    
    func viewDidLoad()
}

protocol ActionButtonImageProtocol: ActionButtonProtocol {
    init(title: String)
}
protocol ActionButtonNormalProtocol: ActionButtonProtocol {
    init(title: String)
}
protocol ActionButtonProminentProtocol: ActionButtonProtocol {
    init(title: String)
}

