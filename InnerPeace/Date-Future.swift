//
//  Date-Future.swift
//  InnerPeace
//
//  Created by Ashutosh Dave on 10/04/20.
//  Copyright © 2020 Ashutosh Dave. All rights reserved.
//

import Foundation

extension Date {
	func byAdding(days: Int) -> Date {
		var dateComponents = DateComponents()
		dateComponents.day = days
		
		return Calendar.current.date(byAdding: dateComponents, to: self) ?? self
	}
}
