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
    var onException: ((String) -> Void)?

    init() {
        context.exceptionHandler = { [weak self] _, exception in
            //print("JS Error: \(exception?.toString() ?? "unknown error")")
            if let message = exception?.toString() {
                self?.onException?(message)
            }
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
        _ = context.evaluateScript(script) // exceptionHandler will catch issues

        guard let jsPoints = context.objectForKeyedSubscript("points") else { return [] }

        var cgPoints: [CGPoint] = []
        for i in 0..<jsPoints.toArray().count {
            if let jsPoint = jsPoints.objectAtIndexedSubscript(i),
               let x = jsPoint.objectForKeyedSubscript("x")?.toDouble(),
               let y = jsPoint.objectForKeyedSubscript("y")?.toDouble() {
                cgPoints.append(CGPoint(x: x, y: y))
            }
        }

        return cgPoints
    }
}
