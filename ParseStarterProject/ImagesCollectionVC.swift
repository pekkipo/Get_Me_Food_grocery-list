//
//  ImagesCollectionVC.swift
//  PerfectList
//
//  Created by Aleksei Petukhov on 03/12/15.
//  Copyright (c) 2015 PekkiPo. All rights reserved.
//

import UIKit



var defaultcatimages : [DefaultPicture] = [
    DefaultPicture(itemimage: UIImage(named: "DefaultProduct")!, imagename: "DefaultProduct"),
    DefaultPicture(itemimage: UIImage(named: "4UserIcon")!, imagename: "4UserIcon")
    
]

var imagestochoose : [DefaultPicture] = [
    DefaultPicture(itemimage: UIImage(named: "DefaultProduct")!, imagename: "DefaultProduct"),
    DefaultPicture(itemimage: UIImage(named: "Dpic1")!, imagename: "Dpic1"),
    DefaultPicture(itemimage: UIImage(named: "Dpic2")!, imagename: "Dpic2"),
    DefaultPicture(itemimage: UIImage(named: "Dpic3")!, imagename: "Dpic3"),
    DefaultPicture(itemimage: UIImage(named: "Dpic4")!, imagename: "Dpic4"),
    DefaultPicture(itemimage: UIImage(named: "Dpic5")!, imagename: "Dpic5"),
    DefaultPicture(itemimage: UIImage(named: "Dpic6")!, imagename: "Dpic6"),
    DefaultPicture(itemimage: UIImage(named: "Dpic7")!, imagename: "Dpic7"),
    DefaultPicture(itemimage: UIImage(named: "Dpic8")!, imagename: "Dpic8"),
    DefaultPicture(itemimage: UIImage(named: "Dpic9")!, imagename: "Dpic9"),
    DefaultPicture(itemimage: UIImage(named: "Dpic10")!, imagename: "Dpic10"),
    DefaultPicture(itemimage: UIImage(named: "Dpic11")!, imagename: "Dpic11"),
    DefaultPicture(itemimage: UIImage(named: "Dpic12")!, imagename: "Dpic12"),
    DefaultPicture(itemimage: UIImage(named: "Dpic13")!, imagename: "Dpic13"),
    DefaultPicture(itemimage: UIImage(named: "Dpic14")!, imagename: "Dpic14")
    
]

var imagestochoose2 : [DefaultPicture] = [
    DefaultPicture(itemimage: UIImage(named: "Dpic15")!, imagename: "Dpic15"),
    DefaultPicture(itemimage: UIImage(named: "Dpic16")!, imagename: "Dpic16"),
    DefaultPicture(itemimage: UIImage(named: "Dpic17")!, imagename: "Dpic17"),
    DefaultPicture(itemimage: UIImage(named: "Dpic18")!, imagename: "Dpic18"),
    DefaultPicture(itemimage: UIImage(named: "Dpic19")!, imagename: "Dpic19"),
    DefaultPicture(itemimage: UIImage(named: "Dpic20")!, imagename: "Dpic20"),
    DefaultPicture(itemimage: UIImage(named: "Dpic21")!, imagename: "Dpic21"),
    DefaultPicture(itemimage: UIImage(named: "Dpic22")!, imagename: "Dpic22"),
    DefaultPicture(itemimage: UIImage(named: "Dpic23")!, imagename: "Dpic23"),
    DefaultPicture(itemimage: UIImage(named: "Dpic24")!, imagename: "Dpic24"),
    DefaultPicture(itemimage: UIImage(named: "Dpic25")!, imagename: "Dpic25"),
    DefaultPicture(itemimage: UIImage(named: "Dpic26")!, imagename: "Dpic26")
    
]

