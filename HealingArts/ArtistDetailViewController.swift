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
        
        for word in textView.text.split(separator: " ") {
            
            if (word == "$n") {
                //new line
            }
            else if (word == "$i") {
                print("gotem")
                italics = true
                print("italics babyyyyyyyyyy")
            }
            else if (word == "$b") {
                bold = true
                print("bold bihh")
            }
            else if (word == "i$") {
                italics = false
                totalText += italicSubStr + " "
                print("italics \(italicSubStr)")
                italicSubStr = ""
            }
            else if (word == "b$") {
                bold = false
                totalText += boldSubStr + " "
                print("bold \(boldSubStr)")
                boldSubStr = ""
            }
            else if (italics) {
                italicSubStr += word
            }
            else if (bold) {
                boldSubStr += word
            }
            else {
                totalText += word
            }
        }
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
