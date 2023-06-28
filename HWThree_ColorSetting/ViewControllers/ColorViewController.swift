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
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    
    var delegate: ColorViewControllerDelegate!
    var viewColor: UIColor!
    
//MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        let colors = CIColor(color: viewColor)
        redSlider.value = Float(colors.red)
        greenSlider.value = Float(colors.green)
        blueSlider.value = Float(colors.blue)
        
        redCounter.text = String(format: "%.2f", redSlider.value)
        greenCounter.text = String(format: "%.2f", greenSlider.value)
        blueCounter.text = String(format: "%.2f", blueSlider.value)
        
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        colorView.layer.cornerRadius = 10
        colorView.backgroundColor = viewColor
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneToolBarButtonTapped))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: false)
        redTextField.inputAccessoryView = toolbar
        greenTextField.inputAccessoryView = toolbar
        blueTextField.inputAccessoryView = toolbar
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @objc func doneToolBarButtonTapped() {
        redTextField.resignFirstResponder()
        greenTextField.resignFirstResponder()
        blueTextField.resignFirstResponder()
    }
    
    //MARK: - IBActions
    @IBAction func slidersAction(_ sender: UISlider) {
        viewColorChanged()
        if sender == redSlider {
            redCounter.text = String(format: "%.2f", redSlider.value)
            redTextField.text = String(format: "%.2f", redSlider.value)
        } else if sender == greenSlider {
            greenCounter.text = String(format: "%.2f", greenSlider.value)
            greenTextField.text = String(format: "%.2f", greenSlider.value)
        } else if sender == blueSlider {
            blueCounter.text = String(format: "%.2f", blueSlider.value)
            blueTextField.text = String(format: "%.2f", blueSlider.value)
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
    
    private func textFieldAlert () {
        let alert = UIAlertController(title: "Oops", message: "Value must be between 0 and 1", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension ColorViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let number = Float(redTextField.text ?? ""), number <= 1.0 {
            redSlider.value = number
            redCounter.text = number.formatted()
        } else { textFieldAlert() }
        if let number = Float(greenTextField.text ?? ""), number <= 1 {
            greenSlider.value = number
            greenCounter.text = number.formatted()
        } else { textFieldAlert() }
        if let number = Float(blueTextField.text ?? ""), number <= 1 {
            blueSlider.value = number
            blueCounter.text = number.formatted()
        } else { textFieldAlert() }
        viewColorChanged()
        }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }

}


