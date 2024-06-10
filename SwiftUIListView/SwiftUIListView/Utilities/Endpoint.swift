//
//  Endpoint.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import Foundation

protocol Endpoint {
    var url: URL? { get }
    var path: String { get }
}