var imagestochoose3 : [DefaultPicture] = [
    DefaultPicture(itemimage: UIImage(named: "Dpic27")!, imagename: "Dpic27"),
    DefaultPicture(itemimage: UIImage(named: "Dpic28")!, imagename: "Dpic28"),
    DefaultPicture(itemimage: UIImage(named: "Dpic29")!, imagename: "Dpic29"),
    DefaultPicture(itemimage: UIImage(named: "Dpic30")!, imagename: "Dpic30"),
    DefaultPicture(itemimage: UIImage(named: "Dpic31")!, imagename: "Dpic31"),
    DefaultPicture(itemimage: UIImage(named: "Dpic32")!, imagename: "Dpic32"),
    DefaultPicture(itemimage: UIImage(named: "Dpic33")!, imagename: "Dpic33"),
    DefaultPicture(itemimage: UIImage(named: "Dpic34")!, imagename: "Dpic34"),
    DefaultPicture(itemimage: UIImage(named: "Dpic35")!, imagename: "Dpic35"),
    DefaultPicture(itemimage: UIImage(named: "Dpic36")!, imagename: "Dpic36"),
    DefaultPicture(itemimage: UIImage(named: "Dpic37")!, imagename: "Dpic37"),
    DefaultPicture(itemimage: UIImage(named: "Dpic38")!, imagename: "Dpic38"),
    DefaultPicture(itemimage: UIImage(named: "Dpic39")!, imagename: "Dpic39"),
    DefaultPicture(itemimage: UIImage(named: "Dpic41")!, imagename: "Dpic41")
    
]

var imagestochoose4 : [DefaultPicture] = [
    DefaultPicture(itemimage: UIImage(named: "Dpiccat1")!, imagename: "Dpiccat1"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat2")!, imagename: "Dpiccat2"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat3")!, imagename: "Dpiccat3"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat4")!, imagename: "Dpiccat4"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat5")!, imagename: "Dpiccat5"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat6")!, imagename: "Dpiccat6"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat7")!, imagename: "Dpiccat7"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat8")!, imagename: "Dpiccat8"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat9")!, imagename: "Dpiccat9"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat10")!, imagename: "Dpiccat10"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat11")!, imagename: "Dpiccat11"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat12")!, imagename: "Dpiccat12"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat13")!, imagename: "Dpiccat13"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat14")!, imagename: "Dpiccat14"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat15")!, imagename: "Dpiccat15"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat16")!, imagename: "Dpiccat16"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat17")!, imagename: "Dpiccat17"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat18")!, imagename: "Dpiccat18"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat19")!, imagename: "Dpiccat19"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat20")!, imagename: "Dpiccat20"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat21")!, imagename: "Dpiccat21"),
    DefaultPicture(itemimage: UIImage(named: "Dpiccat22")!, imagename: "Dpiccat22"),
    
]


var imagestochooseartistic : [DefaultPicture] = [
    DefaultPicture(itemimage: UIImage(named: "agua_256.png")!, imagename: "agua_256.png"),
    DefaultPicture(itemimage: UIImage(named: "Cucumber.png")!, imagename: "Cucumber.png")

    
    
    
    
]

var collectionsheaders : [String] = [
    NSLocalizedString("setcolored", comment: ""),
    NSLocalizedString("setsketchy", comment: ""),
    NSLocalizedString("setbw", comment: ""),
    NSLocalizedString("setforcats", comment: "")

]

protocol ImagesPopupDelegate
{
    func choosecollectionimage(picture: UIImage, defaultpicture: Bool, picturename: String?)
}

