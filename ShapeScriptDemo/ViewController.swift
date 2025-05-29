//
//  ViewController.swift
//  ShapeScriptDemo
//
//  Created by Mark Barclay on 5/29/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var shapeView: ShapeView!
    @IBOutlet weak var scriptInput: UITextView!
    @IBOutlet weak var errorLabel: UILabel!

    let engine = ShapeScriptEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Default script: draw a hexagon
        engine.onException = { [weak self] message in
            DispatchQueue.main.async {
                self?.errorLabel.text = "⚠️ Script Error: \(message)"
            }
        }
        
        scriptInput.text = """
        sides = 6;
        radius = 80;
        centerX = 120;
        centerY = 120;
        for (let i = 0; i < sides; i++) {
            let angle = (2 * Math.PI / sides) * i;
            let x = centerX + Math.cos(angle) * radius;
            let y = centerY + Math.sin(angle) * radius;
            addPoint(x, y);
        }
        sides = 8;
        for (let i = 0; i < sides; i++) {
            let angle = (2 * Math.PI / sides) * i;
            let x = centerX + Math.cos(angle) * radius;
            let y = centerY + Math.sin(angle) * radius;
            addPoint(x, y);
        }
        """
    }
    
    @IBAction func runScript(_ sender: Any) {
        print("Run")
        errorLabel.text = ""
        let script = scriptInput.text ?? ""
        let points = engine.run(script: script)
        shapeView.points = points
    }
}

