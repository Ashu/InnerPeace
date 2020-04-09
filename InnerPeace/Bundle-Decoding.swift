//
//  Bundle-Decoding.swift
//  InnerPeace
//
//  Created by Ashutosh Dave on 09/04/20.
//  Copyright © 2020 Ashutosh Dave. All rights reserved.
//

import Foundation

extension Bundle {
	func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
		guard let url = self.url(forResource: file, withExtension: nil) else {
			fatalError("Failed to locate \(file) in app bundle.")
		}
		
		guard let data = try? Data(contentsOf: url) else {
			fatalError("Failted to load \(file) in app bundle.")
		}
		
		let decoder = JSONDecoder()
		
		guard let loaded = try? decoder.decode(T.self, from: data) else {
			fatalError("Failed to decode \(file) from app bundle.")
		}
		
		return loaded
	}
}
