//
//  ViewController.swift
//  HWThree_ColorSetting
//
//  Created by Anton Kondratenko on 01.06.2023.
//

import UIKit

protocol ColorViewControllerDelegate{
    func changeColor(_ color: UIColor)
}

class ColorViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var colorView: UIView!
    @IBOutlet var redCounter: UILabel!
    @IBOutlet var greenCounter: UILabel!
    @IBOutlet var blueCounter: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    var delegate: ColorViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 10
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
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
    
    @IBAction func getCodeButtonTapped() {
        showAlert()
    }
    
    
    @IBAction func doneButtonTapped() {
        delegate.changeColor(colorView?.backgroundColor ?? .red)
        dismiss(animated: true)
    }
    
    //MARK: - Private Methods
    
    private func viewColorChanged() {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        colorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    private func colorToHex() -> String {
        let red = Int(redSlider.value * 255)
        let green = Int(greenSlider.value * 255)
        let blue = Int(blueSlider.value * 255)
        
        let colorCode = String(format: "#%02X%02X%02X", red, green, blue)
        return colorCode
    }
    
}

//MARK: - UIAlertController
extension ColorViewController {
    private func showAlert() {
        let colorCode = colorToHex()
        let alert = UIAlertController(title: "Color code", message: colorCode, preferredStyle: .alert)
        
        let copyAction = UIAlertAction(title: "Copy", style: .default) { _ in
            UIPasteboard.general.string = colorCode
        }
        alert.addAction(copyAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

