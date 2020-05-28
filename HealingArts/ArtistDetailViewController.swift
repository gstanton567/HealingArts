//
//  ArtistDetailViewController.swift
//  HealingArts
//
//  Created by Gwyneth Semanisin on 6/10/19.
//  Copyright © 2019 Brady Fehr. All rights reserved.
//

import UIKit
import SafariServices

class ArtistDetailViewController: UIViewController, SFSafariViewControllerDelegate {
    
    var artworkPiece : Artwork?
    var indexOfArtist : Int!
    var artist : Artist?
    var number = 0              //check if artist has artwork
    

    //@IBOutlet weak var biographyLabel: UILabel!
   @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var viewCollectionButton: UIButton!
    @IBOutlet weak var artistImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistLabel.text = artist?.name
        //biographyLabel.text! += artist!.textDesc!
        textView.text = artist?.textDesc
        setTextStyling()
        artistImageView.image = artist!.images.first
        for artwork in Firebase.globalModArtworks {
            if artwork.artist == artist?.name {
                number = 1
            }
        }
        if number == 0 {
            viewCollectionButton.isEnabled = false
        }
    }
    
    
    
    func setTextStyling() {
        var italics = false
        var bold = false
        var italicSubStr = ""
        var boldSubStr = ""
        var totalText = ""
        

        var attributedString = NSMutableAttributedString(string:totalText)
        var normAttr = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]
        var italicAttr = [NSAttributedString.Key.font : UIFont.italicSystemFont(ofSize: 17)]
        var boldAttr = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]
        //var boldString = NSMutableAttributedString(string: boldSubStr, attributes: boldAttr)

        //attributedString.append(boldString)
        
        
       
        
        for word in textView.text.split(separator: " ") {
            
            if (word == "$n") {
                //new line
                let newLineStr = "\n\n"
                var newLineAttributedString = NSMutableAttributedString(string:String(newLineStr), attributes: normAttr)
                attributedString.append(newLineAttributedString)
            }
            else if (word == "$i") {
                italics = true
            }
            else if (word == "$b") {
                bold = true
            }
            else if (word == "i$") {
                italics = false
                //totalText += italicSubStr + " "
                var italicString = NSMutableAttributedString(string: italicSubStr, attributes: italicAttr)
                attributedString.append(italicString)
                italicSubStr = ""
            }
            else if (word == "b$") {
                bold = false
                //totalText += boldSubStr + " "
                 var boldString = NSMutableAttributedString(string: boldSubStr, attributes: boldAttr)
                attributedString.append(boldString)
                boldSubStr = ""
            }
            else if (italics) {
                italicSubStr += word + " "
            }
            else if (bold) {
                boldSubStr += word + " "
            }
            else {
                //totalText += word
                let wordWithSpace = word + " "
                var normAttributedString = NSMutableAttributedString(string:String(wordWithSpace), attributes: normAttr)
                attributedString.append(normAttributedString)
            }
        }
        
        //print(attributedString)
        textView.attributedText = attributedString
    }
    
    
//prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as? CollectionViewController
        let artistName = artist?.name
        print(artistName)
        dvc!.artistName = artistName
    }
 

    @IBAction func onButtonPressed(_ sender: Any) {
        let linkString = "\(artist!.website)"
        if let link = URL(string: linkString) {
            let sfvc = SFSafariViewController(url: link)
            sfvc.delegate = (self as! SFSafariViewControllerDelegate)
            
            present(sfvc, animated: true)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        //dismiss(animated: true)
    }
}


extension UIFont{
var isBold: Bool
{
    return fontDescriptor.symbolicTraits.contains(.traitBold)
}

var isItalic: Bool
{
    return fontDescriptor.symbolicTraits.contains(.traitItalic)
}

func setBold() -> UIFont
{
    if(isBold)
    {
        return self
    }
    else
    {
        var fontAtrAry = fontDescriptor.symbolicTraits
        fontAtrAry.insert([.traitBold])
        let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
        return UIFont(descriptor: fontAtrDetails!, size: pointSize)
    }
}

func setItalic()-> UIFont
{
    if(isItalic)
    {
        return self
    }
    else
    {
        var fontAtrAry = fontDescriptor.symbolicTraits
        fontAtrAry.insert([.traitItalic])
        let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
        return UIFont(descriptor: fontAtrDetails!, size: pointSize)
    }
}
func desetBold() -> UIFont
{
    if(!isBold)
    {
        return self
    }
    else
    {
        var fontAtrAry = fontDescriptor.symbolicTraits
        fontAtrAry.remove([.traitBold])
        let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
        return UIFont(descriptor: fontAtrDetails!, size: pointSize)
    }
}

func desetItalic()-> UIFont
{
    if(!isItalic)
    {
        return self
    }
    else
    {
        var fontAtrAry = fontDescriptor.symbolicTraits
        fontAtrAry.remove([.traitItalic])
        let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
        return UIFont(descriptor: fontAtrDetails!, size: pointSize)
    }
}
}
extension NSMutableAttributedString {
    var fontSize:CGFloat { return 14 }
    var boldFont:UIFont { return UIFont(name: "AvenirNext-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont:UIFont { return UIFont(name: "AvenirNext-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}

    func bold(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func normal(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    /* Other styling methods */
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func blackHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func underlined(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
