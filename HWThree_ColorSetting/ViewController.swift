//
//  ViewController.swift
//  HWThree_ColorSetting
//
//  Created by Anton Kondratenko on 01.06.2023.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var colorView: UIView!
    @IBOutlet var redCounter: UILabel!
    @IBOutlet var greenCounter: UILabel!
    @IBOutlet var blueCounter: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 10
      
    }

        //MARK: - IBActions
    @IBAction func slidersAction(_ sender: UISlider) {
        viewColorChanged()
        if sender == redSlider {
            redCounter.text = String(format: "%.2f", redSlider.value)
        } else if sender == greenSlider {
            greenCounter.text = String(format: "%.2f", greenSlider.value)
        } else if sender == blueSlider {
            blueCounter.text = String(format: "%.2f", blueSlider.value)
        }
    }
    
    
    //MARK: - Private Methods
   
    private func viewColorChanged() {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        colorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}