class ImagesCollectionVC: UIViewController,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var delegate: ImagesPopupDelegate?
    
    
    @IBOutlet var choosenewpicture: UIButton!
    
    @IBAction func choosenewpictureaction(sender: AnyObject) {
        
        let chosenimage = UIImagePickerController()
        chosenimage.delegate = self//self
        chosenimage.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        chosenimage.allowsEditing = false
        
        self.presentViewController(chosenimage, animated: true, completion: nil)
        
        
        confirmoutlet.enabled = true
        confirmoutlet.alpha = 1.0
        
    }
    
    @IBOutlet var addthisimageoutlet: UIButton!
    
    @IBOutlet var headerviewforcollection: UIView!
    
    @IBOutlet var newimage: UIImageView!
    
    var defaultpicture = Bool()
    


    @IBOutlet var confirmoutlet: UIButton!
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage chosenimage: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.dismissViewControllerAnimated(true, completion:nil)

        chosenimage.drawInRect(CGRectMake(0,0, 50, 50))
        
        self.choosenewpicture.setImage(chosenimage, forState: .Normal)
        
        self.defaultpicture = false
        
       // confirmoutlet.enabled = true
       // confirmoutlet.alpha = 1.0
        
        
    }

    @IBAction func closetheimages(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func confirmtheimages(sender: AnyObject) {
        
        imageResize(self.choosenewpicture.imageForState(.Normal)!)
        
        
        delegate?.choosecollectionimage(scaledpicture, defaultpicture: false, picturename: nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func closebutton(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    var scaledpicture = UIImage()
    
    func imageResize(imageObj:UIImage)-> UIImage{
        
        // Automatically use scale factor of main screen
        
        let avsize = CGSizeMake(100, 100)
        UIGraphicsBeginImageContextWithOptions(avsize, false, 1.0) //false - in order to add alpha channel
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: avsize))
        
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        scaledpicture = scaledImage
        return scaledpicture
    }
    
    
    @IBAction func savenewpicture(sender: AnyObject) {
        
       // imageResize(self.newimage.image!)
        imageResize(self.choosenewpicture.imageForState(.Normal)!)
        

         delegate?.choosecollectionimage(scaledpicture, defaultpicture: false, picturename: nil)
        
        // self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
            // alpha: CGFloat(0.3)
        )
    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    var emptyImage = UIImage(named: "4EmptyImage")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       // view.backgroundColor = UIColor.clearColor()
       // view.opaque = false
        
        
        
        confirmoutlet.enabled = false
        confirmoutlet.alpha = 0.3
        
        self.choosenewpicture.setImage(emptyImage, forState: .Normal)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //COLLECTION VIEW STUFF
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollCell", forIndexPath: indexPath) as! ImagesCollectionViewCell
     
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.grayColor().CGColor
        if indexPath.section == 0 {
        cell.imageView.image = imagestochoose[indexPath.item].itemimage
        } else if indexPath.section == 1 {
           cell.imageView.image = imagestochoose2[indexPath.item].itemimage
        } else if indexPath.section == 2 {
            cell.imageView.image = imagestochoose3[indexPath.item].itemimage
        } else if indexPath.section == 3 {
            cell.imageView.image = imagestochoose4[indexPath.item].itemimage
        }
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 4
    }
    
   // var chosendefaultimage = UIImage()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        if section == 0 {
        return imagestochoose.count
        } else if section == 1 {
            return imagestochoose2.count
        } else if section == 2 {
            return imagestochoose3.count
        } else if section == 3 {
            return imagestochoose4.count
        } else {
            return imagestochoose.count
        }
    }
    
    func collectionView(collectionView: UICollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath) {
            
           // chosendefaultimage = imagestochoose[indexPath.item]
            if indexPath.section == 0 {
            delegate?.choosecollectionimage(imagestochoose[indexPath.item].itemimage, defaultpicture: true, picturename: imagestochoose[indexPath.item].imagename)
            } else if indexPath.section == 1 {
                delegate?.choosecollectionimage(imagestochoose2[indexPath.item].itemimage, defaultpicture: true, picturename: imagestochoose2[indexPath.item].imagename)
            } else if indexPath.section == 2 {
                delegate?.choosecollectionimage(imagestochoose3[indexPath.item].itemimage, defaultpicture: true, picturename: imagestochoose3[indexPath.item].imagename)
            } else if indexPath.section == 3 {
                delegate?.choosecollectionimage(imagestochoose4[indexPath.item].itemimage, defaultpicture: true, picturename: imagestochoose4[indexPath.item].imagename)
            }


            
            
            self.dismissViewControllerAnimated(true, completion:nil)
            
            
    }
    
    
    func collectionView(collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            //1
            switch kind {
                //2
            case UICollectionElementKindSectionHeader:
                //3
                let headerView =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                    withReuseIdentifier: "CollectionHeader",
                    forIndexPath: indexPath)
                    as! CollectionHeader
                headerView.headername.text = collectionsheaders[indexPath.section]
                return headerView
            default:
                //4
               // assert(false, "Unexpected element kind")
                fatalError("Unexpected index")
            }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
