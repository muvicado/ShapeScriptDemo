//
//  ShapeView.swift
//  ShapeScriptDemo
//
//  Created by Mark Barclay on 5/29/25.
//

import UIKit

class ShapeView: UIView {
    var points: [CGPoint] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        guard points.count > 1 else { return }

        let path = UIBezierPath()
        path.move(to: points[0])

        for point in points.dropFirst() {
            path.addLine(to: point)
        }

        path.close()

        UIColor.systemBlue.setStroke()
        UIColor.systemBlue.withAlphaComponent(0.3).setFill()
        path.lineWidth = 2
        path.fill()
        path.stroke()
    }
}
