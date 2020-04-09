//
//  ViewController.swift
//  InnerPeace
//
//  Created by Ashutosh Dave on 09/04/20.
//  Copyright © 2020 Ashutosh Dave. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var background: UIImageView!
	@IBOutlet weak var quote: UIImageView!
	
	let quotes = Bundle.main.decode([Quote].self, from: "quotes.json")
	let images = Bundle.main.decode([String].self, from: "pictures.json")
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	func updateQuote() {
		guard let backgroundImageName = images.randomElement() else {
			fatalError("Unable to read an image.")
		}
		
		background.image = UIImage(named: backgroundImageName)
		
		guard let selectedQuote = quotes.randomElement() else {
			fatalError("Unable to read a quote.")
		}
		
		
		let insetAmount: CGFloat = 250
		let drawBounds = quote.bounds.inset(by: UIEdgeInsets(top: insetAmount, left: insetAmount, bottom: insetAmount, right: insetAmount))
		
		var quoteRect = CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
		var fontSize: CGFloat = 120
		var font: UIFont!
		
		var attrs: [NSAttributedString.Key: Any]!
		var str: NSAttributedString!
		
		while true {
			font = UIFont(name: "Georgia-Italic", size: fontSize)!
			attrs = [.font: font, .foregroundColor: UIColor.white]
			
			str = NSAttributedString(string: selectedQuote.text, attributes: attrs)
			quoteRect = str.boundingRect(with: CGSize(width: drawBounds.width, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
			
			if quoteRect.height > drawBounds.height {
				fontSize -= 4
			} else {
				break
			}
		}
		
		let format = UIGraphicsImageRendererFormat()
		format.opaque = false
		let renderer = UIGraphicsImageRenderer(bounds: quoteRect.insetBy(dx: -30, dy: -30), format: format)
		
		quote.image = renderer.image { ctx in
			for i in 1...5 {
				ctx.cgContext.setShadow(offset: .zero, blur: CGFloat(i * 2), color: UIColor.black.cgColor)
				str.draw(in: quoteRect)
			}
			
		}
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		updateQuote()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		updateQuote()
	}

}

