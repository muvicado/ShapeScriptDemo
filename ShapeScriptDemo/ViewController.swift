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

    let engine = ShapeScriptEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Default script: draw a hexagon
        scriptInput.text = """
            let sides = 6;
            let radius = 80;
            let centerX = 150;
            let centerY = 150;
            
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
        
        let script = scriptInput.text ?? ""
        let points = engine.run(script: script)
        shapeView.points = points
    }
}

