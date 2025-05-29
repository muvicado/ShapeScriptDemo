//
//  ShapeScriptEngine.swift
//  ShapeScriptDemo
//
//  Created by Mark Barclay on 5/29/25.
//

import JavaScriptCore
import CoreGraphics

class ShapeScriptEngine {
    private let context = JSContext()!

    init() {
        context.exceptionHandler = { _, exception in
            print("JS Error: \(exception?.toString() ?? "unknown error")")
        }

        context.evaluateScript("""
            var points = [];
            function addPoint(x, y) {
                points.push({x: x, y: y});
            }
        """)
    }

    func run(script: String) -> [CGPoint] {
        context.evaluateScript("points = [];") // Reset points
        context.evaluateScript(script)

        guard let jsPoints = context.objectForKeyedSubscript("points") else { return [] }

        var cgPoints: [CGPoint] = []
        let count: Int? = jsPoints.toArray()?.count
        for i in 0..<count! {
            if let jsPoint = jsPoints.objectAtIndexedSubscript(i),
               let x = jsPoint.objectForKeyedSubscript("x")?.toDouble(),
               let y = jsPoint.objectForKeyedSubscript("y")?.toDouble() {
                cgPoints.append(CGPoint(x: x, y: y))
            }
        }

        return cgPoints
    }
}
