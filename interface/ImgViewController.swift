//
//  ImgViewController.swift
//  interface
//
//  Created by Amrit Kaur on 2019-05-30.
//  Copyright © 2019 Amrit Kaur. All rights reserved.
//

import UIKit

class ImgViewController: UIViewController,
              UIImagePickerControllerDelegate,
               UINavigationControllerDelegate{

    @IBOutlet var imgPlaceholder: UIView!
    
    @IBOutlet weak var imgHolder: UIImageView!
   
    var imgPicker = UIImagePickerController()
    
    
    
    struct oriImg {
       static var name = UIImage.init()
    }

    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        imgPicker.delegate = self
        
        oriImg.name = imgHolder.image!
        
        // Do any additional setup after loading the view.
    }
    
//changed image
    
    @IBAction func changeImg(_ sender: Any) {
        
        imgHolder.image = UIImage(named: "image")
        
        
    }
    
//Black And White
    
    @IBAction func Sepia(_ sender: Any) {
        
        
        //imgHolder.image = UIImage(named: "image")
    
        
        let input = oriImg.name
        
        let rawImg = CIImage(image: input)
        
        let SepiaParams: [String: Any] = [kCIInputImageKey : rawImg]
        
        let SepiaFilter = CIFilter(name: "CIPhotoEffectNoir", parameters: SepiaParams)
        
        
        let context = CIContext(options: nil)
        if let output = SepiaFilter?.outputImage
        {
            if let ciImg = context.createCGImage(output, from: output.extent)
            {
                imgHolder.image = UIImage(cgImage: ciImg)
            }
        }
    }
    
//Sepia Filter
    @IBAction func btnFilter(_ sender: Any) {
        
        
        let inputImage = oriImg.name
        
        let rawImage = CIImage(image: inputImage)
        
       
            let SepiaParams: [String: Any] = [kCIInputImageKey : rawImage , kCIInputIntensityKey : 0.5]
            
            let SepiaFilter = CIFilter(name: "CISepiaTone", parameters: SepiaParams)
            
            
            let context = CIContext(options: nil)
            
            if let output = SepiaFilter?.outputImage
            {
                
                if let ciImg = context.createCGImage(output, from: output.extent)
                {
                    imgHolder.image = UIImage(cgImage: ciImg)
                    
                }
                
            }
        
        }
    
//Crop filter
    
    @IBAction func crop(_ sender: Any) {
        
        let inputImage = oriImg.name
        
        let rawImage = CIImage(image: inputImage)
        
        let cropParams: [String: Any] = [kCIInputImageKey : rawImage , "inputSize" : CIVector(string:"[100 100]") , "inputCropAmount" : 1 , "inputCenterStretchAmount" : 1]
        
        let SepiaFilter = CIFilter(name: "CIStretchCrop", parameters: cropParams)
        
        
        let context = CIContext(options: nil)
        if let output = SepiaFilter?.outputImage
        {
            if let ciImg = context.createCGImage(output, from: output.extent)
            {
               imgHolder.image = UIImage(cgImage: ciImg)
            }
        }
        
        
    }
    
//turn to Original Image
    
    @IBAction func original(_ sender: Any) {
        
        imgHolder.image = oriImg.name
        
    }
    
//Slider Function
    
    @IBAction func Slider(_ sender: UISlider) {
        
        
      let currentValue = Int(sender.value)
        
        
        let inputImage = oriImg.name
        
        let rawImage = CIImage(image: inputImage)
        
        
        let SepiaParams: [String: Any] = [kCIInputImageKey : rawImage , kCIInputIntensityKey : currentValue]
        
        let SepiaFilter = CIFilter(name: "CISepiaTone", parameters: SepiaParams)
        
        
        let context = CIContext(options: nil)
        
        if let output = SepiaFilter?.outputImage
        {
            
            if let ciImg = context.createCGImage(output, from: output.extent)
            {
                imgHolder.image = UIImage(cgImage: ciImg)
                
            }
            
        }
    }
    @IBAction func btnClick(_ sender: Any) {
        
        
        imgPicker.sourceType = .photoLibrary
        imgPicker.allowsEditing = true
        present(imgPicker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        
        if (info[UIImagePickerController.InfoKey.originalImage]  as? UIImage != nil)
        {
            
          let userSelection = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
       imgHolder.image = userSelection
        
        oriImg.name = userSelection!
        
        dismiss(animated: true, completion: nil)
        }
    }
    /*
     @IBAction func BtnClick(_ sender: Any) {
     }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
