//
//  ShoppingListCreation.swift
//  ParseStarterProject
//
//  Created by Aleksei Petukhov on 21/07/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import ASHorizontalScrollView

import Foundation
/*
var customcategories = [Category]()

var catalogcategories = [
Category(catId:"DefaultOthers",catname:"Others",catimage:UIImage(named: "restau.png")!,isCustom:false),
Category(catId:"DefaultVegetables",catname:"Vegetables",catimage:UIImage(named: "veg_icon.jpg")!,isCustom:false),
Category(catId:"DefaultFruits",catname:"Fruits",catimage:UIImage(named: "fruits_icon.jpg")!,isCustom:false),
Category(catId:"DefaultBeverages",catname:"Beverages",catimage:UIImage(named: "check.png")!,isCustom:false),
Category(catId:"DefaultPoultry",catname:"Poultry",catimage:UIImage(named: "testimage.png")!,isCustom:false),
Category(catId:"DefaultDomesticStuff",catname:"Domestic stuff",catimage:UIImage(named: "testimage.png")!,isCustom:false)
]
*/

var messageimage : UIImage = UIImage(named: "Tutorial5")!

var customcatalogitems = [CatalogItem]()


var catalogitems = [
    CatalogItem(itemId:"CatalogVegetables",itemname:NSLocalizedString("vegetables", comment: ""),itemimage:UIImage(named: "icvegetables")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"ictomatoes",itemname:NSLocalizedString("tomatoes", comment: ""),itemimage:UIImage(named: "ictomatoes")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCucumbers",itemname:NSLocalizedString("cucumbers", comment: ""),itemimage:UIImage(named: "iccucumbers")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBrocolli",itemname:NSLocalizedString("brocolli", comment: ""),itemimage:UIImage(named: "icbroccoli")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCarrot",itemname:NSLocalizedString("carrot", comment: ""),itemimage:UIImage(named: "iccarrot")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogLettuce",itemname:NSLocalizedString("lettuce", comment: ""),itemimage:UIImage(named: "icsalad")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCabbage",itemname:NSLocalizedString("cabbage", comment: ""),itemimage:UIImage(named: "iccabbage")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogMushrooms",itemname:NSLocalizedString("mushrooms", comment: ""),itemimage:UIImage(named: "icmushrooms")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogOnion",itemname:NSLocalizedString("onion", comment: ""),itemimage:UIImage(named: "iconion")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPotato",itemname:NSLocalizedString("potato", comment: ""),itemimage:UIImage(named: "icpotato")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSpinach",itemname:NSLocalizedString("spinach", comment: ""),itemimage:UIImage(named: "icspinage")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogEggplant",itemname:NSLocalizedString("eggplant", comment: ""),itemimage:UIImage(named: "iceggplant")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPumpkin",itemname:NSLocalizedString("pumpkin", comment: ""),itemimage:UIImage(named: "icpumpkin")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogRadish",itemname:NSLocalizedString("radish", comment: ""),itemimage:UIImage(named: "icradish")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogGarlic",itemname:NSLocalizedString("garlic", comment: ""),itemimage:UIImage(named: "icgarlic")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogGreenBeans",itemname:NSLocalizedString("greenbeans", comment: ""),itemimage:UIImage(named: "icgreenbeans")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBellPepper",itemname:NSLocalizedString("bellpepper", comment: ""),itemimage:UIImage(named: "icpepper")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCorn",itemname:NSLocalizedString("corn", comment: ""),itemimage:UIImage(named: "iccorn")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCelery",itemname:NSLocalizedString("celery", comment: ""),itemimage:UIImage(named: "iccelery")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBeans",itemname:NSLocalizedString("beans", comment: ""),itemimage:UIImage(named: "icbeans")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogAsparagus",itemname:NSLocalizedString("asparagus", comment: ""),itemimage:UIImage(named: "icasparagus")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBeetroot",itemname:NSLocalizedString("beetroot", comment: ""),itemimage:UIImage(named: "icbeetroot")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCauliflower",itemname:NSLocalizedString("cauliflower", comment: ""),itemimage:UIImage(named: "iccauliflower")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCherryTomatoes",itemname:NSLocalizedString("cherrytomatoes", comment: ""),itemimage:UIImage(named: "iccherrytomatoes")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogChillies",itemname:NSLocalizedString("chillies", comment: ""),itemimage:UIImage(named: "icchillies")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogCilantro",itemname:NSLocalizedString("cilantro", comment: ""),itemimage:UIImage(named: "iccilantro")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogZucchini",itemname:NSLocalizedString("zucchini", comment: ""),itemimage:UIImage(named: "iczucchini")!,itemcategory:catalogcategories[1], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogFruits",itemname:NSLocalizedString("fruits", comment: ""),itemimage:UIImage(named: "icfruits")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogApples",itemname:NSLocalizedString("apples", comment: ""),itemimage:UIImage(named: "icapples")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogOranges",itemname:NSLocalizedString("oranges", comment: ""),itemimage:UIImage(named: "icoranges")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogLemons",itemname:NSLocalizedString("lemons", comment: ""),itemimage:UIImage(named: "iclemons")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogLimes",itemname:NSLocalizedString("limes", comment: ""),itemimage:UIImage(named: "iclimes")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBananas",itemname:NSLocalizedString("bananas", comment: ""),itemimage:UIImage(named: "icbananas")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCherries",itemname:NSLocalizedString("cherries", comment: ""),itemimage:UIImage(named: "iccherries")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogGrapefruits",itemname:NSLocalizedString("grapefruits", comment: ""),itemimage:UIImage(named: "icgrapefruits")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogGrapes",itemname:NSLocalizedString("grapes", comment: ""),itemimage:UIImage(named: "icgrapes")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogKiwi",itemname:NSLocalizedString("kiwi", comment: ""),itemimage:UIImage(named: "ickiwi")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogTangerines",itemname:NSLocalizedString("tangerines", comment: ""),itemimage:UIImage(named: "ictangerines")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogMango",itemname:NSLocalizedString("mango", comment: ""),itemimage:UIImage(named: "icmango")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogAvocado",itemname:NSLocalizedString("avocado", comment: ""),itemimage:UIImage(named: "icavocado")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogMelons",itemname:NSLocalizedString("melons", comment: ""),itemimage:UIImage(named: "icmelons")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogStrawberries",itemname:NSLocalizedString("strawberries", comment: ""),itemimage:UIImage(named: "icstrawberries")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBlueberries",itemname:NSLocalizedString("blueberries", comment: ""),itemimage:UIImage(named: "icblueberry")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogRaspberries",itemname:NSLocalizedString("raspberries", comment: ""),itemimage:UIImage(named: "icraspberry")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBlackberries",itemname:NSLocalizedString("blackberries", comment: ""),itemimage:UIImage(named: "icblackberry")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogWatermelon",itemname:NSLocalizedString("watermelon", comment: ""),itemimage:UIImage(named: "icwatermelon")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPeaches",itemname:NSLocalizedString("peaches", comment: ""),itemimage:UIImage(named: "icpeaches")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPears",itemname:NSLocalizedString("pears", comment: ""),itemimage:UIImage(named: "icpears")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPineapples",itemname:NSLocalizedString("pineapples", comment: ""),itemimage:UIImage(named: "icpineapples")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogNectarines",itemname:NSLocalizedString("nectarines", comment: ""),itemimage:UIImage(named: "icnektarines")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPlums",itemname:NSLocalizedString("plums", comment: ""),itemimage:UIImage(named: "icplums")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPapaya",itemname:NSLocalizedString("papaya", comment: ""),itemimage:UIImage(named: "icpapaya")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogFigs",itemname:NSLocalizedString("figs", comment: ""),itemimage:UIImage(named: "icfigs")!,itemcategory:catalogcategories[2], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogDairy",itemname:NSLocalizedString("dairy", comment: ""),itemimage:UIImage(named: "icdairy")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogMilk",itemname:NSLocalizedString("milk", comment: ""),itemimage:UIImage(named: "icmilk")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogButter",itemname:NSLocalizedString("butter", comment: ""),itemimage:UIImage(named: "icbutter")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCheese",itemname:NSLocalizedString("cheese", comment: ""),itemimage:UIImage(named: "iccheese")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCream",itemname:NSLocalizedString("cream", comment: ""),itemimage:UIImage(named: "iccream")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCreamcheese",itemname:NSLocalizedString("creamcheese", comment: ""),itemimage:UIImage(named: "iccreamcheese")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogEggs",itemname:NSLocalizedString("eggs", comment: ""),itemimage:UIImage(named: "iceggs")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogFeta",itemname:NSLocalizedString("feta", comment: ""),itemimage:UIImage(named: "icfeta")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogParmesan",itemname:NSLocalizedString("parmesan", comment: ""),itemimage:UIImage(named: "icparmesan")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogMargarine",itemname:NSLocalizedString("margarine", comment: ""),itemimage:UIImage(named: "icmargarine")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogMascarpone",itemname:NSLocalizedString("mascarpone", comment: ""),itemimage:UIImage(named: "icmascarpone")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogMozarella",itemname:NSLocalizedString("mozarella", comment: ""),itemimage:UIImage(named: "icmozarella")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogRicotta",itemname:NSLocalizedString("ricotta", comment: ""),itemimage:UIImage(named: "icricotta")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSourcream",itemname:NSLocalizedString("sourcream", comment: ""),itemimage:UIImage(named: "icsourcream")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSoymilk",itemname:NSLocalizedString("soymilk", comment: ""),itemimage:UIImage(named: "icsoymilk")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogYogurt",itemname:NSLocalizedString("yogurt", comment: ""),itemimage:UIImage(named: "icyogurt")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSchreddedcheese",itemname:NSLocalizedString("schreddedcheese", comment: ""),itemimage:UIImage(named: "icgratedcheese")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPudding",itemname:NSLocalizedString("pudding", comment: ""),itemimage:UIImage(named: "icpuding")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogDrinkingyogurt",itemname:NSLocalizedString("drinkingyougurt", comment: ""),itemimage:UIImage(named: "icdrinkingyogurt")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCottagecheese",itemname:NSLocalizedString("cottagecheese", comment: ""),itemimage:UIImage(named: "iccottagecheese")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogKefir",itemname:NSLocalizedString("kefir", comment: ""),itemimage:UIImage(named: "ickefir")!,itemcategory:catalogcategories[3], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogMeat",itemname:NSLocalizedString("meat", comment: ""),itemimage:UIImage(named: "icmeat")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBeef",itemname:NSLocalizedString("beef", comment: ""),itemimage:UIImage(named: "icbeef")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogChicken",itemname:NSLocalizedString("chicken", comment: ""),itemimage:UIImage(named: "icchicken2")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogGroundbeef",itemname:NSLocalizedString("groundbeef", comment: ""),itemimage:UIImage(named: "icgroundbeef")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSteak",itemname:NSLocalizedString("steak", comment: ""),itemimage:UIImage(named: "icsteak")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogTurkey",itemname:NSLocalizedString("turkey", comment: ""),itemimage:UIImage(named: "icturkey")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPork",itemname:NSLocalizedString("pork", comment: ""),itemimage:UIImage(named: "icpork")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPorkchops",itemname:NSLocalizedString("porkchops", comment: ""),itemimage:UIImage(named: "icporkchop")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSausages",itemname:NSLocalizedString("sausages", comment: ""),itemimage:UIImage(named: "icsausages")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogDuck",itemname:NSLocalizedString("duck", comment: ""),itemimage:UIImage(named: "icduck")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBacon",itemname:NSLocalizedString("bacon", comment: ""),itemimage:UIImage(named: "icbacon")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogChickenbreast",itemname:NSLocalizedString("chickenbreast", comment: ""),itemimage:UIImage(named: "icchickenbreast")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogHam",itemname:NSLocalizedString("ham", comment: ""),itemimage:UIImage(named: "ickolbasa")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogProsciutto",itemname:NSLocalizedString("prosciutto", comment: ""),itemimage:UIImage(named: "icprosciutto")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSalami",itemname:NSLocalizedString("salami", comment: ""),itemimage:UIImage(named: "icsalami")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogVeal",itemname:NSLocalizedString("veal", comment: ""),itemimage:UIImage(named: "icveal")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBarbeque",itemname:NSLocalizedString("barbeque", comment: ""),itemimage:UIImage(named: "icbbq")!,itemcategory:catalogcategories[4], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogSeafood",itemname:NSLocalizedString("seafood", comment: ""),itemimage:UIImage(named: "icseafood")!,itemcategory:catalogcategories[5], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogAnchovies",itemname:NSLocalizedString("anchovies", comment: ""),itemimage:UIImage(named: "icanchovies")!,itemcategory:catalogcategories[5], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogFish",itemname:NSLocalizedString("fish", comment: ""),itemimage:UIImage(named: "icfish")!,itemcategory:catalogcategories[5], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSalmon",itemname:NSLocalizedString("salmon", comment: ""),itemimage:UIImage(named: "icsalmon")!,itemcategory:catalogcategories[5], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogLobsters",itemname:NSLocalizedString("lobsters", comment: ""),itemimage:UIImage(named: "iclobsters")!,itemcategory:catalogcategories[5], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSchrimps",itemname:NSLocalizedString("schrimps", comment: ""),itemimage:UIImage(named: "icshrimps")!,itemcategory:catalogcategories[5], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogOysters",itemname:NSLocalizedString("oysters", comment: ""),itemimage:UIImage(named: "icoysters")!,itemcategory:catalogcategories[5], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogTuna",itemname:NSLocalizedString("tuna", comment: ""),itemimage:UIImage(named: "ictuna")!,itemcategory:catalogcategories[5], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogClams",itemname:NSLocalizedString("clams", comment: ""),itemimage:UIImage(named: "icclams")!,itemcategory:catalogcategories[5], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogScallops",itemname:NSLocalizedString("scallops", comment: ""),itemimage:UIImage(named: "icscallops")!,itemcategory:catalogcategories[5], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCodfish",itemname:NSLocalizedString("codfish", comment: ""),itemimage:UIImage(named: "iccodfish")!,itemcategory:catalogcategories[5], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPinksalmon",itemname:NSLocalizedString("pinksalmon", comment: ""),itemimage:UIImage(named: "icpinksalmon")!,itemcategory:catalogcategories[5], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSprats",itemname:NSLocalizedString("sprats", comment: ""),itemimage:UIImage(named: "icsprats")!,itemcategory:catalogcategories[5], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogHerring",itemname:NSLocalizedString("herring", comment: ""),itemimage:UIImage(named: "icherring")!,itemcategory:catalogcategories[5], itemischecked:false, itemaddedid: ""),
    
    
    
    CatalogItem(itemId:"CatalogBread",itemname:NSLocalizedString("bread", comment: ""),itemimage:UIImage(named: "icbread")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"Catalogbreadrolls",itemname:NSLocalizedString("breadrolls", comment: ""),itemimage:UIImage(named: "icbreadrolls")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogHamburgerbuns",itemname:NSLocalizedString("hamburgerbuns", comment: ""),itemimage:UIImage(named: "icburgerbuns")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBagels",itemname:NSLocalizedString("bagels", comment: ""),itemimage:UIImage(named: "icbagels")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPie",itemname:NSLocalizedString("pie", comment: ""),itemimage:UIImage(named: "icpie")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogDarkbread",itemname:NSLocalizedString("darkbread", comment: ""),itemimage:UIImage(named: "ichleb")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCookies",itemname:NSLocalizedString("cookies", comment: ""),itemimage:UIImage(named: "iccookies")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCakes",itemname:NSLocalizedString("cakes", comment: ""),itemimage:UIImage(named: "iccake")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogWaffels",itemname:NSLocalizedString("waffles", comment: ""),itemimage:UIImage(named: "icwaffles")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPretzels",itemname:NSLocalizedString("pretzels", comment: ""),itemimage:UIImage(named: "icpretzels")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCroissants",itemname:NSLocalizedString("croissants", comment: ""),itemimage:UIImage(named: "iccroissants")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBiscuits",itemname:NSLocalizedString("biscuits", comment: ""),itemimage:UIImage(named: "icbiscuit")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCrispbread",itemname:NSLocalizedString("crispbread", comment: ""),itemimage:UIImage(named: "iccrispbread")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogMuffins",itemname:NSLocalizedString("muffins", comment: ""),itemimage:UIImage(named: "icmuffin")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogToasts",itemname:NSLocalizedString("toasts", comment: ""),itemimage:UIImage(named: "ictoasts")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPizzadough",itemname:NSLocalizedString("pizzadough", comment: ""),itemimage:UIImage(named: "icpizzadough")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSlicedbread",itemname:NSLocalizedString("slicedbread", comment: ""),itemimage:UIImage(named: "icslicedbread")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogTortillas",itemname:NSLocalizedString("tortillas", comment: ""),itemimage:UIImage(named: "ictortillas")!,itemcategory:catalogcategories[6], itemischecked:false, itemaddedid: ""),
    
    
    CatalogItem(itemId:"CatalogSnacks",itemname:NSLocalizedString("snacks", comment: ""),itemimage:UIImage(named: "icsnacks")!,itemcategory:catalogcategories[7], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogChips",itemname:NSLocalizedString("chips", comment: ""),itemimage:UIImage(named: "icchips")!,itemcategory:catalogcategories[7], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogDriedfruits",itemname:NSLocalizedString("driedfruits", comment: ""),itemimage:UIImage(named: "icdriedfruits")!,itemcategory:catalogcategories[7], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCrackers",itemname:NSLocalizedString("crackers", comment: ""),itemimage:UIImage(named: "iccrackers")!,itemcategory:catalogcategories[7], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogNachoes",itemname:NSLocalizedString("nachoes", comment: ""),itemimage:UIImage(named: "icnachos")!,itemcategory:catalogcategories[7], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPopcorn",itemname:NSLocalizedString("popcorn", comment: ""),itemimage:UIImage(named: "icpopcorn")!,itemcategory:catalogcategories[7], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPeanuts",itemname:NSLocalizedString("peanuts", comment: ""),itemimage:UIImage(named: "icpeanuts")!,itemcategory:catalogcategories[7], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogNuts",itemname:NSLocalizedString("nuts", comment: ""),itemimage:UIImage(named: "icnuts")!,itemcategory:catalogcategories[7], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPistachios",itemname:NSLocalizedString("pistachios", comment: ""),itemimage:UIImage(named: "icpistachos")!,itemcategory:catalogcategories[7], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCahsews",itemname:NSLocalizedString("cashews", comment: ""),itemimage:UIImage(named: "iccashews")!,itemcategory:catalogcategories[7], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogGreenolives",itemname:NSLocalizedString("greenolives", comment: ""),itemimage:UIImage(named: "icolives")!,itemcategory:catalogcategories[7], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBlackolives",itemname:NSLocalizedString("blackolives", comment: ""),itemimage:UIImage(named: "icblackolives")!,itemcategory:catalogcategories[7], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogBeverages",itemname:NSLocalizedString("beverages", comment: ""),itemimage:UIImage(named: "icbeverages")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogWater",itemname:NSLocalizedString("water", comment: ""),itemimage:UIImage(named: "icwater")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogMineralwater",itemname:NSLocalizedString("mineralwater", comment: ""),itemimage:UIImage(named: "icmineralwater")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogJuice",itemname:NSLocalizedString("juice", comment: ""),itemimage:UIImage(named: "icjuice")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogOrangejuice",itemname:NSLocalizedString("orangejuice", comment: ""),itemimage:UIImage(named: "icorangejuice")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogApplejuice",itemname:NSLocalizedString("applejuice", comment: ""),itemimage:UIImage(named: "icapplejuice")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCherryjuice",itemname:NSLocalizedString("cherryjuice", comment: ""),itemimage:UIImage(named: "iccherryjuice")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogGrapejuice",itemname:NSLocalizedString("grapejuice", comment: ""),itemimage:UIImage(named: "icgrapejuice")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogLemonjuice",itemname:NSLocalizedString("lemonjuice", comment: ""),itemimage:UIImage(named: "iclemonjuice")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCocacola",itemname:NSLocalizedString("cocacola", comment: ""),itemimage:UIImage(named: "iccocacola")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPepsi",itemname:NSLocalizedString("pepsi", comment: ""),itemimage:UIImage(named: "icpepsi")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogLemonade",itemname:NSLocalizedString("lemonade", comment: ""),itemimage:UIImage(named: "iclemonade")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogDrpepper",itemname:NSLocalizedString("drpepper", comment: ""),itemimage:UIImage(named: "icdrpepper")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"Catalog5lwater",itemname:NSLocalizedString("5lwater", comment: ""),itemimage:UIImage(named: "ic5lwater")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogTea",itemname:NSLocalizedString("tea", comment: ""),itemimage:UIImage(named: "ictea")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCoffee",itemname:NSLocalizedString("coffee", comment: ""),itemimage:UIImage(named: "iccoffee")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogIcetea",itemname:NSLocalizedString("icetea", comment: ""),itemimage:UIImage(named: "icicetea")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCider",itemname:NSLocalizedString("cider", comment: ""),itemimage:UIImage(named: "iccider")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogHotchocolade",itemname:NSLocalizedString("hotchocolate", comment: ""),itemimage:UIImage(named: "ichotchocolate")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogEnergydrink",itemname:NSLocalizedString("energydrink", comment: ""),itemimage:UIImage(named: "icenergy")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSportdrink",itemname:NSLocalizedString("sportdrink", comment: ""),itemimage:UIImage(named: "icsportdrink")!,itemcategory:catalogcategories[8], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogAlcohol",itemname:NSLocalizedString("alcohol", comment: ""),itemimage:UIImage(named: "icalcohol")!,itemcategory:catalogcategories[9], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBeer",itemname:NSLocalizedString("beer", comment: ""),itemimage:UIImage(named: "icbeer")!,itemcategory:catalogcategories[9], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogChampagne",itemname:NSLocalizedString("champagne", comment: ""),itemimage:UIImage(named: "icchampagne")!,itemcategory:catalogcategories[9], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogVodka",itemname:NSLocalizedString("vodka", comment: ""),itemimage:UIImage(named: "icvodka")!,itemcategory:catalogcategories[9], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogRedrum",itemname:NSLocalizedString("redrum", comment: ""),itemimage:UIImage(named: "icredrum")!,itemcategory:catalogcategories[9], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogWhiterum",itemname:NSLocalizedString("whiterum", comment: ""),itemimage:UIImage(named: "icwhiterum")!,itemcategory:catalogcategories[9], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogTequila",itemname:NSLocalizedString("tequila", comment: ""),itemimage:UIImage(named: "ictequila")!,itemcategory:catalogcategories[9], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogWhiskey",itemname:NSLocalizedString("whiskey", comment: ""),itemimage:UIImage(named: "icwhiskey")!,itemcategory:catalogcategories[9], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogGin",itemname:NSLocalizedString("gin", comment: ""),itemimage:UIImage(named: "icgin")!,itemcategory:catalogcategories[9], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogTonic",itemname:NSLocalizedString("tonic", comment: ""),itemimage:UIImage(named: "ictonic")!,itemcategory:catalogcategories[9], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogProsecco",itemname:NSLocalizedString("prosecco", comment: ""),itemimage:UIImage(named: "icprosecco")!,itemcategory:catalogcategories[9], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogWine",itemname:NSLocalizedString("justwine", comment: ""),itemimage:UIImage(named: "icredwine")!,itemcategory:catalogcategories[9], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogRedwine",itemname:NSLocalizedString("redwine", comment: ""),itemimage:UIImage(named: "icredwine")!,itemcategory:catalogcategories[9], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogWhitewine",itemname:NSLocalizedString("whitewine", comment: ""),itemimage:UIImage(named: "icwhitewine")!,itemcategory:catalogcategories[9], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPinkwine",itemname:NSLocalizedString("pinkwine", comment: ""),itemimage:UIImage(named: "icpinkwine")!,itemcategory:catalogcategories[9], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogCereals",itemname:NSLocalizedString("cereals", comment: ""),itemimage:UIImage(named: "iccereals")!,itemcategory:catalogcategories[10], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogHoney",itemname:NSLocalizedString("honey", comment: ""),itemimage:UIImage(named: "ichoney")!,itemcategory:catalogcategories[10], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogOatmeal",itemname:NSLocalizedString("oatmeal", comment: ""),itemimage:UIImage(named: "icoatmeal")!,itemcategory:catalogcategories[10], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCornflakes",itemname:NSLocalizedString("cornflakes", comment: ""),itemimage:UIImage(named: "iccornflakes")!,itemcategory:catalogcategories[10], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogNesquick",itemname:NSLocalizedString("nesquick", comment: ""),itemimage:UIImage(named: "icnesquick")!,itemcategory:catalogcategories[10], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogGranola",itemname:NSLocalizedString("granola", comment: ""),itemimage:UIImage(named: "icgranola")!,itemcategory:catalogcategories[10], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogJam",itemname:NSLocalizedString("jam", comment: ""),itemimage:UIImage(named: "icjam")!,itemcategory:catalogcategories[10], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogMuesli",itemname:NSLocalizedString("muesli", comment: ""),itemimage:UIImage(named: "icmuesli")!,itemcategory:catalogcategories[10], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPorridge",itemname:NSLocalizedString("porridge", comment: ""),itemimage:UIImage(named: "icporridge")!,itemcategory:catalogcategories[10], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPancakes",itemname:NSLocalizedString("pancakes", comment: ""),itemimage:UIImage(named: "icpancakes")!,itemcategory:catalogcategories[10], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogSweets",itemname:NSLocalizedString("sweets", comment: ""),itemimage:UIImage(named: "icsweets")!,itemcategory:catalogcategories[11], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogChocolate",itemname:NSLocalizedString("chocolate", comment: ""),itemimage:UIImage(named: "icchocolate")!,itemcategory:catalogcategories[11], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCandy",itemname:NSLocalizedString("candy", comment: ""),itemimage:UIImage(named: "iccandy")!,itemcategory:catalogcategories[11], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogChewinggum",itemname:NSLocalizedString("chewinggum", comment: ""),itemimage:UIImage(named: "icchewinggum")!,itemcategory:catalogcategories[11], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogNougat",itemname:NSLocalizedString("nougatcreme", comment: ""),itemimage:UIImage(named: "icnougatcreme")!,itemcategory:catalogcategories[11], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogChocolatecream",itemname:NSLocalizedString("chocolatecream", comment: ""),itemimage:UIImage(named: "icchocolatecream")!,itemcategory:catalogcategories[11], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogDessert",itemname:NSLocalizedString("dessert", comment: ""),itemimage:UIImage(named: "icdessert")!,itemcategory:catalogcategories[11], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogChristmascookies",itemname:NSLocalizedString("christmascookies", comment: ""),itemimage:UIImage(named: "icchristmascookies")!,itemcategory:catalogcategories[11], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogOil",itemname:NSLocalizedString("oil", comment: ""),itemimage:UIImage(named: "icoil")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogOliveoil",itemname:NSLocalizedString("oliveoil", comment: ""),itemimage:UIImage(named: "icoliveoil")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSpices",itemname:NSLocalizedString("spices", comment: ""),itemimage:UIImage(named: "icspices")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSalt",itemname:NSLocalizedString("salt", comment: ""),itemimage:UIImage(named: "icsalt")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSugar",itemname:NSLocalizedString("sugar", comment: ""),itemimage:UIImage(named: "icsugar")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPepper",itemname:NSLocalizedString("pepper", comment: ""),itemimage:UIImage(named: "icsmallpepper")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogMayonnaise",itemname:NSLocalizedString("mayonnaise", comment: ""),itemimage:UIImage(named: "icmayonnaise")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogMustard",itemname:NSLocalizedString("mustard", comment: ""),itemimage:UIImage(named: "icmustard")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogKetchup",itemname:NSLocalizedString("ketchup", comment: ""),itemimage:UIImage(named: "icketchup")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSalsa",itemname:NSLocalizedString("salsa", comment: ""),itemimage:UIImage(named: "icsalsasauce")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPastasauce",itemname:NSLocalizedString("pastasauce", comment: ""),itemimage:UIImage(named: "icpastasauce")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSeasonings",itemname:NSLocalizedString("seasonings", comment: ""),itemimage:UIImage(named: "icseasonings")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSyrup",itemname:NSLocalizedString("syrup", comment: ""),itemimage:UIImage(named: "icsyrup")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSoysauce",itemname:NSLocalizedString("soysauce", comment: ""),itemimage:UIImage(named: "icsoysauce")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBrownsugar",itemname:NSLocalizedString("brownsugar", comment: ""),itemimage:UIImage(named: "icbrownsugar")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogFlour",itemname:NSLocalizedString("flour", comment: ""),itemimage:UIImage(named: "icflour")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogJelly",itemname:NSLocalizedString("jelly", comment: ""),itemimage:UIImage(named: "icjelly")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPeanutbutter",itemname:NSLocalizedString("peanutbutter", comment: ""),itemimage:UIImage(named: "icpeanutbutter")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBbqsauce",itemname:NSLocalizedString("bbqsauce", comment: ""),itemimage:UIImage(named: "icbbqsauce")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBakingpowder",itemname:NSLocalizedString("bakingpowder", comment: ""),itemimage:UIImage(named: "icbakingpowder")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBalsamicvinegar",itemname:NSLocalizedString("balsamicvinegar", comment: ""),itemimage:UIImage(named: "icbalsamicvinegar")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSoda2",itemname:NSLocalizedString("soda2", comment: ""),itemimage:UIImage(named: "icsoda2")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBreadcrumbs",itemname:NSLocalizedString("breadcrumbs", comment: ""),itemimage:UIImage(named: "icbreadcrumbs")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCinnamon",itemname:NSLocalizedString("cinnamon", comment: ""),itemimage:UIImage(named: "iccinnamon")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogMaplesyrup",itemname:NSLocalizedString("maplesyrup", comment: ""),itemimage:UIImage(named: "icmaplesyrup")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPaprika",itemname:NSLocalizedString("paprika", comment: ""),itemimage:UIImage(named: "icpaprika")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSaladdressing",itemname:NSLocalizedString("saladdressing", comment: ""),itemimage:UIImage(named: "icsaladdressing")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogVanilla",itemname:NSLocalizedString("vanilla", comment: ""),itemimage:UIImage(named: "icvanilla")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogYeast",itemname:NSLocalizedString("yeast", comment: ""),itemimage:UIImage(named: "icyeast")!,itemcategory:catalogcategories[12], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogCannedfood",itemname:NSLocalizedString("cannedfood", comment: ""),itemimage:UIImage(named: "iccannedfood")!,itemcategory:catalogcategories[13], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCannedbeans",itemname:NSLocalizedString("cannedbeans", comment: ""),itemimage:UIImage(named: "iccannedbeans")!,itemcategory:catalogcategories[13], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCannedcorn",itemname:NSLocalizedString("cannedcorn", comment: ""),itemimage:UIImage(named: "iccannedcorn")!,itemcategory:catalogcategories[13], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCannedfruits",itemname:NSLocalizedString("cannedfruits", comment: ""),itemimage:UIImage(named: "iccannedfruits")!,itemcategory:catalogcategories[13], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCannedfish",itemname:NSLocalizedString("cannedfish", comment: ""),itemimage:UIImage(named: "iccannedfish")!,itemcategory:catalogcategories[13], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCannedsoup",itemname:NSLocalizedString("cannedsoup", comment: ""),itemimage:UIImage(named: "iccannedsoup")!,itemcategory:catalogcategories[13], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogPastamacaroni",itemname:NSLocalizedString("pastamacaroni", comment: ""),itemimage:UIImage(named: "icpasta")!,itemcategory:catalogcategories[14], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSpaghetti",itemname:NSLocalizedString("spaghetti", comment: ""),itemimage:UIImage(named: "icspaghetti")!,itemcategory:catalogcategories[14], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogNoodles",itemname:NSLocalizedString("noodles", comment: ""),itemimage:UIImage(named: "icnoodles")!,itemcategory:catalogcategories[14], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogVermicelli",itemname:NSLocalizedString("vermicelli", comment: ""),itemimage:UIImage(named: "icvermicelli")!,itemcategory:catalogcategories[14], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogGrains",itemname:NSLocalizedString("grains", comment: ""),itemimage:UIImage(named: "icgrains")!,itemcategory:catalogcategories[15], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogRice",itemname:NSLocalizedString("rice", comment: ""),itemimage:UIImage(named: "icrice")!,itemcategory:catalogcategories[15], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBrownrice",itemname:NSLocalizedString("brownrice", comment: ""),itemimage:UIImage(named: "icbrownrice")!,itemcategory:catalogcategories[15], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCouscous",itemname:NSLocalizedString("couscous", comment: ""),itemimage:UIImage(named: "iccouscous")!,itemcategory:catalogcategories[15], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogRisottorice",itemname:NSLocalizedString("risottorice", comment: ""),itemimage:UIImage(named: "icrisotto")!,itemcategory:catalogcategories[15], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogWildrice",itemname:NSLocalizedString("wildrice", comment: ""),itemimage:UIImage(named: "icwildrice")!,itemcategory:catalogcategories[15], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogFrozengoods",itemname:NSLocalizedString("frozengoods", comment: ""),itemimage:UIImage(named: "icfrozenfood")!,itemcategory:catalogcategories[16], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogIcecream",itemname:NSLocalizedString("icecream", comment: ""),itemimage:UIImage(named: "icicecream")!,itemcategory:catalogcategories[16], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogFrozenfruits",itemname:NSLocalizedString("frozenfruits", comment: ""),itemimage:UIImage(named: "icfrozenfruits")!,itemcategory:catalogcategories[16], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogFrozenvegetables",itemname:NSLocalizedString("frozenvegetables", comment: ""),itemimage:UIImage(named: "icfrozenvegetables")!,itemcategory:catalogcategories[16], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPizza",itemname:NSLocalizedString("frozenpizza", comment: ""),itemimage:UIImage(named: "icfrozenpizza")!,itemcategory:catalogcategories[16], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogFrozenmeals",itemname:NSLocalizedString("frozenmeals", comment: ""),itemimage:UIImage(named: "icfrozenmeals")!,itemcategory:catalogcategories[16], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogFrozenfish",itemname:NSLocalizedString("frozenfish", comment: ""),itemimage:UIImage(named: "icfrozenfish")!,itemcategory:catalogcategories[16], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogFrozenfries",itemname:NSLocalizedString("frozenfries", comment: ""),itemimage:UIImage(named: "icfrozenfries")!,itemcategory:catalogcategories[16], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogFrozennuggets",itemname:NSLocalizedString("frozennuggets", comment: ""),itemimage:UIImage(named: "icfrozennuggets")!,itemcategory:catalogcategories[16], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogFrozenpancakes",itemname:NSLocalizedString("frozenpancakes", comment: ""),itemimage:UIImage(named: "icfrozenpancakes")!,itemcategory:catalogcategories[16], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogBabyfood",itemname:NSLocalizedString("babyfood", comment: ""),itemimage:UIImage(named: "icbabyfood")!,itemcategory:catalogcategories[17], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogDiapers",itemname:NSLocalizedString("diapers", comment: ""),itemimage:UIImage(named: "icdiapers")!,itemcategory:catalogcategories[17], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogWipes",itemname:NSLocalizedString("wipes", comment: ""),itemimage:UIImage(named: "icbabywipes")!,itemcategory:catalogcategories[17], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBabyshampoo",itemname:NSLocalizedString("babyshampoo", comment: ""),itemimage:UIImage(named: "icbabyshampoo")!,itemcategory:catalogcategories[17], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBabysoap",itemname:NSLocalizedString("babysoap", comment: ""),itemimage:UIImage(named: "icbabysoap")!,itemcategory:catalogcategories[17], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBabyoil",itemname:NSLocalizedString("babyoil", comment: ""),itemimage:UIImage(named: "icbabyoil")!,itemcategory:catalogcategories[17], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBabypowder",itemname:NSLocalizedString("babypowder", comment: ""),itemimage:UIImage(named: "icbabypowder")!,itemcategory:catalogcategories[17], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPacifiers",itemname:NSLocalizedString("pacifiers", comment: ""),itemimage:UIImage(named: "icpacifiers")!,itemcategory:catalogcategories[17], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogRashcream",itemname:NSLocalizedString("rashcream", comment: ""),itemimage:UIImage(named: "icrash")!,itemcategory:catalogcategories[17], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSanitizer",itemname:NSLocalizedString("sanitizer", comment: ""),itemimage:UIImage(named: "icsanitizer")!,itemcategory:catalogcategories[17], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogToddler",itemname:NSLocalizedString("toddler", comment: ""),itemimage:UIImage(named: "ictoddler")!,itemcategory:catalogcategories[17], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogDogfood",itemname:NSLocalizedString("dogfood", comment: ""),itemimage:UIImage(named: "icdogfood")!,itemcategory:catalogcategories[18], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCatfood",itemname:NSLocalizedString("catfood", comment: ""),itemimage:UIImage(named: "iccatfood")!,itemcategory:catalogcategories[18], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBirdfood",itemname:NSLocalizedString("birdfood", comment: ""),itemimage:UIImage(named: "icbirdfood")!,itemcategory:catalogcategories[18], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogDogtreats",itemname:NSLocalizedString("dogtreats", comment: ""),itemimage:UIImage(named: "icdogtreats")!,itemcategory:catalogcategories[18], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCattreats",itemname:NSLocalizedString("cattreats", comment: ""),itemimage:UIImage(named: "iccattreats")!,itemcategory:catalogcategories[18], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogFishfood",itemname:NSLocalizedString("fishfood", comment: ""),itemimage:UIImage(named: "icfishfood")!,itemcategory:catalogcategories[18], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCatlitter",itemname:NSLocalizedString("catlitter", comment: ""),itemimage:UIImage(named: "iccatlitter")!,itemcategory:catalogcategories[18], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogBodylotion",itemname:NSLocalizedString("bodylotion", comment: ""),itemimage:UIImage(named: "icbodylotion")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogShampoo",itemname:NSLocalizedString("shampoo", comment: ""),itemimage:UIImage(named: "icshampoo")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogHairconditioner",itemname:NSLocalizedString("hairconditioner", comment: ""),itemimage:UIImage(named: "ichairconditioner")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCondoms",itemname:NSLocalizedString("condoms", comment: ""),itemimage:UIImage(named: "iccondoms")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogLenssolution",itemname:NSLocalizedString("lenssolution", comment: ""),itemimage:UIImage(named: "iclenssolution")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCottonpads",itemname:NSLocalizedString("cottonpads", comment: ""),itemimage:UIImage(named: "iccottonpads")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogDentalfloss",itemname:NSLocalizedString("dentalfloss", comment: ""),itemimage:UIImage(named: "icdentalfloss")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCottonswabs",itemname:NSLocalizedString("cottonswabs", comment: ""),itemimage:UIImage(named: "iccottonswabs")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogDeodorant",itemname:NSLocalizedString("deodorant", comment: ""),itemimage:UIImage(named: "icdeodorant")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogFacecream",itemname:NSLocalizedString("facecream", comment: ""),itemimage:UIImage(named: "icfacecream")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogFacialtissues",itemname:NSLocalizedString("facialtissues", comment: ""),itemimage:UIImage(named: "icfacialtissues")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogToothpaste",itemname:NSLocalizedString("toothpaste", comment: ""),itemimage:UIImage(named: "ictoothpaste")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogToothbrush",itemname:NSLocalizedString("toothbrush", comment: ""),itemimage:UIImage(named: "ictoothbrush")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogHairgel",itemname:NSLocalizedString("hairgel", comment: ""),itemimage:UIImage(named: "ichairgel")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogHairspray",itemname:NSLocalizedString("hairspray", comment: ""),itemimage:UIImage(named: "ichairspray")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogHandcream",itemname:NSLocalizedString("handcream", comment: ""),itemimage:UIImage(named: "ichandcream")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogMouthwash",itemname:NSLocalizedString("mouthwash", comment: ""),itemimage:UIImage(named: "icmouthwash")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogNailpolish",itemname:NSLocalizedString("nailpolish", comment: ""),itemimage:UIImage(named: "icnailpolish")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogNailpolishremover",itemname:NSLocalizedString("nailpolishremover", comment: ""),itemimage:UIImage(named: "icnailpolishremover")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogRazor",itemname:NSLocalizedString("razor", comment: ""),itemimage:UIImage(named: "icrazor")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogRazorblades",itemname:NSLocalizedString("razorblades", comment: ""),itemimage:UIImage(named: "icrazorblades")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogShavingcream",itemname:NSLocalizedString("shavingcream", comment: ""),itemimage:UIImage(named: "icshavingcream")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogShowergel",itemname:NSLocalizedString("showergel", comment: ""),itemimage:UIImage(named: "icshowergel")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSoap",itemname:NSLocalizedString("soap", comment: ""),itemimage:UIImage(named: "icsoap")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSunscreen",itemname:NSLocalizedString("sunscreen", comment: ""),itemimage:UIImage(named: "icsunscreen")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogTampons",itemname:NSLocalizedString("tampons", comment: ""),itemimage:UIImage(named: "ictampons")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogTissues",itemname:NSLocalizedString("tissues", comment: ""),itemimage:UIImage(named: "ictissues")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogWetwipes",itemname:NSLocalizedString("wetwipes", comment: ""),itemimage:UIImage(named: "icwetwipes")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogAftershave",itemname:NSLocalizedString("aftershave", comment: ""),itemimage:UIImage(named: "icaftershave")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogMascara",itemname:NSLocalizedString("mascara", comment: ""),itemimage:UIImage(named: "icmascara")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogEyeshadow",itemname:NSLocalizedString("eyeshadow", comment: ""),itemimage:UIImage(named: "iceyeshadow")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogLipstick",itemname:NSLocalizedString("lipstick", comment: ""),itemimage:UIImage(named: "iclipstick")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCottonballs",itemname:NSLocalizedString("cottonballs", comment: ""),itemimage:UIImage(named: "iccottonballs")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogToothpicks",itemname:NSLocalizedString("toothpicks", comment: ""),itemimage:UIImage(named: "ictoothsticks")!,itemcategory:catalogcategories[19], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogMedications",itemname:NSLocalizedString("medications", comment: ""),itemimage:UIImage(named: "icmedications")!,itemcategory:catalogcategories[20], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPlasters",itemname:NSLocalizedString("plasters", comment: ""),itemimage:UIImage(named: "icplasters")!,itemcategory:catalogcategories[20], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPainreliever",itemname:NSLocalizedString("painreliever", comment: ""),itemimage:UIImage(named: "icpainrelievers")!,itemcategory:catalogcategories[20], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogVitamins",itemname:NSLocalizedString("vitamins", comment: ""),itemimage:UIImage(named: "icvitamins")!,itemcategory:catalogcategories[20], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogAntiflewtreatments",itemname:NSLocalizedString("antiflewtreatments", comment: ""),itemimage:UIImage(named: "icantiflu")!,itemcategory:catalogcategories[20], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPyretic",itemname:NSLocalizedString("pyretic", comment: ""),itemimage:UIImage(named: "icpyretic")!,itemcategory:catalogcategories[20], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogSponge",itemname:NSLocalizedString("sponge", comment: ""),itemimage:UIImage(named: "icsponge")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPapertowel",itemname:NSLocalizedString("papertowel", comment: ""),itemimage:UIImage(named: "icpapertowels")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogToiletpaper",itemname:NSLocalizedString("toiletpaper", comment: ""),itemimage:UIImage(named: "ictoiletpaper")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogDisinfectant",itemname:NSLocalizedString("disinfectant", comment: ""),itemimage:UIImage(named: "icdisinfectant")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogLaundrypowder",itemname:NSLocalizedString("washingpowder", comment: ""),itemimage:UIImage(named: "iclaundrypowder")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogLaundrydetergent",itemname:NSLocalizedString("laundrydetergent", comment: ""),itemimage:UIImage(named: "iclaundrydetergent")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogDishsoap",itemname:NSLocalizedString("dishsoap", comment: ""),itemimage:UIImage(named: "icdishsoap")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogWipes1",itemname:NSLocalizedString("wipes1", comment: ""),itemimage:UIImage(named: "icwipes1")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogTrahsbugs",itemname:NSLocalizedString("trashbags", comment: ""),itemimage:UIImage(named: "ictrashbags")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBucket",itemname:NSLocalizedString("bucket", comment: ""),itemimage:UIImage(named: "icbucket")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogSqueegee",itemname:NSLocalizedString("squeegee", comment: ""),itemimage:UIImage(named: "icsqueegee")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogLiquidsoap",itemname:NSLocalizedString("liquidsoap", comment: ""),itemimage:UIImage(named: "icliquidsoap")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogAluminiumfoil",itemname:NSLocalizedString("aluminiumfoil", comment: ""),itemimage:UIImage(named: "icaluminiumfoil")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBathroomcleaner",itemname:NSLocalizedString("bathroomcleaner", comment: ""),itemimage:UIImage(named: "icbathroomcleaner")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogToiletcleaner",itemname:NSLocalizedString("toiletcleaner", comment: ""),itemimage:UIImage(named: "ictoiletcleaner")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBatteries",itemname:NSLocalizedString("batteries", comment: ""),itemimage:UIImage(named: "icbatteries")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCandles",itemname:NSLocalizedString("candles", comment: ""),itemimage:UIImage(named: "iccandles")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogCharcoal",itemname:NSLocalizedString("charcoal", comment: ""),itemimage:UIImage(named: "iccharcoal")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogDishwashersalt",itemname:NSLocalizedString("dishwashersalt", comment: ""),itemimage:UIImage(named: "icdishwashersalt")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogDishwashertabs",itemname:NSLocalizedString("dishwashertabs", comment: ""),itemimage:UIImage(named: "icdishwashertabs")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogDishwashingliquid",itemname:NSLocalizedString("dishwashingliquid", comment: ""),itemimage:UIImage(named: "icdishliquid")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogFabricsoftener",itemname:NSLocalizedString("fabricsoftener", comment: ""),itemimage:UIImage(named: "icfabricsoftener")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogGlasscleaner",itemname:NSLocalizedString("glasscleaner", comment: ""),itemimage:UIImage(named: "icglasscleaner")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPlasticwrap",itemname:NSLocalizedString("plasticwrap", comment: ""),itemimage:UIImage(named: "icplasticwrap")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogWrappingpaper",itemname:NSLocalizedString("wrappingpaper", comment: ""),itemimage:UIImage(named: "icwrappingpaper")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogBrazier",itemname:NSLocalizedString("brazier", comment: ""),itemimage:UIImage(named: "icbrazier")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPlasticplates",itemname:NSLocalizedString("plasticplates", comment: ""),itemimage:UIImage(named: "icplasticplates")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogPlasticcups",itemname:NSLocalizedString("plasticcups", comment: ""),itemimage:UIImage(named: "icplasticcups")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogIgnition",itemname:NSLocalizedString("ignition", comment: ""),itemimage:UIImage(named: "icignition")!,itemcategory:catalogcategories[21], itemischecked:false, itemaddedid: ""),
    
    CatalogItem(itemId:"CatalogCigarettes",itemname:NSLocalizedString("cigarettes", comment: ""),itemimage:UIImage(named: "iccigarettes")!,itemcategory:catalogcategories[22], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogLighter",itemname:NSLocalizedString("lighter", comment: ""),itemimage:UIImage(named: "iclighter")!,itemcategory:catalogcategories[22], itemischecked:false, itemaddedid: ""),
    CatalogItem(itemId:"CatalogTobacco",itemname:NSLocalizedString("tobacco", comment: ""),itemimage:UIImage(named: "ictobacco")!,itemcategory:catalogcategories[22], itemischecked:false, itemaddedid: "")
    
]

/*
var catalogitems = [
    CatalogItem(itemId:"CatalogApples",itemname:NSLocalizedString("apples", comment: ""),itemimage:UIImage(named: "apple-fruit-icon.jpg")!,itemcategory:catalogcategories[2], itemischecked:false),
    CatalogItem(itemId:"CatalogBananas",itemname:NSLocalizedString("bananas", comment: ""),itemimage:UIImage(named: "Banana.png")!,itemcategory:catalogcategories[2], itemischecked:false),
    CatalogItem(itemId:"CatalogTomatoes",itemname:NSLocalizedString("tomatoes", comment: ""),itemimage:UIImage(named: "tomato.png")!,itemcategory:catalogcategories[1], itemischecked:false),
    CatalogItem(itemId:"CatalogCucumbers",itemname:NSLocalizedString("cucumbers", comment: ""),itemimage:UIImage(named: "Cucumber.png")!,itemcategory:catalogcategories[1], itemischecked:false),
    CatalogItem(itemId:"CatalogPotato",itemname:NSLocalizedString("potato", comment: ""),itemimage:UIImage(named: "activity.png")!,itemcategory:catalogcategories[1], itemischecked:false),
    CatalogItem(itemId:"CatalogWater",itemname:NSLocalizedString("water", comment: ""),itemimage:UIImage(named: "agua_256.png")!,itemcategory:catalogcategories[3], itemischecked:false),
    CatalogItem(itemId:"CatalogCabbage",itemname:NSLocalizedString("cabbage", comment: ""),itemimage:UIImage(named: "check.png")!,itemcategory:catalogcategories[1], itemischecked:false),
    CatalogItem(itemId:"CatalogWatermelon",itemname:NSLocalizedString("watermelon", comment: ""),itemimage:UIImage(named: "plus.png")!,itemcategory:catalogcategories[1], itemischecked:false),
    CatalogItem(itemId:"CatalogWhatever",itemname:NSLocalizedString("whatever", comment: ""),itemimage:UIImage(named: "restau.png")!,itemcategory:catalogcategories[1], itemischecked:false),
    
]
*/

/*
var catalogitems = [
CatalogItem(itemId:"CatalogApples",itemname:"Apples",itemimage:UIImage(named: "apple-fruit-icon.jpg")!,itemcategory:catalogcategories[2].catId),
CatalogItem(itemId:"CatalogBananas",itemname:"Bananas",itemimage:UIImage(named: "Banana.png")!,itemcategory:catalogcategories[2].catId),
CatalogItem(itemId:"CatalogTomatoes",itemname:"Tomatoes",itemimage:UIImage(named: "tomato.png")!,itemcategory:catalogcategories[1].catId),
CatalogItem(itemId:"CatalogCucumbers",itemname:"Cucumbers",itemimage:UIImage(named: "Cucumber.png")!,itemcategory:catalogcategories[1].catId),
CatalogItem(itemId:"CatalogWater",itemname:"Water",itemimage:UIImage(named: "aqua_256.png")!,itemcategory:catalogcategories[3].catId)

]
*/
//var itemsDataDict = [Dictionary<String, AnyObject>]()

var itemsDataDict = [Dictionary<String, AnyObject>]()

var itemsorderarray = [String]()

var shoppingcheckedtocopy = [Bool]()

var itemsinbuffer = [Dictionary<String, AnyObject>]()

var itemsinbuffertopaste = [Dictionary<String, AnyObject>]()

var DefaultCurrency : String = "EUR"

var itemidsincurrentlist = [String]()

//var currencies : [[AnyObject]] = [["EUR","EU"],["RUB","RU"],["USD","US"]]

//var currencies = [[AnyObject]]()
var currencies = [[String]]() // Later make short list of usual currencies and then in settings let user add more from picker

protocol passListtoMenuDelegate
{
    func getshoplistparameters(isFrom:Bool,listid:String,isreceived:Bool)
}


var symbol = String()
var code = String()



class ShoppingListCreation: UIViewController, UITableViewDelegate, UITableViewDataSource, RefreshListDelegate, MPGTextFieldDelegateCatalog, UIPopoverPresentationControllerDelegate, OptionsPopupDelegate, UITextFieldDelegate, takepicturedelegate, UIGestureRecognizerDelegate, UITextViewDelegate, CategoryPopupDelegate, ImagesPopupDelegate, UIPickerViewDataSource, UIPickerViewDelegate, ManageCatsDelegate {//, sendBackParametersToShopDelegate, SmallPopupDelegate {
    
    var delegateforlist : passListtoMenuDelegate?
    
    func handlecustomcat(added: Bool) {
        //

        if added == true {
            horizontalScrollView.removeAllItems()
            categoriessetup()
            
            var lastcatitem : Int = catalogcategories.count - 1
            var vel: CGPoint = CGPointMake(horizontalScrollView.finditem(lastcatitem - 1, inScrollView: horizontalScrollView), 0.0)
            horizontalScrollView.contentOffset = vel
        }
    }
    
    func choosecategory(category:Category) {
        
        
       // quickcategorybutton.setTitle(category.catname, forState: .Normal)
        quickicon.image = category.catimage
        //itemcategory = category
        quickcategory = category
        itemcategoryUUID = category.catId
    }
    
    var defaultpicturename : String = imagestochoose[0].imagename
    
    func choosecollectionimage(pict: UIImage, defaultpicture: Bool, picturename: String?) {
        
        quickicon.image = pict
        
        isdefaultpicture = defaultpicture
        if picturename != nil {
            defaultpicturename = picturename!
        } else {
            defaultpicturename = ""
        }
    }


    
    /// Text field stuff
    
    
  
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        return
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //myTextField.delegate = self
    ///
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
   // var symbol = String()
    //var code = String()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func changecodeandsymbol(newcode: String, newsymbol: String) {
        code = newcode
        symbol = newsymbol
        //and change here the sum title!
        summationPrices()
        summationcheckedPrices()
    }
  
    
    @IBOutlet var bottomtoolbar: UIToolbar!
    
    
  
    
    @IBOutlet var alllistsoutlet: UIBarButtonItem!
    
    
    @IBOutlet var gobackoutlet: UIBarButtonItem!
    
    
    @IBAction func uncheckbutton(sender: AnyObject) {
        
        uncheckall()
        
    }
    
    
    func uncheckall() {
        
        

        
        for ( var i = 0; i < itemsDataDict.count; i++ ) {
      
                itemsDataDict[i]["ItemIsChecked"] = false

        }
        

        if showcats == true {
        
            for ( var i = 0; i < itemsDataDict.count; i++ ) {
                
                
                var thissectionsname : String = itemsDataDict[i]["ItemCategoryName"] as! String
                
                for ( var j = 0; j < sections[thissectionsname]!.count; j++ ) {
                    
                    sections[thissectionsname]![j]["ItemIsChecked"] = false
                    
                }
            }
            
        }
        
        
        let query = PFQuery(className:"shopItems")
        query.fromLocalDatastore()
        // querynew.getObjectInBackgroundWithId(itemtocheck) {
        query.whereKey("ItemsList", equalTo: currentList)//currentList)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
            

                
                if let listitems = objects as? [PFObject] {

                    
                    for object in listitems {
                    
                        object["isChecked"] = false
                        
                        object.pinInBackground()
                        
                    }
                    
                    self.addedindicator.alpha = 1
                    self.addedindicator.fadeOut()
                    
                }
                
            
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
        checkeditemsqty = 0
        
        itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
        
        summationcheckedPrices()
        
        showprogress()
        
        tableView.reloadData()
        
    }
    
    
    
    ////////// AUTOCOMPLETE PART
    
    var autodictionary = Dictionary<String,AnyObject>()
    
    
    @IBOutlet var autocomplete: Catalog_Autocomplete!
    
    func generateDataAuto() {
        
        for var i = 0; i < catalogitems.count; i++ {
            
            let itemname : String = catalogitems[i].itemname
            let itemimage = catalogitems[i].itemimage
            let customobject : CatalogItem = catalogitems[i]
            
            autodictionary = ["DisplayText":itemname,"DisplayImage":itemimage, "CustomObject":customobject]//catalogitems[i]]
            
            autocompletecatalogdata.append(autodictionary)
            
        }
        
        
        
    }
    
    var autocompletecatalogdata = [Dictionary<String, AnyObject>]()
    
    var catalogitemtochoose : CatalogItem?
    
    func dataForPopoverInTextField(textfield: Catalog_Autocomplete) -> [Dictionary<String, AnyObject>]
    {
        return autocompletecatalogdata
    }
    
    func textFieldShouldSelect(textField: Catalog_Autocomplete) -> Bool{
        return true
    }
    
    
    
    @IBAction func editingbegin(sender: AnyObject) {
      //  opencatalogoutlet.hidden = true
      //  quickaddoutlet.hidden = false
      //  newquantitybutton.hidden = false
        
        autocomplete.text = ""
        
        autocomplete.placeholder = NSLocalizedString("autocompleteplchldr", comment: "")
        
        if catalogitemtochoose != nil {
            
          //  quickcaticon.image = catalogcategories[0].catimage
            //quickcategorybutton.setTitle(catalogcategories[0].catname, forState: .Normal)
            
            //setcategoryinscroller("usual", catindex: nil)
            
            //quickicon.image = imagestochoose[0].itemimage
            
            restoredatainpopover()
        }
        
    }
    
    
    func restoredatainpopover() {
       
        
        quickcategory = catalogcategories[0]
        quickcategoryUUID = catalogcategories[0].catId

        setcategoryinscroller("usual", catindex: nil)
        
        isdefaultpicture = true
        defaultpicturename = imagestochoose[0].imagename
        quickicon.image = imagestochoose[0].itemimage
        
        
        catalogitemtochoose = nil
        
        changepicture.enabled = true
        changepicture.alpha = 1.0

    }
    
    @IBOutlet var changepicture: UIButton!
    
    func textFieldDidEndEditing(textField: Catalog_Autocomplete, withSelection data: Dictionary<String,AnyObject>){
        
      //  print("Dictionary received = \(data)")
        catalogitemtochoose = data["CustomObject"] as? CatalogItem
        //I think here I assign to my new variable the chosen catalog item

        
        
        if catalogitemtochoose != nil {
            
           // quickcategorybutton.setTitle(catalogitemtochoose?.itemcategory.catname, forState: .Normal)
            
           // quickcaticon.image = catalogitemtochoose?.itemcategory.catimage
            
            if let foundcategory = catalogcategories.map({ $0.catId }).lazy.indexOf((self.catalogitemtochoose?.itemcategory.catId)!) {
                
                setcategoryinscroller("catalog", catindex: foundcategory)
                // hereman
                quickcategory = catalogcategories[foundcategory]
                quickcategoryUUID = catalogcategories[foundcategory].catId
                
            }
            
            quickicon.image = catalogitemtochoose?.itemimage
            
            changepicture.enabled = false
            changepicture.alpha = 0.1
            
        }
        
       
        showproperties()
        
       // if endediting == false {
        
       // poppresented = true
        
            
           // newquantitybutton.tintColor = UIColorFromRGB(0xA2AF36)

        
         // smallpopover.hidden = false
            
           // dimmerforpopover.hidden = false
        /*
        self.quicksmallconstraint.constant = -6
        
             UIView.animateWithDuration(0.2, animations: { () -> Void in

            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in

        })
     */
          /*
        } else {
            quickaddoutlet.hidden = true
            opencatalogoutlet.hidden = false
            newquantitybutton.hidden = true
            endediting = false
        }
        */
        
    }
    
    
    @IBAction func changepictureaction(sender: AnyObject) {
        
        performSegueWithIdentifier("showimagesfromshoplist", sender: self)
    }
    
    
    @IBOutlet var noitemview: UIView!
    
    
    @IBAction func bigplus(sender: AnyObject) {
        performSegueWithIdentifier("additemmodalsegue", sender: self)
    }
    
    
    @IBAction func addfirstitem(sender: AnyObject) {
        performSegueWithIdentifier("additemmodalsegue", sender: self)
        
    }
    
    
    
    
    ////////// AUTO PART END
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
   // var quickunit = String()
   // var quickqty = String()
    
    
    @IBOutlet var addedindicator: UIView!
    
    func tableViewScrollToBottom(animated: Bool) {
        
        let delay = 0.1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            let numberOfSections = self.tableView.numberOfSections
            let numberOfRows = self.tableView.numberOfRowsInSection(numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
            }
            
        })
    }
    
    
    
    var quickunit : String = ""
    var quickperunit : String = ""
    var quickqty : String  = ""
   // var quickprice : String = ""
    //var quicksum: String = ""
    var quickcategory: Category = catalogcategories[0]
    var quickcategoryUUID = catalogcategories[0].catId
    var isdefaultpicture : Bool = true
    
    
    @IBOutlet var quickdescription: UITextView!
    
    @IBOutlet var mosttopconstraint: NSLayoutConstraint! // 10
    
    @IBOutlet var quickdescriptionconstr: NSLayoutConstraint! // -7

    //var quickicon : UIImage = UIImage(named: "DefaultProduct")!
    
    
    func getinfofrompop(unit: String, quantity: String, perunit: String, price: String, totalsum: String, icon: UIImage, category: Category, catUUID: String) {
        
        
        
        quickunit = unit
        quickqty = quantity
        
        quickperunit = perunit
       // quickprice = price
        //quicksum = totalsum
        
        //quickicon = icon
        quickcategory = category
        quickcategoryUUID = catUUID
        

        
    }
    

    
    @IBOutlet var quickaddoutlet: UIButton!
    
    var imagePath = String()

    func saveImageLocally(imageData:NSData!) -> String {
        var uuid = NSUUID().UUIDString

        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 

        if !fileManager.fileExistsAtPath(dir) {
            do{
                try NSFileManager.defaultManager().createDirectoryAtPath(dir, withIntermediateDirectories: false, attributes: [:])
            } catch {
                print("Error creating SwiftData image folder")
               // return ""
                
                imagePath = ""
                return imagePath
            }
        }
        
        let pathToSaveImage = (dir as NSString).stringByAppendingPathComponent("item\(uuid).png")
        //("item\(Int(time)).png")
        
        imageData.writeToFile(pathToSaveImage, atomically: true)
        
        imagePath = "item\(uuid).png"
        
        return imagePath//"item\(Int(time)).png"
    }

 
    
    func loadImageFromLocalStore(imageName: String) -> UIImage {
        let fileManager = NSFileManager.defaultManager()
        let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]

        //try for ios9.2
        let path = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(imageName)
        
        // if(!path.isEmpty){
        if path != "" {
            
            let data = NSData(contentsOfURL:path)
            if (data != nil) {
            let image = UIImage(data:data!)
            //}
           
                
            if(image != nil){
                //return image!;
                self.imageToLoad = image!
                // return imageToLoad
            } else {
                self.imageToLoad = imagestochoose[0].itemimage
            }
            
            } else {
                self.imageToLoad = imagestochoose[0].itemimage
            }
        
        } else {
            self.imageToLoad = imagestochoose[0].itemimage
        }
        
        return imageToLoad
    }

    
  
    
    
    
    func quickaddcatalogitem(chosencatalogitem: CatalogItem) {
        
        if poppresented == true {
            
            getinfofrompop(quickunit, quantity: popqty.text!, perunit: quickperunit, price: quickpriceoutlet.text!, totalsum: quicksum.text!, icon: quickcategory.catimage, category: quickcategory, catUUID: quickcategoryUUID)
        }
        
        print(quickqty)
        print(popqty.text!)
        
      
        
        let shopItem = PFObject(className:"shopItems")
        
        let uuid = NSUUID().UUIDString
        let catalogitemuuid = "catalogitem\(uuid)"
        
        shopItem["itemUUID"] = catalogitemuuid
        shopItem["itemImage"] = NSNull()
        shopItem["ItemsList"] = currentList
        shopItem["belongsToUser"] = PFUser.currentUser()!.objectId!
        
        shopItem["itemNote"] = quickdescription.text//""
        shopItem["itemQuantity"] = popqty.text//quickqty//"0"
        shopItem["itemPriceS"] = self.quickpriceoutlet.text//0.0
        shopItem["TotalSumS"] = self.quicksum.text//0.0
        shopItem["chosenFromHistory"] = false
        shopItem["itemUnit"] = quickunit//""
        shopItem["isChecked"] = false
        shopItem["isCatalog"] = true
        shopItem["isFav"] = false
        shopItem["chosenFromFavs"] = false
        shopItem["perUnit"] = quickperunit//""
        
        shopItem["defaultpicture"] = false
        shopItem["OriginalInDefaults"] = ""

        
        
        let date = NSDate()
        
        shopItem["CreationDate"] = date
        shopItem["UpdateDate"] = date
        
        shopItem["ServerUpdateDate"] = date.dateByAddingTimeInterval(-120)
        
        shopItem["isHistory"] = false //for filtering purposes when deleting the list and all its items
        shopItem["isDeleted"] = false
        
    
            
            shopItem["originalInCatalog"] = chosencatalogitem.itemId
            shopItem["itemName"] = chosencatalogitem.itemname

            
            shopItem["imageLocalPath"] = ""//imagePath

        
        shopItem["Category"] = quickcategoryUUID//chosencatalogitem.itemcategory.catId
        
       
        
        
            let itemId = catalogitemuuid
            
            let itemname = chosencatalogitem.itemname
            let itemnote = self.quickdescription.text!//""
            let itemquantity = popqty.text!//quickqty//""
            let itemprice = self.quickpriceoutlet.text!//0.0
            let itemischecked = false
            let itemimagepath = ""//self.imagespaths[indexPathCatalogProduct!.row]//"Banana.png"//self.imagePath
            let itemunit = quickunit//""
            let itemimage2 = chosencatalogitem.itemimage
            let itemcategory = quickcategoryUUID//chosencatalogitem.itemcategory.catId
            let itemiscatalog = true
            let originalincatalog = chosencatalogitem.itemId
            
            let itemperunit = quickperunit//""
            
            let categoryname = quickcategory.catname//chosencatalogitem.itemcategory.catname
            
            let itemtotalprice = self.quicksum.text!//0.0
            
            let thisitemisfav = false
        
            let isdefaultpict = false
            let originalindefaults = ""
        
            self.dictionary = ["ItemId":itemId,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemtotalprice,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":categoryname,"ItemOneUnitPrice":itemprice,"ItemIsFav":thisitemisfav,"ItemPerUnit":itemperunit,"ItemCreation":date,"ItemUpdate":date,"ItemIsDefPict":isdefaultpict,"ItemOriginalInDefaults":originalindefaults]
     
        
        itemsDataDict.append(self.dictionary)
        
        shoppingcheckedtocopy.append(false)
        
        itemsorderarray.append(catalogitemuuid)

        
        
        self.sortcategories(itemsDataDict)
        
        summationPrices()
        summationcheckedPrices()
        countitems()
        countchecked()
        itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
        showprogress()
        
        tableView.reloadData()
        
        //self.restore()
        
        // shopItem.pinInBackground()
        shopItem.pinInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                //self.restore()
                print("saved item")
                
               

            } else {
                print("no id found")
            }
        })
        
        
 
        /*
        if poppresented == true {
            
           
            
            
            poppresented = false
            
            //endediting = false // CAREFUL HERE
            
            newquantitybutton.tintColor = UIColorFromRGB(0x979797)
            
            dimmerforpopover.hidden = true

            self.smallpopover.hidden = true

            
        }
        

        poppresented = false
        
        opencatalogoutlet.hidden = false
        quickaddoutlet.hidden = true
        newquantitybutton.hidden = true
        */
        
        hideproperties()

        self.quickunit = ""
        self.quickperunit = ""
        self.quickqty  = ""
        self.popqty.text = ""
        // GET BACK THE UNIT AND PER UNIT BUTTONS
        
        quickpriceoutlet.text = ""
        quicksum.text = ""
        
        quickdescription.text = ""
        
        unline.backgroundColor = UIColorFromRGB(0xE0E0E0)
        perunline.backgroundColor = UIColorFromRGB(0xE0E0E0)
        sumline.backgroundColor = UIColorFromRGB(0xE0E0E0)
        priceline.backgroundColor = UIColorFromRGB(0xE0E0E0)
        
        quickcategory = catalogcategories[0]
        quickcategoryUUID = catalogcategories[0].catId
       // quickcaticon.image = catalogcategories[0].catimage
        
       // quickcategorybutton.setTitle(catalogcategories[0].catname, forState: .Normal)
        setcategoryinscroller("usual", catindex: nil)
        
        isdefaultpicture = true
        defaultpicturename = imagestochoose[0].imagename
        quickicon.image = imagestochoose[0].itemimage
        changepicture.enabled = true
        changepicture.alpha = 1.0
        
        resetunitsback()
        
       
        
        buttontitle = ""
        
        
        
      //  self.view.endEditing(true) CAREFUL
        //autocomplete.re
        catalogitemtochoose = nil // make it nil after adding
       //  quickquantity.text = NSLocalizedString("amount", comment: "")
        autocomplete.text = NSLocalizedString("additemtext", comment: "")
        
        
        if showcats == false {
        tableViewScrollToBottom(true)
        }
        
        addedindicator.alpha = 1
        addedindicator.fadeOut()
        
        
        
    }
    
    
    
    
    func movechecked(var refr: Bool, cell: ItemShopListCell) -> Bool {
        
        if refr == false {
        
        cell.checkedheight.constant = 49
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            
            }, completion: { (value: Bool) -> Void in
                
                refr = true
                
        })
          return refr
        } else {
            cell.checkedheight.constant = 0
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
                self.view.layoutIfNeeded()
                
                }, completion: { (value: Bool) -> Void in
                    
                    refr = false
                    
            })
            return refr
            
        }
        
    }

    
    var endediting : Bool = false
    
    
    func quicknoncatalogitem() {
        
        
            
            if poppresented == true {
                
                getinfofrompop(quickunit, quantity: popqty.text!, perunit: quickperunit, price: quickpriceoutlet.text!, totalsum: quicksum.text!, icon: quickicon.image!, category: quickcategory, catUUID: quickcategoryUUID)
            }
            
            
            //var itemimage = imagestochoose[0].itemimage//
            
            
            //creation of an itemlist
            var shopItem = PFObject(className:"shopItems")
            var uuid = NSUUID().UUIDString
            var itemuuid = "shopitem\(uuid)"
            
            shopItem["itemUUID"] = itemuuid
            shopItem["itemName"] = autocomplete.text//quickitemadd.text
            shopItem["itemImage"] = NSNull()//imageFile
            shopItem["itemNote"] = quickdescription.text
            shopItem["itemQuantity"] = popqty.text//quickqty//"0"
            shopItem["itemPriceS"] = self.quickpriceoutlet.text//0.0
            shopItem["TotalSumS"] = self.quicksum.text//0.0
            
            shopItem["ItemsList"] = currentList
            shopItem["belongsToUser"] = PFUser.currentUser()!.objectId!
            shopItem["itemUnit"] = quickunit//""
            shopItem["perUnit"] = quickperunit//""
            shopItem["chosenFromHistory"] = false
            shopItem["isChecked"] = false
            
            if isdefaultpicture == true {
                shopItem["itemImage"] = NSNull()
                shopItem["defaultpicture"] = true
                shopItem["OriginalInDefaults"] = defaultpicturename
                shopItem["imageLocalPath"] = ""
                
            } else {
                
                let imageData = UIImagePNGRepresentation(self.quickicon.image!)
                saveImageLocally(imageData)
                shopItem["itemImage"] = NSNull()
                shopItem["imageLocalPath"] = self.imagePath
                shopItem["defaultpicture"] = false
                shopItem["OriginalInDefaults"] = ""
            }

            
           // shopItem["defaultpicture"] = true
           // shopItem["OriginalInDefaults"] = imagestochoose[0].imagename
            
            shopItem["Category"] = quickcategory.catId//itemcategoryUUID//catalogcategories[0].catId
            shopItem["isCatalog"] = false
            shopItem["originalInCatalog"] = ""
            
            //self.saveImageLocally(imageData)
           // shopItem["imageLocalPath"] = ""//self.imagePath
            
            shopItem["isFav"] = false
            
            shopItem["chosenFromFavs"] = false
            
            var date = NSDate()
            
            shopItem["CreationDate"] = date
            shopItem["UpdateDate"] = date
            
            shopItem["ServerUpdateDate"] = date.dateByAddingTimeInterval(-120)
            
            shopItem["isHistory"] = true //for filtering purposes when deleting the list and all its items
            shopItem["isDeleted"] = false
            //shopItem["Category"] =
            
            var itemid = itemuuid
            
            var itemname = autocomplete.text!//quickitemadd.text
            var itemnote = quickdescription.text!
            var itemquantity = popqty.text!//quickqty//""
            var itemprice = self.quicksum.text!//0.0
            var itemoneunitprice = self.quickpriceoutlet.text!//0.0
            //var itemimage = imageFile
            var itemischecked = false
            var itemimagepath = self.imagePath//""//self.imagePath
            var itemunit = quickunit//""
            var itemperunit = quickperunit//""
            //self.loadImageFromLocalStore(itemimagepath)
            var itemimage2 : UIImage = self.quickicon.image!//itemimage//self.imageToLoad
            
            var itemcategory = quickcategory.catId//quickcategory//itemcategoryUUID//catalogcategories[0].catId
            var itemiscatalog = false
            var originalincatalog = ""
            
            var itemcategoryname = quickcategory.catname//catalogcategories[0].catname
            
            var itemisfav = false
            
            var isdefaultpict = Bool()//= true
            var originalindefaults = String()//imagestochoose[0].imagename
            
            if isdefaultpicture == true {
                isdefaultpict = true
                originalindefaults = defaultpicturename
                
            } else {
                isdefaultpict = false
                originalindefaults = ""
            }
 
            self.dictionary = ["ItemId":itemid,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemprice,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":itemcategoryname,"ItemOneUnitPrice":itemoneunitprice,"ItemIsFav":itemisfav,"ItemPerUnit":itemperunit,"ItemCreation":date,"ItemUpdate":date,"ItemIsDefPict":isdefaultpict,"ItemOriginalInDefaults":originalindefaults]
            
            
            
            itemsDataDict.append(self.dictionary)
            
            shoppingcheckedtocopy.append(false)
            
            self.sortcategories(itemsDataDict)
            
            summationPrices()
            summationcheckedPrices()
            countitems()
            countchecked()
            itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
            showprogress()
            tableView.reloadData()
            
            
            shopItem.pinInBackgroundWithBlock({ (success, error) -> Void in
                if success {
                    
                } else {
                    print("Item wasn't saved")
                }
            })
            
            /*
            if poppresented == true {
                
                poppresented = false
                
                newquantitybutton.tintColor = UIColorFromRGB(0x979797)
                
                dimmerforpopover.hidden = true
                
                smallpopover.hidden = true
                

                
            }
            
            poppresented = false
            endediting = true
            quickaddoutlet.hidden = true
            opencatalogoutlet.hidden = false
            newquantitybutton.hidden = true
            */
            
        self.quickunit = ""
        self.quickperunit = ""
        self.quickqty  = ""
        self.popqty.text = ""
        // GET BACK THE UNIT AND PER UNIT BUTTONS
        
        quickpriceoutlet.text = ""
        quicksum.text = ""
        
        quickdescription.text = ""
        
        unline.backgroundColor = UIColorFromRGB(0xE0E0E0)
        perunline.backgroundColor = UIColorFromRGB(0xE0E0E0)
        sumline.backgroundColor = UIColorFromRGB(0xE0E0E0)
        priceline.backgroundColor = UIColorFromRGB(0xE0E0E0)
        
        quickcategory = catalogcategories[0]
        quickcategoryUUID = catalogcategories[0].catId
       // quickcaticon.image = catalogcategories[0].catimage
       // quickcategorybutton.setTitle(catalogcategories[0].catname, forState: .Normal)
        
         setcategoryinscroller("usual", catindex: nil)
        
        isdefaultpicture = true
        defaultpicturename = imagestochoose[0].imagename
        quickicon.image = imagestochoose[0].itemimage
        changepicture.enabled = true
        changepicture.alpha = 1.0
        
        resetunitsback()
        
        hideproperties()
        
        
            self.autocomplete.text = NSLocalizedString("additemtext", comment: "")
            
        
            catalogitemtochoose = nil
            
            buttontitle = ""
            
          //  self.view.endEditing(true) CAREFUL
           // autocomplete.resignFirstResponder()
            
            
        // END OF USUAL ADD CASE
        
        
        if showcats == false {
        tableViewScrollToBottom(true)
        }
        
        addedindicator.alpha = 1
        addedindicator.fadeOut()
        
        
        
        
    }
    
    
    @IBAction func cancelquickadding(sender: AnyObject) {
        /*
        if poppresented == true {
            
            
            
            
          //  poppresented = false
            
            //endediting = false // CAREFUL HERE
            
            newquantitybutton.tintColor = UIColorFromRGB(0x979797)
            
            dimmerforpopover.hidden = true
            
            self.smallpopover.hidden = true

        }
        
        
        poppresented = false
        
        opencatalogoutlet.hidden = false
        quickaddoutlet.hidden = true
        newquantitybutton.hidden = true
        */
        
        
        self.quickunit = ""
        self.quickperunit = ""
        self.quickqty  = ""
        self.popqty.text = ""
        // GET BACK THE UNIT AND PER UNIT BUTTONS
        
        quickpriceoutlet.text = ""
        quicksum.text = ""
        
        quickcategory = catalogcategories[0]
        quickcategoryUUID = catalogcategories[0].catId
       // quickcaticon.image = catalogcategories[0].catimage
        
       // quickcategorybutton.setTitle(catalogcategories[0].catname, forState: .Normal)
        
        
        isdefaultpicture = true
        defaultpicturename = imagestochoose[0].imagename
        quickicon.image = imagestochoose[0].itemimage
        
        unline.backgroundColor = UIColorFromRGB(0xE0E0E0)
        perunline.backgroundColor = UIColorFromRGB(0xE0E0E0)
        sumline.backgroundColor = UIColorFromRGB(0xE0E0E0)
        priceline.backgroundColor = UIColorFromRGB(0xE0E0E0)
        
        setcategoryinscroller("usual", catindex: nil)
        
        
       resetunitsback()
       hideproperties()
        
        
        buttontitle = ""

      //  self.view.endEditing(true)
        //autocomplete.re
        catalogitemtochoose = nil // make it nil after adding
        //  quickquantity.text = NSLocalizedString("amount", comment: "")
        autocomplete.text = NSLocalizedString("additemtext", comment: "")
    }
    
    
    @IBAction func doneinviewbutton(sender: AnyObject) {
        
        if (catalogitemtochoose != nil) {
            
            quickaddcatalogitem(catalogitemtochoose!)
            
        } else {
            
            quicknoncatalogitem()
            /*
            if poppresented == true {
                
               getinfofrompop(quickunit, quantity: popqty.text!, perunit: quickperunit, price: quickpriceoutlet.text!, totalsum: quicksum.text!, icon: quickicon.image!, category: quickcategory, catUUID: quickcategoryUUID)
            }
            
            
            var itemimage = imagestochoose[0].itemimage//
            
            
            //creation of an itemlist
            var shopItem = PFObject(className:"shopItems")
            var uuid = NSUUID().UUIDString
            var itemuuid = "shopitem\(uuid)"
            
            shopItem["itemUUID"] = itemuuid
            shopItem["itemName"] = autocomplete.text//quickitemadd.text
            shopItem["itemImage"] = NSNull()//imageFile
            shopItem["itemNote"] = ""
            shopItem["itemQuantity"] = quickqty//"0"
            shopItem["itemPriceS"] = self.quickpriceoutlet.text//0.0
            shopItem["TotalSumS"] = ""//0.0
            
            shopItem["ItemsList"] = currentList
            shopItem["belongsToUser"] = PFUser.currentUser()!.objectId!
            shopItem["itemUnit"] = quickunit//""
            shopItem["perUnit"] = quickperunit//""
            shopItem["chosenFromHistory"] = false
            shopItem["isChecked"] = false
            
            shopItem["defaultpicture"] = true
            shopItem["OriginalInDefaults"] = imagestochoose[0].imagename
            
            shopItem["Category"] = catalogcategories[0].catId
            shopItem["isCatalog"] = false
            shopItem["originalInCatalog"] = ""
            
            //self.saveImageLocally(imageData)
            shopItem["imageLocalPath"] = ""//self.imagePath
            
            shopItem["isFav"] = false
            
            shopItem["chosenFromFavs"] = false
            
            var date = NSDate()
            
            shopItem["CreationDate"] = date
            shopItem["UpdateDate"] = date
            
            shopItem["ServerUpdateDate"] = date.dateByAddingTimeInterval(-120)
            
            shopItem["isHistory"] = true //for filtering purposes when deleting the list and all its items
            shopItem["isDeleted"] = false
            //shopItem["Category"] =
            
            var itemid = itemuuid
            
            var itemname = autocomplete.text!//quickitemadd.text
            var itemnote = ""
            var itemquantity = quickqty//""
            var itemprice = ""//0.0
            var itemoneunitprice = ""//0.0
            //var itemimage = imageFile
            var itemischecked = false
            var itemimagepath = ""//self.imagePath
            var itemunit = quickunit//""
            var itemperunit = quickunit//""
            //self.loadImageFromLocalStore(itemimagepath)
            var itemimage2 = itemimage//self.imageToLoad
            
            var itemcategory = catalogcategories[0].catId
            var itemiscatalog = false
            var originalincatalog = ""
            
            var itemcategoryname = catalogcategories[0].catname
            
            var itemisfav = false
            
            var isdefaultpict = true
            var originalindefaults = imagestochoose[0].imagename
            
            self.dictionary = ["ItemId":itemid,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemprice,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":itemcategoryname,"ItemOneUnitPrice":itemoneunitprice,"ItemIsFav":itemisfav,"ItemPerUnit":itemperunit,"ItemCreation":date,"ItemUpdate":date,"ItemIsDefPict":isdefaultpict,"ItemOriginalInDefaults":originalindefaults]
            
            
            
            itemsDataDict.append(self.dictionary)
            
            shoppingcheckedtocopy.append(false)
            
            self.sortcategories(itemsDataDict)
            
            summationPrices()
            countitems()
            countchecked()
            itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
            
            tableView.reloadData()
            
            
            shopItem.pinInBackgroundWithBlock({ (success, error) -> Void in
                if success {

                } else {
                    print("Item wasn't saved")
                }
            })

            
            if poppresented == true {

                poppresented = false
                
               newquantitybutton.tintColor = UIColorFromRGB(0x979797)
                
                dimmerforpopover.hidden = true
                
                self.smallpopover.hidden = true
                
                /*
                self.quicksmallconstraint.constant = -610
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    self.view.layoutIfNeeded()
                    
                    }, completion: { (value: Bool) -> Void in
                        
                        self.smallpopover.hidden = true
                })
                */
                
            }

            poppresented = false
            endediting = true
            quickaddoutlet.hidden = true
            opencatalogoutlet.hidden = false
            newquantitybutton.hidden = true

            
            self.quickunit = ""
            self.quickqty  = ""

            self.autocomplete.text = NSLocalizedString("additemtext", comment: "")
            
            self.popqty.text = ""

            
            buttontitle = ""
            
            
            autocomplete.resignFirstResponder()
            */
            
        } // END OF USUAL ADD CASE
        
        
        
        tableViewScrollToBottom(true)
        
        addedindicator.alpha = 1
        addedindicator.fadeOut()
        
        
        
        
    }
    
    // for non-catalog items
    //var itemcategory:Category?
    var itemcategoryUUID = String()
    
    @IBAction func quickaddbutton(sender: AnyObject) {
        
        if (catalogitemtochoose != nil) {
            
            quickaddcatalogitem(catalogitemtochoose!)
            
        } else {
            
            quicknoncatalogitem()
        }
        /*
        if (catalogitemtochoose != nil) {
            
            quickaddcatalogitem(catalogitemtochoose!)
            
        } else {
        
            if poppresented == true {
                
                getinfofrompop(buttontitle, quantity: popqty.text!)
            }

            
        var itemimage = imagestochoose[0].itemimage//

        //creation of an itemlist
        var shopItem = PFObject(className:"shopItems")
        var uuid = NSUUID().UUIDString
        var itemuuid = "shopitem\(uuid)"
        
        shopItem["itemUUID"] = itemuuid
        shopItem["itemName"] = autocomplete.text//quickitemadd.text
        shopItem["itemImage"] = NSNull()//imageFile
        shopItem["itemNote"] = ""
        shopItem["itemQuantity"] = quickqty//"0"
        shopItem["itemPriceS"] = ""//0.0
        shopItem["TotalSumS"] = ""//0.0
        
        shopItem["ItemsList"] = currentList
        shopItem["belongsToUser"] = PFUser.currentUser()!.objectId!
        shopItem["itemUnit"] = quickunit//""
        shopItem["perUnit"] = quickunit//""
        shopItem["chosenFromHistory"] = false
        shopItem["isChecked"] = false
        
            shopItem["defaultpicture"] = true
            shopItem["OriginalInDefaults"] = imagestochoose[0].imagename
        
        shopItem["Category"] = catalogcategories[0].catId
        shopItem["isCatalog"] = false
        shopItem["originalInCatalog"] = ""
        
        //self.saveImageLocally(imageData)
        shopItem["imageLocalPath"] = ""//self.imagePath
        
        shopItem["isFav"] = false
        
        shopItem["chosenFromFavs"] = false
        
        var date = NSDate()
        
        shopItem["CreationDate"] = date
        shopItem["UpdateDate"] = date
            
        shopItem["ServerUpdateDate"] = date.dateByAddingTimeInterval(-120)
        
        shopItem["isHistory"] = true //for filtering purposes when deleting the list and all its items
        shopItem["isDeleted"] = false
        //shopItem["Category"] =
        
        var itemid = itemuuid
        
        var itemname = autocomplete.text!//quickitemadd.text
        var itemnote = ""
        var itemquantity = quickqty//""
        var itemprice = ""//0.0
        var itemoneunitprice = ""//0.0
        //var itemimage = imageFile
        var itemischecked = false
        var itemimagepath = ""//self.imagePath
        var itemunit = quickunit//""
        var itemperunit = quickunit//""
        //self.loadImageFromLocalStore(itemimagepath)
        var itemimage2 = itemimage//self.imageToLoad
        
        var itemcategory = catalogcategories[0].catId
        var itemiscatalog = false
        var originalincatalog = ""
        
        var itemcategoryname = catalogcategories[0].catname
        
        var itemisfav = false
            
            var isdefaultpict = true
            var originalindefaults = imagestochoose[0].imagename
        
        self.dictionary = ["ItemId":itemid,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemprice,"ItemImagePath":itemimagepath,"ItemUnit":itemunit,"ItemIsChecked":itemischecked,"ItemImage2":itemimage2,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":itemcategoryname,"ItemOneUnitPrice":itemoneunitprice,"ItemIsFav":itemisfav,"ItemPerUnit":itemperunit,"ItemCreation":date,"ItemUpdate":date,"ItemIsDefPict":isdefaultpict,"ItemOriginalInDefaults":originalindefaults]
        
        
        
        itemsDataDict.append(self.dictionary)
            
        shoppingcheckedtocopy.append(false)
        
        self.sortcategories(itemsDataDict)
        
        summationPrices()
            countitems()
            countchecked()
            itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
        
        tableView.reloadData()
        
        
        shopItem.pinInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                

            } else {
                print("Item wasn't saved")
            }
        })
        

            
            if poppresented == true {
                

                poppresented = false
                
                newquantitybutton.tintColor = UIColorFromRGB(0x979797)
                
                dimmerforpopover.hidden = true
                
                self.smallpopover.hidden = true
                /*
                self.quicksmallconstraint.constant = -610
                
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    
                    self.view.layoutIfNeeded()
                    
                    }, completion: { (value: Bool) -> Void in
                        
                        self.smallpopover.hidden = true
                })
                */
               
            }
          //  autocomplete.resignFirstResponder()\
            poppresented = false
            endediting = true
            quickaddoutlet.hidden = true
            opencatalogoutlet.hidden = false
            newquantitybutton.hidden = true

            self.quickunit = ""
            self.quickqty  = ""

            self.autocomplete.text = NSLocalizedString("additemtext", comment: "")
            
            self.popqty.text = ""

            
            buttontitle = ""
           
            
            autocomplete.resignFirstResponder()

            
        } // END OF USUAL ADD CASE
        
        
        
         tableViewScrollToBottom(true)
        
        addedindicator.alpha = 1
        addedindicator.fadeOut()
        */
    }
    
    
    
    
    func refreshtable() {
        
        HistoryitemsDataDict.removeAll(keepCapacity: true)
        
        // here should run a for cycle that changes all catalog items "ischecked" to false
        
        for var i = 0;i<catalogitems.count;++i {
         
            catalogitems[i].itemischecked = false
            
        }
        

        
        
        if itemsDataDict.count == 0 {

        } else {

        }
        
        ///CASE from menu
        
        
        
        if justCreatedList == true {
            
            //hope it works
            //newPFObject()f
            activeList = currentList
            //currentList = activeList
            if currentList != "" {

                
                self.sortcategories(itemsDataDict)
                tableView.reloadData()
                summationPrices()
                summationcheckedPrices()
                countitems()
                countchecked()
                itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
                showprogress()
            } else {
                
                
            }

        } else {

            
            if itemsDataDict.count == 0 {
                dataretrievallist()
                
            }
            

            self.sortcategories(itemsDataDict)
            tableView.reloadData()
            
            
            //tableView.reloadData()
            summationPrices()
            summationcheckedPrices()
            countitems()
            countchecked()
            itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
            showprogress()
        }
        
        
        if itemsDataDict.count == 0 {
           // noitemview.hidden = false
        } else {
           // noitemview.hidden = true
        }
        
         tableViewScrollToBottom(true)
        
    }
    
    // MARK: HorizontalScroll
    
    
    @IBOutlet var horscrollview: UIView!
    
    @IBOutlet var horscrollviewper: UIView!

    
    
    @IBOutlet var choosecurrency: UIButton!
    
    
    
    
    var senderVC : UIViewController?
    //need to find out from which vc was the segue performed
    
    
    var thislistcurrency = String()
    
    var currentList = String()
    
    var trycurrent: String?
    
    var itemtodelete: String?
    
    var justCreatedList = true
    
    var isReceivedList = Bool()
    
    var activeList: String? // currently I will use this
    
    //var newListActive: String?
    
    var refreshControl:UIRefreshControl!
    
    var itemtoedit = String()
    
    var itemtofavs = String()
    
    var itemtocheck = String()
    
    var checkedImage: UIImage = UIImage(named: "EditModeCheckIcon")!
//UIImage(named: "check.png")!
    
    var notcheckedImage: UIImage = UIImage(named: "EditModeUncheckIcon")!//UIImage(named: "notchecked.png")!
    
    var checkedImageToCopy: UIImage = UIImage(named: "EditModeCheckIcon")!//UIImage(named: "check.png")!
    
    var notcheckedImageToCopy: UIImage = UIImage(named: "EditModeUncheckIcon")!//UIImage(named: "notchecked.png")!
    
    var imageToLoad = UIImage()
    var itemsoverallqty = Int()
    var checkeditemsqty = Int()
    var checked = [Bool]()
    var showcats = Bool()
    var isSorted = Bool()
    
    @IBOutlet weak var PricesSum: UILabel!
    
    @IBOutlet var PricescheckedSum: UILabel!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var itemsoverall: UILabel!
    
    
    @IBOutlet weak var itemschecked: UILabel!
    

    
    func contains(values: [String], element: String) -> Bool {
        // Loop over all values in the array.
        for value in values {
            // If a value equals the argument, return true.
            if value == element {
                return true
            }
        }
        // The element was not found.
        return false
    }

    
    func containsdict(values: [Dictionary<String, AnyObject>], element: Dictionary<String, AnyObject>) -> Bool {
        // Loop over all values in the array.
        for value in values {
            // If a value equals the argument, return true.
            //if value["ItemId"] == element["ItemId"] {
            if NSDictionary(dictionary: value).isEqualToDictionary(element) {
                return true
                
            }
        }
        // The element was not found.
        return false
    }
    
    
    
    var shoppingListItemsIds = [String]()
    var shoppingListItemsNames = [String]()
    var shoppingListItemsNotes = [String]()
    var shoppingListItemsQuantity = [String]()
    var shoppingListItemsPrices = [String]()
    var shoppingListItemsImages = [AnyObject]()
    var shoppingListItemsUnits = [String]()
    var shoppingListItemsImagesPaths = [String]()
    var shoppingListItemsImages2 = [UIImage]()
    var shoppingListItemsIsChecked = [Bool]()
    var shoppingListItemsCategories = [String]()
    var shoppingListItemsCategoriesNames = [String]()
    var shoppingListItemsIsCatalog = [Bool]()
    var shoppingListItemsOriginal = [String]()
    var shoppingListOneUnitPrice = [String]()
    var shoppingListItemsIsFav = [Bool]()
    var shoppingListItemsPerUnit = [String]()
    var shoppingListItemsCreation = [NSDate]()
    var shoppingListItemsUpdate = [NSDate]()
    
    var shoppingListItemsIsDefPict = [Bool]()
    var shoppingListItemsDefaultOriginal = [String]()
    
    var shoppingpffile = [PFFile]()
    

    //var sortedSections = [String]()
    
    //var sections : [(index: Int, length :Int, title: String)] = Array()
    
    //  var sections = MutableDictionary<String, Array<Dictionary<String, AnyObject>>>()
    var sections = Dictionary<String, Array<Dictionary<String, AnyObject>>>()
    
    var sections2 = Dictionary<String, Array<Dictionary<String, AnyObject>>>()
    
    var sortedSections = [String]()
    
    //var dictionary: NSDictionary = NSDictionary()
    
    var differentcategories = [String]()
    
    var dictionary = Dictionary<String, AnyObject>()
    
    // var ItemsCount = Int()
    // var CheckedItemsCount = Int()
    
    
    
    func popshowcategories(show: Bool) {
        
        
        if show == true {
            
            showcats = true
            
            self.tableView.reloadData()
            
          //  print("The new array is \(sections)")
            
        } else {
            
            showcats = false
            // sections.removeAll(keepCapacity: true)
            self.tableView.reloadData()
            
            
        }
        
        
    }
    
    func changecolor(code: String) {
        
        colorcode = code
        
    }
    
    @IBAction func ShowCategories(sender: AnyObject) {

        
        if showcats == false {
            
            showcats = true
 
            self.tableView.reloadData()
            
          //  print("The new array is \(sections)")
            
        } else {
            
            showcats = false
            // sections.removeAll(keepCapacity: true)
            self.tableView.reloadData()
            
            
        }
  
    }
    
    /// FOR FUTURE 
    /*
    var checkedsections = Dictionary<String, Array<Dictionary<String, AnyObject>>>()
    
    var sortedCheckedSections = [String]()
    
    func sortchecked(items: [Dictionary<String, AnyObject>]) {
        
        checkedsections.removeAll(keepCapacity: true)
        sortedCheckedSections.removeAll(keepCapacity: true)
        
        
        var checkedcats: String = "Checked"
        var notcheckedcats: String = "NotChecked"
        
        for ( var i = 0; i < items.count; i++ ) {
            
           // let commoncategory: String = items[i]["ItemCategoryName"] as! String
            
           // if self.sections.indexForKey(checkedcats) == nil {
            if (items[i]["ItemIsChecked"] as! Bool) == true {
                
                //self.sections[commoncategory] = [items[i]]
                self.checkedsections[checkedcats] = [items[i]]
                
                
            }
            else {
                
              //  self.sections[commoncategory]?.append(items[i])
                self.checkedsections[notcheckedcats] = [items[i]]

                
                
            }
        }
        
         self.sortedCheckedSections = self.checkedsections.keys.elements.sort(>)
        
        print(checkedsections)
        print(sortedCheckedSections)
        
    }
    */
    
    func sortcategories(items: [Dictionary<String, AnyObject>]) {
 
        sections.removeAll(keepCapacity: true)
        sortedSections.removeAll(keepCapacity: true)
        headerimages.removeAll(keepCapacity: true)

        for ( var i = 0; i < items.count; i++ ) {
            
            let commoncategory: String = items[i]["ItemCategoryName"] as! String
            
            if self.sections.indexForKey(commoncategory) == nil {

                self.sections[commoncategory] = [items[i]]

                
            }
            else {

                self.sections[commoncategory]?.append(items[i])
                
                
            }
        }

        
       print("sects \(sortedSections)")
        
       // self.sortedSections =  self.sections.keys.array.sorted(>)
        
        self.sortedSections = self.sections.keys.elements.sort(>) //Swift 2
        
        print("sects1 \(sortedSections)")
        
        for ( var sect = 0; sect < sortedSections.count; sect++ ) {
            
            var key: String = self.sortedSections[sect]
            
            //((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemImage2")) as? UIImage
            
            var cat = (self.sections as NSDictionary).objectForKey(key) as! [Dictionary<String,AnyObject>]
            var catid : String = (cat[0] as NSDictionary).objectForKey("ItemCategory") as! String
            
            
            
            if (catid as NSString).containsString("custom") {
                
                
                var querycat = PFQuery(className:"shopListsCategory")
                querycat.fromLocalDatastore()
                querycat.whereKey("categoryUUID", equalTo: catid)
                var categories = querycat.findObjects()
                if (categories != nil) {
                    for category in categories! {
                        
                        
                        if category["defaultpicture"] as! Bool == false {
                                                       self.loadImageFromLocalStore(category["imagePath"] as! String)
                           // thiscatpicture = 
                            self.headerimages.append(self.imageToLoad)
                            
                        } else {
                            
                            var imagename = category["OriginalInDefaults"] as! String
                            
                            if (UIImage(named: "\(imagename)") != nil) {
                                //thiscatpicture = UIImage(named: "\(imagename)")!
                                 self.headerimages.append(UIImage(named: "\(imagename)")!)
                            } else {
                               // thiscatpicture = defaultcatimages[0].itemimage
                                self.headerimages.append(defaultcatimages[0].itemimage)
                            }
                            
                        }
                        
                    }
                } else {
                    print("No custom cats yet")
                }
                
                
            } else {
                // CASE IF IT IS DEFAULT CATEGORY
                

                if var foundcategory = catalogcategories.map({ $0.catId }).lazy.indexOf(catid) {
                    
                    var catalogpicture = catalogcategories[foundcategory].catimage
                    
                   // thiscatpicture = catalogpicture
                    
                    self.headerimages.append(catalogpicture)
                    
                }
                
                
            }
            
            
        }
        
        self.tableView.reloadData()
        
    }
    
    
    func createpicture() {
        // generateImage(tableView)
        if itemsDataDict.count != 0 {
        messageimage = tableView.screenshot!
        }
    }
    
    func savetogallery() {
        if itemsDataDict.count != 0 {
        messageimage = tableView.screenshot!
        }
    }
    
   
   
    
    
    func handleUPSwipe(sender: UISwipeGestureRecognizer) {
        
         getinfofrompop(quickunit, quantity: popqty.text!, perunit: quickperunit, price: quickpriceoutlet.text!, totalsum: quicksum.text!, icon: quickcategory.catimage, category: quickcategory, catUUID: quickcategoryUUID)
        
        poppresented = false
        
        newquantitybutton.tintColor = UIColorFromRGB(0x979797)
        
        dimmerforpopover.hidden = true
        
        /*
        self.quicksmallconstraint.constant = -610

        UIView.animateWithDuration(0.2, animations: { () -> Void in

            self.view.layoutIfNeeded()
            
            }, completion: { (value: Bool) -> Void in
                self.smallpopover.hidden = true
        })
        */
        
        self.smallpopover.hidden = true
        

        
    }
    
    let dimmer : UIView = UIView()
    
    
    
    func handlebvTap(sender: UITapGestureRecognizer? = nil) {
        
        dimmer.removeFromSuperview()
        
        
         notetopconstraint.constant = -520
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                self.shownoteview.hidden = true
        })
        view.endEditing(true)
        
        //self.shownoteview.hidden = true

    }
    
    
    @IBOutlet var listsettingsoutlet: UIButton!
    @IBOutlet var listcategoriesoutlet: UIButton!
    @IBOutlet var listeditsoutlet: UIButton!
    @IBOutlet var sharelistoutlet: UIButton!
    
    
    @IBAction func changecats(sender: AnyObject) {
        
       
        
        showhidecats()
    }
    
    
    
    func showhidecats() {
      
        if myeditingmode == true {
            print("can't change")
        }
        
        if showcats == true {
        
            showcats = false
            self.tableView.reloadData()
            listcategoriesoutlet.setTitle(NSLocalizedString("showcats", comment: ""), forState: UIControlState.Normal)
            
        } else if showcats == false {
            showcats = true
            self.tableView.reloadData()
            listcategoriesoutlet.setTitle(NSLocalizedString("hidecats", comment: ""), forState: UIControlState.Normal)
        }
      
    }
   
    @IBAction func closesetsarrowbutton(sender: AnyObject) {
        closesettings()
    }
    
    func closesettings() {
        
       
       closesets()
        navbutton.imageView!.transform = CGAffineTransformMakeRotation(CGFloat(2*M_PI))
       settingsopen = false
    }
    
    
    
    @IBAction func showsettingsbutton(sender: AnyObject) {
        
        
        clickthetitle()
        
    }
    
    
    func closesets() {
        
        dimmer.removeFromSuperview()
        
        
        notetopconstraint.constant = -520
        /*
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }) { (value: Bool) -> Void in
            self.shownoteview.hidden = true
        }
 */
        view.endEditing(true)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                self.shownoteview.hidden = true
        })
        
        //self.shownoteview.hidden = true
    }
    
    func showsettings() {
        
        view.endEditing(true)
        
        if showcats == true {
            listcategoriesoutlet.setTitle(NSLocalizedString("hidecats", comment: ""), forState: UIControlState.Normal)
        } else {
            listcategoriesoutlet.setTitle(NSLocalizedString("showcats", comment: ""), forState: UIControlState.Normal)
        }
        
       // slidedown
        shownoteview.hidden = false
        
        dimmer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        dimmer.backgroundColor = UIColorFromRGBalpha(0x2a2f36, alp: 0.3)
        
        
        let blurredtap = UITapGestureRecognizer(target: self, action: Selector("handlebvTap:"))
        blurredtap.delegate = self
        dimmer.userInteractionEnabled = true
        dimmer.addGestureRecognizer(blurredtap)
        
        self.view.addSubview(dimmer)
        
        notetopconstraint.constant = 0
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                
        })
        
        self.view.bringSubviewToFront(shownoteview)
        
    }
    
    
    @IBAction func newshownoteaction(sender: AnyObject) {
        
        shownoteview.hidden = false
        
        dimmer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        dimmer.backgroundColor = UIColorFromRGBalpha(0x2a2f36, alp: 0.3)
        
        
        let blurredtap = UITapGestureRecognizer(target: self, action: Selector("handlebvTap:"))
        blurredtap.delegate = self
        dimmer.userInteractionEnabled = true
        dimmer.addGestureRecognizer(blurredtap)
        
        self.view.addSubview(dimmer)
        
        notetopconstraint.constant = 90
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                
        })
        
        self.view.bringSubviewToFront(shownoteview)
    }
    
    
    
    
   
    
    var myeditingmode = Bool()
    
    let toolbar = UIToolbar()
    
    var temporaryshowcats = Bool()
    
    
    @IBOutlet var optionsoutletbutton: UIButton!
    
    @IBAction func EditAllBarButton(sender: AnyObject) {
        
  
        entereditingmode()
        /*
        temporaryshowcats = showcats
        
        showcats = false
        
        myeditingmode = true
        
        
        tableView.reloadData()
        
       // self.view.viewWithTag(7)!.hidden = true
        
       // self.optionsoutletbutton.hidden = true

        
        let copyItem: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("copy", comment: ""), style: UIBarButtonItemStyle.Plain, target: self, action: "copyitems:")
        copyItem.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Avenir-Book", size: 15)!, NSForegroundColorAttributeName: UIColorFromRGB(0xE0FFB2)], forState: UIControlState.Normal)
        
        let cancelItem: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("DoneButton", comment: ""), style: UIBarButtonItemStyle.Plain, target: self, action: "canceleditmode:")
        cancelItem.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Avenir-Book", size: 15)!, NSForegroundColorAttributeName: UIColorFromRGB(0xFAFAFA)], forState: UIControlState.Normal)
        
        let deleteItem: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("delete", comment: ""), style: UIBarButtonItemStyle.Plain, target: self, action: "deleteitemsmode:")
        
        deleteItem.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Avenir-Book", size: 15)!, NSForegroundColorAttributeName: UIColorFromRGB(0xF23D55)], forState: UIControlState.Normal)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        let pasteItem: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("paste", comment: ""), style: UIBarButtonItemStyle.Plain, target: self, action: "pasteitems:")
        pasteItem.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Avenir-Book", size: 15)!, NSForegroundColorAttributeName: UIColorFromRGB(0xFAFAFA)], forState: UIControlState.Normal)
        

             let toolbarButtons = [pasteItem,deleteItem,copyItem,flexibleSpace,cancelItem]

        
        toolbar.tag = 8

        toolbar.frame = CGRectMake(0, 20, self.view.frame.size.width, 46)
        toolbar.sizeToFit()
        toolbar.translucent = false
        toolbar.setItems(toolbarButtons, animated: true)

        toolbar.barTintColor = UIColorFromRGB(0x31797D)
        toolbar.alpha = 1

        self.view.addSubview(toolbar)
        self.view.bringSubviewToFront(toolbar)
        */
        
    }
    
    
    //// func to copy checked items!
    
    var itemsidsinbuffer = [String]()
    
    var itemtocopy = Dictionary<String, AnyObject>()
    
    
    /*
    func canceleditmode(sender: UIButton!) {
        //tableView.editing = false
        
       // itemsinbuffertopaste.removeAll(keepCapacity: true) // Perhap I should leave this array intact
        
        for var i = 0; i < shoppingcheckedtocopy.count; i++ {
            shoppingcheckedtocopy[i] = false
        }
        
        itemsinbuffer.removeAll(keepCapacity: true)
        
        myeditingmode = false
        
        showcats = temporaryshowcats
        
        toolbar.removeFromSuperview()
        self.view.viewWithTag(7)!.hidden = false
        
        tableView.reloadData()
        
        self.optionsoutletbutton.hidden = false
        
    }
    */
    func deleteitemsmode(sender: UIButton!) {
        
        
        
        for var index = 0; index < itemsinbuffer.count; index++ {
            
            let itemid : String = itemsinbuffer[index]["ItemId"] as! String
            
            for ( var i = 0; i < itemsDataDict.count; i++ ) {
                
                if itemsDataDict[i]["ItemId"] as? String == itemid {
                    
                    itemsDataDict.removeAtIndex(i)
                    
                    
                    self.sortcategories(itemsDataDict)
                    //sort categories again!
                    
                    
                }
            }
            
            let querydelete = PFQuery(className:"shopItems")
            querydelete.fromLocalDatastore()
            querydelete.whereKey("itemUUID", equalTo: itemid)
            querydelete.getFirstObjectInBackgroundWithBlock() {
                (itemList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let itemList = itemList {
                    
                    
                    itemList.unpinInBackground()
                    
                }
                
                
            }
            
        }
        
        for var i = 0; i < shoppingcheckedtocopy.count; i++ {
            shoppingcheckedtocopy[i] = false
        }

       
       // myeditingmode = false
       // showcats = temporaryshowcats
        
       
        
        tableView.reloadData()
        
        
        summationPrices()
        summationcheckedPrices()
        
        countitems()
        countchecked()
        itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
        showprogress()
        itemsinbuffertopaste.removeAll(keepCapacity: true)
        
        
        itemsinbuffer.removeAll(keepCapacity: true)
    }
    
    
    func checktocopy(sender: UIButton) {
        

        //if sender.imageForState(.Normal) == notcheckedImageToCopy {
        //if sender.tintColor == UIColorFromRGB(0xC6C6C6) {
        
        if showcats == false {
        
        if !sender.selected {
            //means it is unchecked
        
        let button = sender as UIButton
        let view = button.superview!
            let innerview = view.superview!
       // let cell = view.superview as! ItemShopListCell
        let cell = innerview.superview as! ItemShopListCell
        let indexPath = tableView.indexPathForCell(cell)
        
        //itemtocopy = itemsDataDict[indexPath.row]["ItemId"] as! String
            
            
        itemtocopy = itemsDataDict[indexPath!.row]
        shoppingcheckedtocopy[indexPath!.row] = true

            
        itemsinbuffer.append(itemtocopy)
            

       // sender.setImage(checkedImageToCopy, forState: .Normal)
          //  sender.tintColor = UIColorFromRGB(0xC6C6C6)
        
       // } else if sender.imageForState(.Normal) == checkedImageToCopy {
          //} else if sender.tintColor == UIColorFromRGB(0x61C791) {
            
            sender.selected = true
            
        } else if sender.selected {
            //means it is checked
            
            let button = sender as UIButton
            let view = button.superview!
            let innerview = view.superview!//
            //let cell = view.superview as! ItemShopListCell
            let cell = innerview.superview as! ItemShopListCell
            let indexPath = tableView.indexPathForCell(cell)
            
            
            shoppingcheckedtocopy[indexPath!.row] = false

            
            let itemtoremove = itemsDataDict[indexPath!.row]["ItemId"] as! String

            for ( var i = 0; i < itemsinbuffer.count; i++ ) {
                
                if itemsinbuffer[i]["ItemId"] as? String == itemtoremove {
                    
                    itemsinbuffer.removeAtIndex(i)
                    // tableView.reloadData() //this was really necessary
                    
                }
            }

            
            sender.selected = false
           // sender.setImage(notcheckedImageToCopy, forState: .Normal)
            
            //itemsDataDict[indexPath!.row]

        
        }
        
        } else {
            // showcats true
            
            
        }
        
    }
    
    func displayInfoAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "SuccessAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0x31797D, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)

        alertview.addAction(closeCallback)
    }
    
    func displayFailAlert(title: String, message: String) {
        
        let customIcon = UIImage(named: "FailAlert")
        let alertview = JSSAlertView().show(self, title: title, text: message, buttonText: "OK", color: UIColorFromHex(0xF23D55, alpha: 0.9), iconImage: customIcon)
        alertview.setTextTheme(.Light)
        // alertview.addAction(cancelCallback)
        alertview.addAction(closeCallback)
    }
    
    let progressHUD = ProgressHUD(text: NSLocalizedString("pasting", comment: ""))
      let progressHUDsave = ProgressHUD(text: NSLocalizedString("saving", comment: ""))
    let progressHUDload = ProgressHUD(text: NSLocalizedString("loading", comment: ""))
    
    func pause() {
        
        
        self.view.addSubview(progressHUD)
        
        progressHUD.setup()
        progressHUD.show()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func pauseload() {
        
        
        self.view.addSubview(progressHUDload)
        
        progressHUDload.setup()
        progressHUDload.show()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func pausesave() {
        
        
        self.view.addSubview(progressHUDsave)
        
        progressHUDsave.setup()
        progressHUDsave.show()
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }

    
    
    func restore() {
        
        progressHUD.hide()
        
        
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    func restoresave() {
        
        progressHUDsave.hide()
        
        
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    func restoreload() {
        
        progressHUDload.hide()
        
        
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }


    
    
    func closeCallback() {
        print("Closed")
    }
    
   // func copyitems(bufferitems: [Dictionary<String, AnyObject>]) {
    func copyitems(sender: UIButton!) {
        
        itemsinbuffertopaste.removeAll(keepCapacity: true)
        
        itemsinbuffertopaste.appendContentsOf(itemsinbuffer)
        
        itemsinbuffer.removeAll(keepCapacity: true)
        
        // for var index = 0; index < bufferitems.count; index++ {
            for var index = 0; index < itemsinbuffertopaste.count; index++ {
                
            let item : String = itemsinbuffertopaste[index]["ItemName"] as! String
            
          //  print("Item to copy is: \(item)")
                
            itemsinbuffertopaste[index]["ItemIsChecked"] = false //important!
                itemsinbuffertopaste[index]["ItemIsFav"] = false //probably also should do that
                
                // i think i should change the id here
                
                var uuid = NSUUID().UUIDString
                var itemid = "shopitem\(uuid)"
                
                itemsinbuffertopaste[index]["ItemId"] = itemid
            
        }
        
        tableView.reloadData()
        
       // displayInfoAlert(NSLocalizedString("itemscopied", comment: ""), message: NSLocalizedString("openthelist", comment: ""))
        
    }
    
    
    
    func pasteitems(sender: UIButton) {
        
        
        if itemsinbuffertopaste.count != 0 {
        
        self.pause()
        
        itemsDataDict.appendContentsOf(itemsinbuffertopaste) //TOO EARLY, I am adding the same
            
            for var i = 0; i < shoppingcheckedtocopy.count; i++ {
                shoppingcheckedtocopy[i] = false
            }

        
        summationPrices()
            summationcheckedPrices()
            countitems()
            countchecked()
            itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
            showprogress()
        
        self.sortcategories(itemsDataDict)
            
           
        
            
        
        
       // myeditingmode = false
        
       // showcats = temporaryshowcats
        
        tableView.reloadData()
        
         
        
        self.restore()

   
            tableViewScrollToBottom(true)
            
            addedindicator.alpha = 1
            addedindicator.fadeOut()

        for var index = 0; index < itemsinbuffertopaste.count; index++ {
            
            shoppingcheckedtocopy.append(false)
            

            var shopItem = PFObject(className:"shopItems")

            shopItem["itemUUID"] = itemsinbuffertopaste[index]["ItemId"]//itemid
            shopItem["itemName"] = itemsinbuffertopaste[index]["ItemName"]
            shopItem["itemNote"] = itemsinbuffertopaste[index]["ItemNote"]
            
            //shopItem["itemQuantity"] = itemQuantityOutlet.text
            shopItem["itemQuantity"] = itemsinbuffertopaste[index]["ItemQuantity"]
            shopItem["itemPriceS"] = itemsinbuffertopaste[index]["ItemOneUnitPrice"]
            shopItem["TotalSumS"] = itemsinbuffertopaste[index]["ItemTotalPrice"]
            
            shopItem["ItemsList"] = self.currentList
            
            shopItem["belongsToUser"] = PFUser.currentUser()!.objectId!
            

                shopItem["itemUnit"] = itemsinbuffertopaste[index]["ItemUnit"]
  
                shopItem["perUnit"] = itemsinbuffertopaste[index]["ItemPerUnit"]
       
            
            shopItem["chosenFromHistory"] = true
            shopItem["itemImage"] = NSNull()
            shopItem["isChecked"] = false
            
            shopItem["Category"] = itemsinbuffertopaste[index]["ItemCategory"]
            
            shopItem["isCatalog"] = itemsinbuffertopaste[index]["ItemIsCatalog"]
            
            shopItem["originalInCatalog"] = itemsinbuffertopaste[index]["ItemOriginal"]
            
            shopItem["isFav"] = itemsinbuffertopaste[index]["ItemIsFav"]
            
            shopItem["chosenFromFavs"] = true
            
            var date = NSDate()
            
            shopItem["CreationDate"] = date
            shopItem["UpdateDate"] = date
            
            shopItem["ServerUpdateDate"] = date.dateByAddingTimeInterval(-120)
            
            shopItem["isHistory"] = false //for filtering purposes when deleting the list and all its items
            shopItem["isDeleted"] = false
            
           // self.saveImageLocally(imageData)
            
            
            shopItem["defaultpicture"] = itemsinbuffertopaste[index]["ItemIsDefPict"]
            shopItem["OriginalInDefaults"] = itemsinbuffertopaste[index]["ItemOriginalInDefaults"]
            
            
            if itemsinbuffertopaste[index]["ItemIsDefPict"] as! Bool == true {
                shopItem["itemImage"] = NSNull()
                

                
            } else {

                
                shopItem["itemImage"] = NSNull()//imageFile
 
            }
            
            
            shopItem["imageLocalPath"] = itemsinbuffertopaste[index]["ItemImagePath"]
//self.imagePath
            
            shopItem.pinInBackgroundWithBlock({ (success, error) -> Void in
                if success {
                    
                    print("saved item")

                } else {
                    print("no id found")
                }
                
                
    
                
            })

        }
        
        
    ////})
        
        } else {
    
             displayFailAlert(NSLocalizedString("noitemsto", comment: ""), message: NSLocalizedString("pleasecopy", comment: ""))
        }
    }
    
    @IBAction func DeleteBarButton(sender: AnyObject) {
    }
    
    
    @IBAction func gobackBar(sender: AnyObject) {
          }
    
    
    @IBAction func optionsBar(sender: AnyObject) {
        //gobacktomainmenusegue
        
        
    }
    
    @IBAction func addmanyBar(sender: AnyObject) {
        
        performSegueWithIdentifier("NewAddItemWithOptions", sender: self)
    }
    
    
    @IBAction func addBar(sender: AnyObject) {
        
        performSegueWithIdentifier("additemmodalsegue", sender: self)
    }
    
    
    
    
    @IBAction func endeditnote(sender: AnyObject) {
        
        let query = PFQuery(className:"shopLists")
        query.fromLocalDatastore()
        query.whereKey("listUUID", equalTo: currentList)
        query.getFirstObjectInBackgroundWithBlock() {
            (todolist: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let todolist = todolist {
                
                todolist["ShopListNote"] = ""//self.ShopListNoteOutlet.text
                todolist.pinInBackground()
               // todolist.saveEventually()
            }
        }
    }
    
    
    func WantToSaveAlert() {
        let customIcon = UIImage(named: "activity.png")
        let alertview = JSSAlertView().show(self, title: "Save the list?", text: "List data still will be available during this session", buttonText: "Yes", cancelButtonText: "Cancel", iconImage: customIcon)
        alertview.addAction(closeCallbackSave)
        alertview.addCancelAction(cancelCallbackSave)
    }
    
    func closeCallbackSave() {
        
        
       
    }
    
    func cancelCallbackSave() {
        
       
    }
    
    
    func savelistinfo() {
        
        let query = PFQuery(className:"shopLists")
        query.fromLocalDatastore()
        
        query.whereKey("listUUID", equalTo: currentList)
        query.getFirstObjectInBackgroundWithBlock() {
            
            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
                self.restoresave()
            } else if let shopList = shopList {
                
                shopList["ShopListName"] = self.self.listnameinview.text
               // shopList["ShopListNote"] = self.ShopListNoteOutlet.text
                if self.isReceivedList == false {
                    shopList["isReceived"] = false
                } else {
                    shopList["isReceived"] = true
                }
                
                if self.isReceivedList == false {
                    shopList["isSaved"] = false
                } else {
                    shopList["isSaved"] = true
                }
                

                
                shopList["ItemsCount"] = self.itemsoverallqty
                shopList["CheckedItemsCount"] = self.checkeditemsqty
                
                 let updatedate = NSDate()
                
                shopList["updateDate"] = updatedate
                
                shopList["ListColorCode"] = self.colorcode
                
                //shopList["ItemsInTheShopList"] = self.shoppingListItemsIds
                
                
                shopList.pinInBackground()
                
                // shopList.saveEventually()
            }
        }

        
        
    }
    
  
    

    
    
    ///////// COLOR CODER PART
    var colorcode = String()
    
    var red:String = "F23D55"
    var dgreen:String = "31797D"
    var gold:String = "A2AF36"
    var black:String = "2A2F36"
    var grey:String = "838383"
    var magenta:String = "1EB2BB"
    var lgreen:String = "61C791"
    var lightmagenta: String = "7FC2C6"
    var pink: String = "E88996"
    var orange: String = "E18C16"
    var violet:String = "7D3169"
    var darkred:String = "713D3D"
    
    
    /////////////
    
    
    
    
    func SaveListLocal() {
        
        WantToSaveAlert()
    }
    
    var idsinthislist = [String]()
    
    func additemstolistsarray() {
        
       // var idsinthislist = [String]()
        idsinthislist.removeAll(keepCapacity: true)
        
        for item in itemsDataDict {
            idsinthislist.append(item["ItemId"] as! String)
        }
        
        let query = PFQuery(className:"shopLists")
        query.fromLocalDatastore()
        // query.getObjectInBackgroundWithId(currentList) {
        query.whereKey("listUUID", equalTo: currentList)
        // queryfav.getObjectInBackgroundWithId(listtofav!) {
        query.getFirstObjectInBackgroundWithBlock() {
            
            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let shopList = shopList {
                // shopList["ItemsInTheShopList"] = self.shoppingListItemsIds
                shopList["ItemsInTheShopList"] = self.idsinthislist

                shopList.pinInBackground()
            
            }
        }

    }
    
    
    @IBAction func openmenuaction(sender: AnyObject) {
        
      //  additemstolistsarrayandsave()
    }
    
    func additemstolistsarrayandsave() {
        
        // var idsinthislist = [String]()
        idsinthislist.removeAll(keepCapacity: true)
        
        for item in itemsDataDict {
            idsinthislist.append(item["ItemId"] as! String)
        }
        
        print(idsinthislist)
        
        let updatedate = NSDate()
        
        var currencyarray = [String]()
        
        let query = PFQuery(className:"shopLists")
        query.fromLocalDatastore()
        // query.getObjectInBackgroundWithId(currentList) {
        query.whereKey("listUUID", equalTo: currentList)
        // queryfav.getObjectInBackgroundWithId(listtofav!) {
        query.getFirstObjectInBackgroundWithBlock() {
            
            (shopList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let shopList = shopList {
                // shopList["ItemsInTheShopList"] = self.shoppingListItemsIds
                shopList["ItemsInTheShopList"] = self.idsinthislist
                // self.additemstolistsarray()
                
                
                
                shopList["ShopListName"] = self.listnameinview.text
                shopList["ShopListNote"] = self.listnoteinview.text
                if self.isReceivedList == false {
                    shopList["isReceived"] = false
                } else {
                    shopList["isReceived"] = true
                }
                
                if self.isReceivedList == false {
                    shopList["isSaved"] = false
                } else {
                    shopList["isSaved"] = true
                }
                
                
                
                shopList["ItemsCount"] = self.itemsoverallqty
                shopList["CheckedItemsCount"] = self.checkeditemsqty
                
                
                
                shopList["updateDate"] = updatedate
                
                shopList["ListColorCode"] = self.colorcode

                currencyarray.append(code)
                currencyarray.append(symbol)
                shopList["CurrencyArray"] = currencyarray
                
                shopList["ShowCats"] = self.showcats
                
                
                shopList["ListTotalSum"] = self.totalsumforlist

                shopList.pinInBackground()

            }
        }

         if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(currentList) {
            UserLists[foundlist].listname = self.listnameinview.text
            UserLists[foundlist].listnote = self.listnoteinview.text
            UserLists[foundlist].listcurrency = [code,symbol]//code //later add array instead of just string currency
            UserLists[foundlist].listcategories = showcats
            UserLists[foundlist].listitemscount = itemsoverallqty
            UserLists[foundlist].listcheckeditemscount = checkeditemsqty
            // UserLists[foundlist].listcreationdate = updatedate
            UserLists[foundlist].listcolorcode = colorcode
            UserLists[foundlist].listtotalsum = totalsumforlist
            
        }

         if let foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(currentList) {
            
            
            UserShopLists[foundshoplist].listname = self.listnameinview.text
            UserShopLists[foundshoplist].listnote = self.listnoteinview.text
            UserShopLists[foundshoplist].listcurrency = [code,symbol]//code //later add array instead of just string currency
            UserShopLists[foundshoplist].listcategories = showcats
            UserShopLists[foundshoplist].listitemscount = itemsoverallqty
            UserShopLists[foundshoplist].listcheckeditemscount = checkeditemsqty
          //  UserShopLists[foundshoplist].listcreationdate = updatedate
            UserShopLists[foundshoplist].listcolorcode = colorcode
            UserShopLists[foundshoplist].listtotalsum = totalsumforlist
        }
        
     //   if let foundfavlist = find(lazy(UserFavLists).map({ $0.listid }), currentList) {
        if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(currentList) {
            
            UserFavLists[foundfavlist].listname = self.listnameinview.text
            UserFavLists[foundfavlist].listnote = self.listnoteinview.text
            UserFavLists[foundfavlist].listcurrency = [code,symbol]//code //later add array instead of just string currency
            UserFavLists[foundfavlist].listcategories = showcats
            UserFavLists[foundfavlist].listitemscount = itemsoverallqty
            UserFavLists[foundfavlist].listcheckeditemscount = checkeditemsqty
         //   UserFavLists[foundfavlist].listcreationdate = updatedate
            UserFavLists[foundfavlist].listcolorcode = colorcode
            UserFavLists[foundfavlist].listtotalsum = totalsumforlist
        }

        
        //ItemsCount = idsinthislist.count
        // return ItemsCount
    }
    
    func newPFObject() {

        
        let uuid = NSUUID().UUIDString
        let listuuid = "shoplist\(uuid)"
        var listId: String?
        let shopListNew = PFObject(className:"shopLists")
        
        let local = NSLocale.currentLocale()
        symbol = local.objectForKey(NSLocaleCurrencySymbol) as! String
     //   code = local.objectForKey(NSLocaleCurrencyCode) as! String
        
        if let currencyCode = NSLocale.currentLocale().objectForKey(NSLocaleCurrencyCode) as? String {
            code = currencyCode
            //Will display "USD", for example
        }
        
        
        shopListNew["listUUID"] = listuuid
        
        shopListNew["ShopListName"] = self.listnameinview.text
        shopListNew["ShopListNote"] = ""//ShopListNoteOutlet.text
        //for user stuff
        shopListNew["BelongsToUser"] = PFUser.currentUser()!.objectId!
        // shopListNew["BelongsToUsers"] = [PFUser.currentUser()!.objectId!]
        shopListNew["isReceived"] = false
        shopListNew["isFavourite"] = false
        shopListNew["ShareWithArray"] = []
        shopListNew["sentFromArray"] = ["",""]
        shopListNew["ItemsInTheShopList"] = []
        shopListNew["isSaved"] = false
        
        shopListNew["isDeleted"] = false
        shopListNew["confirmReception"] = false
        shopListNew["isShared"] = false
        
        let creationdate = NSDate()
        
        shopListNew["creationDate"] = creationdate
        shopListNew["updateDate"] = creationdate
        
        shopListNew["ServerUpdateDate"] = creationdate.dateByAddingTimeInterval(-120)
        
        shopListNew["ItemsCount"] = 0
        shopListNew["CheckedItemsCount"] = 0
        
        shopListNew["ListCurrency"] = code
        shopListNew["ShowCats"] = false
        
        shopListNew["CurrencyArray"] = [code,symbol]
        
        shopListNew["ListColorCode"] = colorcode
        
        shopListNew["ListTotalSum"] = ""
        
        self.currentList = listuuid
        print("Current list is \(self.currentList)")
        //shopList["ItemsInTheShopList"] = shoppingListItemsIds
        
        /// ALSO NEED TO PUT IT TO ARRAY OF LISTS
        let listid = listuuid
        let listname = self.listnameinview.text
        let listnote = ""//ShopListNoteOutlet.text
        let listcreationdate = creationdate
        let listisfav = false
        let listisreceived = false
        let listbelongsto = PFUser.currentUser()!.objectId!
        let listissentfrom = ["",""]
        let listissaved = false
        
        let listconfirm = false
        let listisdeleted = false
        let listisshared = false
        let listsharewitharray = []
        
        let listitemscount = 0
        let listcheckeditems = 0
        let listtype = "Shop"
        let listcurrency = [code,symbol]//code
        let listshowcats = false
        let listscolor = colorcode
        
        let listtotalsum = ""
        
        
        let userlist : UserList = UserList(
            listid:listid,
            listname:listname!,
            listnote:listnote,
            listcreationdate:listcreationdate,
            listisfavourite:listisfav,
            listisreceived:listisreceived,
            listbelongsto:listbelongsto,
            listreceivedfrom:listissentfrom,
            listissaved:listissaved,
            listconfirmreception:listconfirm,
            listisdeleted:listisdeleted,
            listisshared:listisshared,
            listsharedwith:listsharewitharray as! [[AnyObject]],
            listitemscount:listitemscount,
            listcheckeditemscount:listcheckeditems,
            listtype:listtype,
            listcurrency:listcurrency,
            listcategories:listshowcats,
            listcolorcode:listscolor,
            listtotalsum: listtotalsum
            
        )

        UserShopLists.append(userlist)
        UserLists.append(userlist)
        
        
        shopListNew.pinInBackground()
      
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //here I will prepare the data for my list
        
        
        //additemstolistsarray()
        
        //listoptionsshow
        if segue.identifier == "listoptionsshow" {
            
            
           // canceledits() // NOT SURE IF NEEDED
            
            closesettings()
        
        let popoverViewController = segue.destinationViewController as! ListOptionsPopover//UIViewController
       // popoverViewController.modalPresentationStyle = UIModalPresentationStyle.CurrentContext //Popover
            
            
            popoverViewController.delegate = self
           // popoverViewController.showcats = showcats
            popoverViewController.code = code
            popoverViewController.symbol = symbol
            
            popoverViewController.colorcode = colorcode
            
            popoverViewController.senderVC = "ShopList"
            
            popoverViewController.listtype = "Shop"
            
            
        
        }
    
        if segue.identifier == "AddItemToTheList" {
            //let destinationVC2 : AddItemViewController = segue.destinationViewController as! AddItemViewController
            
            let addnavVC = segue.destinationViewController as! UINavigationController
            
            let destinationVC2 = addnavVC.viewControllers.first as! AddItemViewController
            
            destinationVC2.getcurrentlist = currentList
            destinationVC2.receivedarrayofdicts = itemsDataDict
            
            destinationVC2.existingitem = false
            
           // additemstolistsarray()
            
            
        }
        
        
        if segue.identifier == "createcustomcategoryfromlist" {
          
            
            let popoverViewController = segue.destinationViewController as! ManageCategoriesVC
  
            
            popoverViewController.additemdelegate = self
            
            
        }
        
        
        if segue.identifier == "additemmodalsegue" {
          
            
            
            
            let toViewController = segue.destinationViewController as! AddItemViewController//UIViewController
           
            
            
            toViewController.shopdelegate = self // NEED THIS FOR REFRESHING FUNCTION!
            //toViewController.view.alpha = 0.7
            // self.presentViewController(self, animated: true, completion: nil)
            
            
            
            toViewController.getcurrentlist = currentList
            toViewController.receivedarrayofdicts = itemsDataDict
            
            toViewController.existingitem = false
            
            toViewController.sendercontroller = "ShopListCreation"
            
           // additemstolistsarray()
            
            
        }
        
        if segue.identifier == "NewAddItemWithOptions" {
            
           // let navVC = segue.destinationViewController as! UINavigationController
            
           // let additemsVC = navVC.viewControllers.first as! NewOptionsController
            
             let additemsVC = segue.destinationViewController as! NewOptionsController
            
            additemsVC.currentlist = currentList
            
            additemsVC.shoplistdelegate = self // DONT FORGET ABOUT THIS!!!
            
        }
        
        if segue.identifier == "EditItem" {
            let navVC1 = segue.destinationViewController as! UINavigationController
            
            let editVC = navVC1.viewControllers.first as! AddItemViewController
            editVC.existingitem = true
            editVC.currentitem = itemtoedit
            
            editVC.getcurrentlist = currentList
            
            
        } //gobacktomainmenusegue
        
        if segue.identifier == "gobacktomainmenusegue" {
            
           // SaveListLocal()
            
           // additemstolistsarray()
            
            let backVC = segue.destinationViewController as! MainMenuViewController
            backVC.isFromShopList = true
            backVC.shoplistid = currentList
            
            
            
            
        }
        
        if segue.identifier == "gobacksegue" {
            
            // SaveListLocal()
            
            
            //additemstolistsarray()
            additemstolistsarrayandsave()
            
            
        }

        
        if segue.identifier == "edititemmodalsegue" {

            
            let editVC = segue.destinationViewController as! AddItemViewController//UIViewController
            
            editVC.shopdelegate = self
            
            editVC.existingitem = true
            editVC.currentitem = itemtoedit
            
            editVC.getcurrentlist = currentList
            
            editVC.sendercontroller = "ShopListCreation"
            
        
            
            
        }
        
        
        if segue.identifier == "ShareFromListCreation" {
            
           // let shareNav = segue.destinationViewController as! UINavigationController
            
           // let shareVC = shareNav.viewControllers.first as! SharingViewController
            if myeditingmode == true {
                canceledits()
            }
            
            
            let shareVC = segue.destinationViewController as! SharingViewController
            
            additemstolistsarrayandsave()
            
            shareVC.listToShare = currentList
            shareVC.listToShareType = "Shop"
            shareVC.delegate = self
            shareVC.senderVC = "ShopCreationVC"
            
            
            
        }
        
        if segue.identifier == "showimagesfromshoplist" {
            
            let popoverViewController = segue.destinationViewController as! ImagesCollectionVC
            
            popoverViewController.delegate = self
            
        }
        
        
        
        
    }
    
    //var shoppingListItemsIds = [""] //seems like the reason for one redundant cell, for this "" id!
    
    
    //shoppingListItemsPrices.
    
    var totalsumforlist : String = String()
    
    func summationPrices() {
        
        var itemsprices = [Double]()
        
        for item in itemsDataDict {
            var doublevalue = (item["ItemTotalPrice"] as! String).doubleConverter
            itemsprices.append(doublevalue)
                //append(item["ItemTotalPrice"] as! String)
        }
        var sum = itemsprices.reduce(0, combine: +)

        var formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 4
        formatter.usesSignificantDigits = false
        formatter.minimumSignificantDigits = 1
        formatter.maximumSignificantDigits = 9
       // formatter.numberStyle = .CurrencyStyle
        
        
        var textsum: String = formatter.stringFromNumber(sum)!
        
        totalsumforlist = textsum
        

        var rubsymbol : String = "руб."
        
        if code == "RUB" {
            
               PricesSum.text = "\(NSLocalizedString("totalsum", comment: "")) \(textsum) \(rubsymbol)"
        } else {
               PricesSum.text = "\(NSLocalizedString("totalsum", comment: "")) \(symbol)\(textsum)"
        }
        
        quickcurrency.text = symbol
    }
    
    func summationcheckedPrices() {
        
        var itemsprices = [Double]()
        
        for item in itemsDataDict {
            if (item["ItemIsChecked"] as! Bool) == true {
            var doublevalue = (item["ItemTotalPrice"] as! String).doubleConverter
            itemsprices.append(doublevalue)
            }
            
        }
        var sum = itemsprices.reduce(0, combine: +)
        
        var formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 4
        formatter.usesSignificantDigits = false
        formatter.minimumSignificantDigits = 1
        formatter.maximumSignificantDigits = 9
        // formatter.numberStyle = .CurrencyStyle
        
        
        var textsum: String = formatter.stringFromNumber(sum)!
        
        
        var rubsymbol : String = "руб."
        
        if code == "RUB" {
            
            PricescheckedSum.text = "\(NSLocalizedString("spentsum", comment: "")) \(textsum) \(rubsymbol)"
        } else {
            PricescheckedSum.text = "\(NSLocalizedString("spentsum", comment: "")) \(symbol)\(textsum)"
        }
        
        quickcurrency.text = symbol
    }

    
    
    
    
    
    func dataretrievallist(){
        

        
        pauseload()
        
        var query1 = PFQuery(className:"shopItems")
        //query.whereKey("objectId", equalTo:"T7MqKFyDbQ")
        query1.fromLocalDatastore()
        //query1.orderByDescending("CreationDate")
        query1.whereKey("ItemsList", equalTo: activeList!)
        
        print(activeList!)
        
        query1.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
                self.shoppingListItemsIds.removeAll(keepCapacity: true)
                self.shoppingListItemsNames.removeAll(keepCapacity: true)
                self.shoppingListItemsNotes.removeAll(keepCapacity: true)
                self.shoppingListItemsQuantity.removeAll(keepCapacity: true)
                // self.shoppingListItemsImages.removeAll(keepCapacity: true)
                self.shoppingListItemsPrices.removeAll(keepCapacity: true)
                self.shoppingListItemsUnits.removeAll(keepCapacity: true)
                self.shoppingListItemsImagesPaths.removeAll(keepCapacity: true)
                self.shoppingListItemsImages2.removeAll(keepCapacity: true)
                self.shoppingListItemsIsChecked.removeAll(keepCapacity: true)
                self.shoppingListItemsCategories.removeAll(keepCapacity: true)
                self.shoppingListItemsCategoriesNames.removeAll(keepCapacity: true)
                self.shoppingListItemsIsCatalog.removeAll(keepCapacity: true)
                self.shoppingListOneUnitPrice.removeAll(keepCapacity: true)
                self.shoppingListItemsIsFav.removeAll(keepCapacity: true)
                self.shoppingListItemsPerUnit.removeAll(keepCapacity: true)
                self.checked.removeAll(keepCapacity: true) //getting this array not from parse
                self.shoppingListItemsCreation.removeAll(keepCapacity: true)
                self.shoppingListItemsUpdate.removeAll(keepCapacity: true)
                
                self.shoppingListItemsOriginal.removeAll(keepCapacity: true)
                
                self.shoppingListItemsIsDefPict.removeAll(keepCapacity: true)
                self.shoppingListItemsDefaultOriginal.removeAll(keepCapacity: true)
                
                self.shoppingpffile.removeAll(keepCapacity: true)
                
                shoppingcheckedtocopy.removeAll(keepCapacity: true)
                
                itemsDataDict.removeAll(keepCapacity: true)
                
                
                
                if let listitems = objects as? [PFObject] {
                    
                    //shoppingListItemsIds.removeAll(keepCapacity: true)
                    
                    for object in listitems {
                        // print(object.objectId)
                        //self.shoppingListItemsIds.append(object.objectId!)//["itemName"] as)
                        
                        self.shoppingListItemsIds.append(object["itemUUID"] as! String)
                        self.shoppingListItemsNames.append(object["itemName"] as! String)
                        self.shoppingListItemsNotes.append(object["itemNote"] as! String)
                        self.shoppingListItemsQuantity.append(object["itemQuantity"] as! String)
                        /*
                        if self.isReceivedList == true {
                        
                        self.shoppingListItemsImages.append(object["itemImage"] as! PFFile)
                        } else {
                        self.shoppingListItemsImages.append("no image on server")
                        }
                        */
                        self.shoppingListOneUnitPrice.append(object["itemPriceS"] as! String)
                        self.shoppingListItemsPrices.append(object["TotalSumS"] as! String)
                        self.shoppingListItemsUnits.append(object["itemUnit"] as! String)
                        self.shoppingListItemsPerUnit.append(object["perUnit"] as! String)
                        self.shoppingListItemsIsCatalog.append(object["isCatalog"] as! Bool)
                        
                        self.shoppingListItemsIsFav.append(object["isFav"] as! Bool)
                        
                        
                        self.shoppingListItemsIsDefPict.append(object["defaultpicture"] as! Bool)
                        self.shoppingListItemsDefaultOriginal.append(object["OriginalInDefaults"] as! String)
                        
                        if object["isCatalog"] as! Bool == false {
                            
                            // self.loadImageFromLocalStore(object["imageLocalPath"] as! String)
                            
                           // self.shoppingListItemsImages2.append(self.imageToLoad)
                            
                            if object["defaultpicture"] as! Bool == false {
                               
                                self.loadImageFromLocalStore(object["imageLocalPath"] as! String)
                                
                                self.shoppingListItemsImages2.append(self.imageToLoad)
                                
                                
                              
                            } else {
                                
                                    var imagename = object["OriginalInDefaults"] as! String
                                
                                if (UIImage(named: "\(imagename)") != nil) {
                                self.shoppingListItemsImages2.append(UIImage(named: "\(imagename)")!)
                                } else {
                                    self.shoppingListItemsImages2.append(imagestochoose[0].itemimage)
                                }

                            }

                        } else {
                           
                            
                             if let founditem = catalogitems.map({ $0.itemId }).lazy.indexOf((object["originalInCatalog"] as! String)) {
                            let catalogitem = catalogitems[founditem]
                                
                                self.shoppingListItemsImages2.append(catalogitem.itemimage)
                             } else {
                                self.shoppingListItemsImages2.append(imagestochoose[0].itemimage)
                            }
                        }
                        
                        self.shoppingListItemsImagesPaths.append(object["imageLocalPath"] as! String)
                        
                        self.checked.append(false)
                        
                        self.shoppingListItemsIsChecked.append(object["isChecked"] as! Bool)
                        
                        self.shoppingListItemsCategories.append(object["Category"] as! String)
                        
                        self.shoppingListItemsOriginal.append(object["originalInCatalog"] as! String)
                        
                        self.shoppingListItemsCreation.append(object["CreationDate"] as! NSDate)
                        
                        self.shoppingListItemsUpdate.append(object["UpdateDate"] as! NSDate)
                        
                       // print("Cats are \(self.shoppingListItemsCategories)")
                        
                        shoppingcheckedtocopy.append(false)
                        
                        self.summationPrices()
                        self.summationcheckedPrices()
                        
                        self.tableView.reloadData() // without this thing, table would contain only 1 row
                        
                        
                        
                    }
                }
                
                self.getcategoriesnames(self.shoppingListItemsCategories)
                self.fillthedict()
                
                self.restoreload()
                
                if itemsDataDict.count > 0 {
                  //  self.noitemview.hidden = true
                } else {
                  //  self.noitemview.hidden = false
                }
                
            } else {
                // Log details of the failure
                self.restoreload()
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        // NOW NEW QUERY TO GET LIST NAME AND NOTE BY DEFAULT
        var queryListInfo = PFQuery(className:"shopLists")
        //query.whereKey("objectId", equalTo:"T7MqKFyDbQ")
        queryListInfo.fromLocalDatastore()
        //queryListInfo.whereKey("objectId", equalTo: activeList!)
        queryListInfo.whereKey("listUUID", equalTo: activeList!)
        queryListInfo.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
                
                
                if let list = objects as? [PFObject] {
                    
                    //shoppingListItemsIds.removeAll(keepCapacity: true)
                    
                    for object in list {
                        
                        //self.self.listnameinview.text = object["ShopListName"] as! String
                        self.listnoteinview.text = object["ShopListNote"] as! String
                        self.listnameinview.text = object["ShopListName"] as! String
                        
                        self.navigationItem.title = object["ShopListName"] as! String
                        
                        //need to know if its received
                        self.isReceivedList = object["isReceived"] as! Bool
                        
                        var currencyarray = object["CurrencyArray"] as! [AnyObject]
                        
                        code = (stringInterpolationSegment: currencyarray[0] as! String)
                        symbol = (stringInterpolationSegment: currencyarray[1] as! String)
                        //pass those variables to popup later
                        
                        self.changecodeandsymbol(code, newsymbol: symbol)
                        /*
                        let button =  UIButton(type: .Custom)
                        button.frame = CGRectMake((((self.view.frame.size.width) / 2) - 80),0,160,40) as CGRect
                        button.setTitle(object["ShopListName"] as! String, forState: UIControlState.Normal)
                        button.titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 14)
                        button.setTitleColor(self.UIColorFromRGB(0x31797D), forState: .Normal)
                        let spacing: CGFloat = 10;
                        // let textsize : CGSize = button.titleLabel!.attributedText!.
                        //let textsize : CGFloat = button.titleLabel!.intrinsicContentSize().width
                        // button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
                        let titleimage = UIImage(named: "myliststitle") as UIImage?
                        button.setImage(titleimage, forState: .Normal)

                        let textsize: CGSize = button.titleLabel!.text!.sizeWithAttributes([NSFontAttributeName:UIFont(name: "AvenirNext-Regular", size: 14.0)!])
                        button.imageEdgeInsets = UIEdgeInsetsMake(2, textsize.width + 40, 0, 0); // top left bottom right
                                               button.addTarget(self, action: Selector("clickthetitle:"), forControlEvents: UIControlEvents.TouchUpInside)
                        self.navigationItem.titleView = button
                        */
                        // NAV TITLE AS A BUTTON
                        /*
                        self.navbutton.frame = CGRectMake((((self.view.frame.size.width) / 2) - 130),0,260,40) as CGRect
                        self.navbutton.setTitle(object["ShopListName"] as! String, forState: UIControlState.Normal)
                        self.navbutton.titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 14)
                        self.navbutton.setTitleColor(self.UIColorFromRGB(0x31797D), forState: .Normal)
                        
                        let titleimage = UIImage(named: "myliststitle") as UIImage?
                        self.navbutton.setImage(titleimage, forState: .Normal)
                        
                        let spacing : CGFloat = 3;
                        let insetAmount : CGFloat = 0.5 * spacing;
                        
                        // First set overall size of the button:
                        self.navbutton.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);
                        self.navbutton.sizeToFit()
                        
                        // Then adjust title and image insets so image is flipped to the right and there is spacing between title and image:
                        self.navbutton.titleEdgeInsets  = UIEdgeInsetsMake(0, -self.navbutton.imageView!.frame.size.width - insetAmount, 0,  self.navbutton.imageView!.frame.size.width  + insetAmount);
                        self.navbutton.imageEdgeInsets  = UIEdgeInsetsMake(2, self.navbutton.titleLabel!.frame.size.width + insetAmount, 0, -self.navbutton.titleLabel!.frame.size.width - insetAmount);
                        
                        self.navbutton.addTarget(self, action: Selector("clickthetitle:"), forControlEvents: UIControlEvents.TouchUpInside)
                        self.navigationItem.titleView = self.navbutton
                        */
                        
                        self.tableView.reloadData()
                        
                       // self.choosecurrency.setTitle(String(stringInterpolationSegment: currencyarray[1]), forState: UIControlState.Normal)
                        
                    }
                }
            } else {
                // Log details of the failure
                self.restoreload()
                print("Error: \(error!) \(error!.userInfo)")
            }
            
        }
        
        tableView.reloadData()
        summationPrices() // THIS GUY SAVES THE DAY
        summationcheckedPrices()
        showprogress()
    }
    
    
    func dataretrievalinorder()
    {
        
        // for activeItems in shoppingListItemsIds
        // mark2
        // for var i = 0;i<item.count;++i {
        
        var itemsarray = [String]()
        
        var queryitemsarray = PFQuery(className:"shopLists")
        queryitemsarray.fromLocalDatastore()
        // querynew.getObjectInBackgroundWithId(itemtocheck) {
        queryitemsarray.whereKey("listUUID", equalTo: activeList!)
        queryitemsarray.limit = 1
        var lists = queryitemsarray.findObjects()
        if (lists != nil) {
            for list in lists! {
                
                if let thislist = list["ItemsInTheShopList"] as? [String] { //used to be username
                    
                    
                    
                    itemsarray.appendContentsOf(list["ItemsInTheShopList"] as! [String])
                    
                }
                
                
            }
        } else {
            print("Error")
        }
        
        self.shoppingListItemsIds.removeAll(keepCapacity: true)
        self.shoppingListItemsNames.removeAll(keepCapacity: true)
        self.shoppingListItemsNotes.removeAll(keepCapacity: true)
        self.shoppingListItemsQuantity.removeAll(keepCapacity: true)
        // self.shoppingListItemsImages.removeAll(keepCapacity: true)
        self.shoppingListItemsPrices.removeAll(keepCapacity: true)
        self.shoppingListItemsUnits.removeAll(keepCapacity: true)
        self.shoppingListItemsImagesPaths.removeAll(keepCapacity: true)
        self.shoppingListItemsImages2.removeAll(keepCapacity: true)
        self.shoppingListItemsIsChecked.removeAll(keepCapacity: true)
        self.shoppingListItemsCategories.removeAll(keepCapacity: true)
        self.shoppingListItemsCategoriesNames.removeAll(keepCapacity: true)
        self.shoppingListItemsIsCatalog.removeAll(keepCapacity: true)
        self.shoppingListOneUnitPrice.removeAll(keepCapacity: true)
        self.shoppingListItemsIsFav.removeAll(keepCapacity: true)
        self.shoppingListItemsPerUnit.removeAll(keepCapacity: true)
        self.checked.removeAll(keepCapacity: true) //getting this array not from parse
        self.shoppingListItemsCreation.removeAll(keepCapacity: true)
        self.shoppingListItemsUpdate.removeAll(keepCapacity: true)
        
        self.shoppingListItemsOriginal.removeAll(keepCapacity: true)
        
        self.shoppingListItemsIsDefPict.removeAll(keepCapacity: true)
        self.shoppingListItemsDefaultOriginal.removeAll(keepCapacity: true)
        
        self.shoppingpffile.removeAll(keepCapacity: true)
        
        shoppingcheckedtocopy.removeAll(keepCapacity: true)
        
        itemsDataDict.removeAll(keepCapacity: true)
        
        // maybe this will reduce time of loading a bit
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
        
        for var i = 0;i<itemsarray.count;++i {
            
          

        
        var query1 = PFQuery(className:"shopItems")
        query1.fromLocalDatastore()
        //query1.orderByDescending("CreationDate")
            query1.limit = 1
        query1.whereKey("itemUUID", equalTo: itemsarray[i])
        
            
          var objects = query1.findObjects()
            if (objects != nil) {
                if let listitems = objects as? [PFObject] {
                for object in listitems {
                

                    self.shoppingListItemsIds.append(object["itemUUID"] as! String)
                    self.shoppingListItemsNames.append(object["itemName"] as! String)
                    self.shoppingListItemsNotes.append(object["itemNote"] as! String)
                    self.shoppingListItemsQuantity.append(object["itemQuantity"] as! String)
                  
                    self.shoppingListOneUnitPrice.append(object["itemPriceS"] as! String)
                    self.shoppingListItemsPrices.append(object["TotalSumS"] as! String)
                    self.shoppingListItemsUnits.append(object["itemUnit"] as! String)
                    self.shoppingListItemsPerUnit.append(object["perUnit"] as! String)
                    self.shoppingListItemsIsCatalog.append(object["isCatalog"] as! Bool)
                    
                    self.shoppingListItemsIsFav.append(object["isFav"] as! Bool)
                    
                    
                    self.shoppingListItemsIsDefPict.append(object["defaultpicture"] as! Bool)
                    self.shoppingListItemsDefaultOriginal.append(object["OriginalInDefaults"] as! String)
                    
                    if object["isCatalog"] as! Bool == false {
                        
                        //self.loadImageFromLocalStore(object["imageLocalPath"] as! String)
                        
                        // self.shoppingListItemsImages2.append(self.imageToLoad)
                        
                        if object["defaultpicture"] as! Bool == false {
                            
                            
                            var imageFile = object["itemImage"] as? PFFile
                            if imageFile != nil {
                                var imageData = imageFile!.getData()
                                if (imageData != nil) {
                                    var image = UIImage(data: imageData!)
                                    self.shoppingListItemsImages2.append(image!)
                                    //print(image)
                                } else {
                                    self.shoppingListItemsImages2.append(imagestochoose[0].itemimage)
                                }
                            } else {
                                self.shoppingListItemsImages2.append(imagestochoose[0].itemimage)
                            }
                            
                            
                        } else {
                            
                            var imagename = object["OriginalInDefaults"] as! String
                            
                            if (UIImage(named: "\(imagename)") != nil) {
                                self.shoppingListItemsImages2.append(UIImage(named: "\(imagename)")!)
                            } else {
                                self.shoppingListItemsImages2.append(imagestochoose[0].itemimage)
                            }
                            
                        }
                        
                    } else {
                        //if catalog item
                        //self.shoppingListItemsImages2.append(
                      //  if let founditem = find(lazy(catalogitems).map({ $0.itemId }), (object["originalInCatalog"] as! String)) {
                        
                          if let founditem = catalogitems.map({ $0.itemId }).lazy.indexOf((object["originalInCatalog"] as! String)) {
                        let catalogitem = catalogitems[founditem]
                            
                            self.shoppingListItemsImages2.append(catalogitem.itemimage)
                        }
                    }
                    
                    self.shoppingListItemsImagesPaths.append(object["imageLocalPath"] as! String)
                    
                    self.checked.append(false)
                    
                    self.shoppingListItemsIsChecked.append(object["isChecked"] as! Bool)
                    
                    self.shoppingListItemsCategories.append(object["Category"] as! String)
                    
                    self.shoppingListItemsOriginal.append(object["originalInCatalog"] as! String)
                    
                    self.shoppingListItemsCreation.append(object["CreationDate"] as! NSDate)
                    
                    self.shoppingListItemsUpdate.append(object["UpdateDate"] as! NSDate)
                    
                    
                    
                    shoppingcheckedtocopy.append(false)
                    
                    self.summationPrices()
                    self.summationcheckedPrices()
                    
                  //  self.tableView.reloadData()
                    
                }
            }
            } else {
                print("Error")
            }

           } //end of for loop
        
        self.getcategoriesnames(self.shoppingListItemsCategories)
        self.fillthedict()
        
        
        dispatch_async(dispatch_get_main_queue(), {
        self.tableView.reloadData()
            })
        
    })
    
        // NOW NEW QUERY TO GET LIST NAME AND NOTE BY DEFAULT
        var queryListInfo = PFQuery(className:"shopLists")
        //query.whereKey("objectId", equalTo:"T7MqKFyDbQ")
        queryListInfo.fromLocalDatastore()
        //queryListInfo.whereKey("objectId", equalTo: activeList!)
        queryListInfo.whereKey("listUUID", equalTo: activeList!)
        queryListInfo.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
                
                
                if let list = objects as? [PFObject] {
                    
                    //shoppingListItemsIds.removeAll(keepCapacity: true)
                    
                    for object in list {
                        
                        self.self.listnameinview.text = object["ShopListName"] as! String
                       // self.ShopListNoteOutlet.text = object["ShopListNote"] as! String
                        
                        //need to know if its received
                        self.isReceivedList = object["isReceived"] as! Bool
                        
                        var currencyarray = object["CurrencyArray"] as! [AnyObject]
                        
                        code = (stringInterpolationSegment: currencyarray[0] as! String)
                        symbol = (stringInterpolationSegment: currencyarray[1] as! String)
                        //pass those variables to popup later
                        
                        self.colorcode = object["ListColorCode"] as! String
                        
                        // self.choosecurrency.setTitle(String(stringInterpolationSegment: currencyarray[1]), forState: UIControlState.Normal)
                        
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
            
        }
        
        //tableView.reloadData()
        summationPrices() // THIS GUY SAVES THE DAY
        summationcheckedPrices()
    }
    
        
        
    
    
    /*
    func dataretrieval(){
    
    println(self.mystring)
    
    
    }
    */
    
    func fillthedict() {
        
        // need for order
        var itemsarray = [String]()
        
        let queryitemsarray = PFQuery(className:"shopLists")
        queryitemsarray.fromLocalDatastore()
        // querynew.getObjectInBackgroundWithId(itemtocheck) {
        queryitemsarray.whereKey("listUUID", equalTo: activeList!)
        queryitemsarray.limit = 1
        let lists = queryitemsarray.findObjects()
        if (lists != nil) {
            for list in lists! {
                
                if let thislist = list["ItemsInTheShopList"] as? [String] { //used to be username
                    
                    
                    
                    itemsarray.appendContentsOf(list["ItemsInTheShopList"] as! [String])
                    
                }
                
                
            }
        } else {
            print("Error")
        }
        ///

        
        
        for var i = 0;i<shoppingListItemsIds.count;++i {
       // for var i = 0;i<itemsarray.count;++i {
            let itemid = shoppingListItemsIds[i] as String
            let itemname = shoppingListItemsNames[i] as String
            let itemnote = shoppingListItemsNotes[i] as String
            let itemquantity = shoppingListItemsQuantity[i] as String
            let itemprice = shoppingListItemsPrices[i] as String//["username"] as! String
            //name += " " + lName
            // var itemimage: AnyObject = shoppingListItemsImages[i] as AnyObject
            
        
            
            
            let itemimage2 = shoppingListItemsImages2[i] as UIImage
            let itemimagepath = shoppingListItemsImagesPaths[i] as String
            let itemunit = shoppingListItemsUnits[i] as String
            let itemchecked = shoppingListItemsIsChecked[i] as Bool
            let itemcategory = shoppingListItemsCategories[i] as String
            let itemcategoryname = shoppingListItemsCategoriesNames[i] as String
            
            let originalincatalog = shoppingListItemsOriginal[i] as String
            let itemiscatalog = shoppingListItemsIsCatalog[i] as Bool
            
            let itemoneunitprice = shoppingListOneUnitPrice[i] as String
            
            let itemisfav = shoppingListItemsIsFav[i] as Bool
            let itemperunit = shoppingListItemsPerUnit[i] as String
            
            let itemcreation = shoppingListItemsCreation[i] as NSDate
            let itemupdate = shoppingListItemsUpdate[i] as NSDate
            
            let itemisdefaultpict =  shoppingListItemsIsDefPict[i] as Bool
            let itemoriginalindefaults =  shoppingListItemsDefaultOriginal[i] as String
            
            ///try to sort this based on the predefined order
            
            let index : Int = 1
            
            
            dictionary = ["ItemId":itemid,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemprice,"ItemImage2":itemimage2,"ItemUnit":itemunit,"ItemIsChecked":itemchecked,"ItemImagePath":itemimagepath,"ItemCategory":itemcategory,"ItemIsCatalog":itemiscatalog,"ItemOriginal":originalincatalog,"ItemCategoryName":itemcategoryname,"ItemOneUnitPrice":itemoneunitprice,"ItemIsFav":itemisfav,"ItemPerUnit":itemperunit,"ItemCreation":itemcreation,"ItemUpdate":itemupdate,"ItemIsDefPict":itemisdefaultpict,"ItemOriginalInDefaults":itemoriginalindefaults,"Index":index]
            // dictionary = ["ItemId":itemid,"ItemName":itemname,"ItemNote":itemnote, "ItemQuantity":itemquantity,"ItemTotalPrice":itemprice,"ItemImage2":itemimage2,"ItemUnit":itemunit,"ItemChecked":itemchecked,"ItemImagePath":itemimagepath,"ItemCategory":itemcategory]
            
            if containsdict(itemsDataDict, element: dictionary) {
                print("Already contains this item")
            } else {
                
                itemsDataDict.append(dictionary)
            }
            
            // itemsDataDict.append(dictionary)
        }
        
        ///try to sort this based on the predefined order
        
        for var i = 0; i < itemsarray.count; i++ {
            for var j = 0; j < itemsDataDict.count; j++ {
            if (itemsDataDict[j]["ItemId"] as! String) == itemsarray[i] {
                itemsDataDict[j]["Index"] = i
                break
            } else {
                
                }
            }
        }
        
        itemsDataDict.sortInPlace {
            item1, item2 in
            let date1 = item1["Index"] as! Int
            let date2 = item2["Index"] as! Int
            return date1 < date2
        }
        
        
     
        
        //println("dict \(dictionary)")
      //  print("array of dicts \(itemsDataDict)")
      //  print("COUNT IS ___________\(itemsDataDict.count)")
        
        self.sortcategories(itemsDataDict)
        /*
        if itemsDataDict.count == 0 {
            noitemview.hidden = false
        } else {
            noitemview.hidden = true
        }
        */
        
        //// new stuff
        self.shoppingListItemsIds.removeAll(keepCapacity: true)
        self.shoppingListItemsNames.removeAll(keepCapacity: true)
        self.shoppingListItemsNotes.removeAll(keepCapacity: true)
        self.shoppingListItemsQuantity.removeAll(keepCapacity: true)
        // self.shoppingListItemsImages.removeAll(keepCapacity: true)
        self.shoppingListItemsPrices.removeAll(keepCapacity: true)
        self.shoppingListItemsUnits.removeAll(keepCapacity: true)
        self.shoppingListItemsImagesPaths.removeAll(keepCapacity: true)
        self.shoppingListItemsImages2.removeAll(keepCapacity: true)
        self.shoppingListItemsIsChecked.removeAll(keepCapacity: true)
        self.shoppingListItemsCategories.removeAll(keepCapacity: true)
        self.shoppingListItemsCategoriesNames.removeAll(keepCapacity: true)
        self.shoppingListItemsIsCatalog.removeAll(keepCapacity: true)
        self.shoppingListOneUnitPrice.removeAll(keepCapacity: true)
        self.shoppingListItemsIsFav.removeAll(keepCapacity: true)
        self.shoppingListItemsPerUnit.removeAll(keepCapacity: true)
        self.shoppingListItemsCreation.removeAll(keepCapacity: true)
        self.shoppingListItemsUpdate.removeAll(keepCapacity: true)
        self.shoppingListItemsOriginal.removeAll(keepCapacity: true)
        self.shoppingListItemsIsDefPict.removeAll(keepCapacity: true)
        self.shoppingListItemsDefaultOriginal.removeAll(keepCapacity: true)
        
        self.checked.removeAll(keepCapacity: true) //getting this array not from parse
        
        
        
        
        ////
        
        summationPrices()
        summationcheckedPrices()
        countitems()
        countchecked()
        itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
        showprogress()
    }
    
    
    
    func retrievalfromdictionary() {
        
    }
    
    
    func addMultipleFunc(){
        
        performSegueWithIdentifier("AddItemWithOptions", sender: self)
        
    }
    
    
    func addBarButtonTapped(){
        //performSegueWithIdentifier("AddItemToTheList", sender: self)
        // performSegueWithIdentifier("AddItemWithOptions", sender: self)
        performSegueWithIdentifier("additemmodalsegue", sender: self)
        
    }
    
    func listsBarButtonTapped() {
        performSegueWithIdentifier("ShowAllLists2", sender: self)
        // won't work until segue created in storyboard also
        //link: http://stackoverflow.com/questions/26456989/how-do-i-create-a-segue-that-can-be-called-from-a-button-that-is-created-program
    }
    
    @IBAction func NewItemButtonTapped(sender: AnyObject) {
        addBarButtonTapped()
    }
    
    
    
    @IBAction func AddMultipleItems(sender: AnyObject) {
        addMultipleFunc()
    }
    
    
    func countchecked() -> Int {
        
        var quantityofchecked = [Bool]()
        
        for item in itemsDataDict {
            if item["ItemIsChecked"] as! Bool == true {
                quantityofchecked.append(item["ItemIsChecked"] as! Bool)
                
            } else {
                print("Not checked")
            }
        }
        checkeditemsqty = quantityofchecked.count
        return checkeditemsqty
    }
    

    
    func countitems() -> Int {
        //itemsoverallqty = shoppingListItemsIds.count
        itemsoverallqty = itemsDataDict.count
        return itemsoverallqty
    }

    
    
    @IBAction func unwindToCreationOfShopList(sender: UIStoryboardSegue){
        // bug? exit segue doesn't dismiss so we do it manually...
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    
    
    
    
    func containslistid(values: [String], element: String) -> Bool {
        // Loop over all values in the array.
        for value in values {
            // If a value equals the argument, return true.
            if value == element {
                return true
            }
        }
        // The element was not found.
        return false
    }
    
    func containseventid(values: [String], element: String) -> Bool {
        
        for value in values {
            
            if value == element {
                return true
            }
        }
        // The element was not found.
        return false
    }
    
    
    func reloadTableAfterPush() {
        
        
       // let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
       // dispatch_async(dispatch_get_global_queue(priority, 0)) {
        
        
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
        
      // checkreceivedlists
        var receivedcount : Int = 0
        
        //CHECK SHOP LISTS
        var query = PFQuery(className:"shopLists")
        query.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        query.whereKey("isReceived", equalTo: true)
        query.whereKey("isSaved", equalTo: false)
        query.whereKey("isDeleted", equalTo: false)
        query.whereKey("confirmReception", equalTo: false)
        query.orderByDescending("updateDate")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                
                
                if let lists = objects as? [PFObject] {
                    
                    for object in lists {
                        print(object.objectId)
                        if self.containslistid(UserLists.map({ $0.listid }), element: object["listUUID"] as! String) || self.containslistid(UserShopLists.map({ $0.listid }), element: object["listUUID"] as! String){
                            
                            print("object is already retrieved from local datastore")
                        } else {
                            
                            var listid = object["listUUID"] as! String
                            var listname = object["ShopListName"] as! String
                            var listnote = object["ShopListNote"] as! String
                            var listcreationdate = object["updateDate"] as! NSDate
                            var listisfav = object["isFavourite"] as! Bool
                            var listisreceived = object["isReceived"] as! Bool
                            var listbelongsto = object["BelongsToUser"] as! String
                            var listissentfrom = object["sentFromArray"] as! [(String)]
                            var listissaved = object["isSaved"] as! Bool
                            
                            var listconfirm = object["confirmReception"] as! Bool
                            var listisdeleted = object["isDeleted"] as! Bool
                            var listisshared = object["isShared"] as! Bool
                            var listsharewitharray = object["ShareWithArray"] as! [[AnyObject]]
                            
                            var listitemscount = object["ItemsCount"] as! Int
                            var listcheckeditems = object["CheckedItemsCount"] as! Int
                            var listtype = "Shop"
                            var listcurrency = object["ListCurrency"] as! String
                            var listshowcats = object["ShowCats"] as! Bool
                            var listscolor = object["ListColorCode"] as! String
                            
                            
                            var receivedshoplist : UserList = UserList(
                                listid:listid,
                                listname:listname,
                                listnote:listnote,
                                listcreationdate:listcreationdate,
                                listisfavourite:listisfav,
                                listisreceived:listisreceived,
                                listbelongsto:listbelongsto,
                                listreceivedfrom:listissentfrom,
                                listissaved:listissaved,
                                listconfirmreception:listconfirm,
                                listisdeleted:listisdeleted,
                                listisshared:listisshared,
                                listsharedwith:listsharewitharray,
                                listitemscount:listitemscount,
                                listcheckeditemscount:listcheckeditems,
                                listtype:listtype,
                                listcurrency:listcurrency,
                                listcategories:listshowcats,
                                listcolorcode:listscolor
                                
                            )
                            
                            UserShopLists.append(receivedshoplist)
                            
                            //UserLists.extend(UserShopLists)
                            UserLists.append(receivedshoplist)
                            
                            
                            //self.tableView.reloadData() // without this thing, table would contain only 1 row
                            
                            receivedcount += 1
                            
                        }
                        
                        //receivedcount += 1
                        
                        //object.pinInBackground()
                        //I think I do it later when saving
                    }
                    
                    //self.tableView.reloadData()
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
        
        //CHECK TODO LISTS
        var querytodo = PFQuery(className:"toDoLists")
        querytodo.whereKey("BelongsToUser", equalTo: PFUser.currentUser()!.objectId!)
        querytodo.whereKey("isReceived", equalTo: true)
        querytodo.whereKey("isSaved", equalTo: false)
        querytodo.whereKey("isDeleted", equalTo: false)
        querytodo.whereKey("confirmReception", equalTo: false)
        querytodo.orderByDescending("updateDate")
        querytodo.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                print("Successfully retrieved \(objects!.count) scores.")
                
                
                if let lists = objects as? [PFObject] {
                    
                    for object in lists {
                        print(object.objectId)
                        
                        if self.containslistid(UserLists.map({ $0.listid }), element: object["listUUID"] as! String) || self.containslistid(UserToDoLists.map({ $0.listid }), element: object["listUUID"] as! String){
                            
                            print("object is already retrieved from local datastore")
                        } else {
                            
                            var listid = object["listUUID"] as! String
                            var listname = object["ToDoListName"] as! String
                            var listnote = object["ToDoListNote"] as! String
                            var listcreationdate = object["updateDate"] as! NSDate
                            var listisfav = object["isFavourite"] as! Bool
                            var listisreceived = object["isReceived"] as! Bool
                            var listbelongsto = object["BelongsToUser"] as! String
                            var listissentfrom = object["SentFromArray"] as! [(String)]
                            var listissaved = object["isSaved"] as! Bool
                            
                            var listconfirm = object["confirmReception"] as! Bool
                            var listisdeleted = object["isDeleted"] as! Bool
                            var listisshared = object["isShared"] as! Bool
                            var listsharewitharray = object["ShareWithArray"] as! [[AnyObject]]
                            
                            var listitemscount = object["ItemsCount"] as! Int
                            var listcheckeditems = object["CheckedItemsCount"] as! Int
                            var listtype = "ToDo"
                            var listscolor = object["ListColorCode"] as! String
                            // var listcurrency = object["ListCurrency"] as! String
                            // var listshowcats = object["ShowCats"] as! Bool
                            
                            
                            var receivedtodolist : UserList = UserList(
                                listid:listid,
                                listname:listname,
                                listnote:listnote,
                                listcreationdate:listcreationdate,
                                listisfavourite:listisfav,
                                listisreceived:listisreceived,
                                listbelongsto:listbelongsto,
                                listreceivedfrom:listissentfrom,
                                listissaved:listissaved,
                                listconfirmreception:listconfirm,
                                listisdeleted:listisdeleted,
                                listisshared:listisshared,
                                listsharedwith:listsharewitharray,
                                listitemscount:listitemscount,
                                listcheckeditemscount:listcheckeditems,
                                listtype:listtype,
                                listcolorcode:listscolor
                                
                            )
                            
                            UserToDoLists.append(receivedtodolist)
                            UserLists.append(receivedtodolist)
                            
                            
                            // self.tableView.reloadData() // without this thing, table would contain only 1 row
                            
                            receivedcount += 1
                            
                        }
                    }
                    
                    // self.tableView.reloadData()
                    
                    if receivedcount != 0 {
                        
                        // self.displayAlert("Incoming lists!", message: "You have received \(String(receivedcount)) lists")
                        
                        //JSSAlertView().show(self, title: "You have received \(String(receivedcount)) lists")
                    }
                    //self.displayAlert("Incoming lists!", message: "You have received lists")
                    
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
        
        // checkreceivedevents
        var queryevents = PFQuery(className:"UsersEvents")
        
        queryevents.whereKey("ReceiverId", equalTo: PFUser.currentUser()!.objectId!)
        queryevents.whereKey("isReceived", equalTo: false)
        queryevents.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                //userevents.removeAll(keepCapacity: true)
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                
                //receivedeventscount = objects!.count
                
                if let listitems = objects as? [PFObject] {
                    for object in listitems {
                        
                        var etype = object["EventType"] as! String
                        
                        if etype == "GoShop" {
                            
                            var enote = object["EventText"] as! String
                            var edate = object.createdAt //["createdAt"] as! NSDate
                            var euser = object["senderInfo"] as! [AnyObject]
                            var erecuser = object["receiverInfo"] as! [AnyObject]
                            var eid = object["eventUUID"] as! String
                            
                            if !self.containseventid(blacklistarray, element: euser[0] as! String) {
                                
                                if !self.containseventid(userevents.map({ $0.eventid! }), element: eid) {
                                    
                                    userevents.append(Event(eventtype: etype, eventnote: enote, eventdate: edate!, eventuser: euser, eventreceiver: erecuser, eventid: eid))
                                    
                                    
                                    
                                    object["isReceived"] = true
                                    
                                    receivedeventscount += 1
                                    
                                    
                                    object.pinInBackgroundWithBlock({ (success, error) -> Void in
                                        if success {
                                            //self.restore()
                                            print("saved item")
                                            object["isReceived"] = true
                                            object.saveEventually()
                                            
                                        } else {
                                            print("no id found")
                                        }
                                    })
                                    
                                } else {
                                    print("Such event is already loaded")
                                }
                            } else {
                                print("This sender id is blocked")
                            }
                            
                        } else if etype == "AddContact" {
                            
                            var enote = object["EventText"] as! String
                            var edate = object.createdAt//object["createdAt"] as! NSDate
                            var euser = object["senderInfo"] as! [AnyObject]
                            var erecuser = object["receiverInfo"] as! [AnyObject]
                            
                            var eid = object["eventUUID"] as! String
                            
                            var senderavatarfile = object["senderavatar"] as? PFFile
                            
                            var senderimage = UIImage()
                            
                            if senderavatarfile != nil {
                                var imageData = senderavatarfile!.getData()
                                if (imageData != nil) {
                                    var image = UIImage(data: imageData!)
                                    senderimage = image!
                                } else {
                                    senderimage = defaultcatimages[1].itemimage//UIImage(named: "checkeduser.png")!
                                }
                            } else {
                                senderimage = defaultcatimages[1].itemimage//UIImage(named: "checkeduser.png")!
                            }
                            
                            
                            if !self.containseventid(blacklistarray, element: euser[0] as! String) {
                                
                                if !self.containseventid(userevents.map({ $0.eventid! }), element: eid) {
                                    
                                    userevents.append(Event(eventtype: etype, eventnote: enote, eventdate: edate!, eventuser: euser, eventreceiver: erecuser, eventid: eid, eventreceiverimage: senderimage))
                                    
                                    object["isReceived"] = true
                                    
                                    receivedeventscount += 1
                                    
                                    
                                    object.pinInBackgroundWithBlock({ (success, error) -> Void in
                                        if success {
                                            //self.restore()
                                            print("saved item")
                                            object["isReceived"] = true
                                            object.saveEventually()
                                            
                                        } else {
                                            print("no id found")
                                        }
                                    })
                                    
                                    
                                    
                                } else {
                                    print("Such event is already loaded")
                                }
                                
                            } else {
                                print("This sender id is blocked!")
                            }
                            
                        }
                        
                    }
                    userevents.sortInPlace({ $0.eventdate.compare($1.eventdate) == NSComparisonResult.OrderedDescending })
                  
                    
                    
                }
                
                //self.addcustomstocatalogitems(customcatalogitems)
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }) // end of dispatch
    }
    
    
    @IBOutlet var newquickview: UIView!
    
    var poppresented : Bool = false
    
    
    override func viewDidLayoutSubviews() {
        
        //newquickview.frame.height.constant = 0
        super.viewDidLayoutSubviews()
 
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //self.smallpopover.frame.origin.y = self.view.frame.origin.y - 300
      //  self.smallpopover.frame.origin.y = self.view.frame.origin.y - 300
       // sortchecked(itemsDataDict)
    }
    
    
    @IBOutlet var quicksmallconstraint: NSLayoutConstraint!
    
    @IBOutlet var newquantitybutton: UIButton!
    let blackquantity: UIImage = UIImage(named:"OpenQuantityB")!
    
    let redquantity: UIImage = UIImage(named:"CloseQuantityB")!
    
    
    func showproperties() {
        
        //autocomplete.resignFirstResponder() // self.view.endEditing(true) - might be better
        //self.view.endEditing(true)
        smallpopover.hidden = false
        dimmerforpopover.hidden = false
        
        opencatalogoutlet.hidden = true
        newquantitybutton.hidden = true
        quickaddoutlet.hidden = false
        
        var pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale");
        pulseAnimation.duration = 1.0;
        pulseAnimation.fromValue = NSNumber(float: 0.9)
        pulseAnimation.toValue = NSNumber(float: 1.0);
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        pulseAnimation.autoreverses = true;
        pulseAnimation.repeatCount = FLT_MAX;
        quickaddoutlet.layer.addAnimation(pulseAnimation, forKey: nil)
        
    }
    
    func hideproperties() {
        
        //autocomplete.resignFirstResponder()
        self.view.endEditing(true)
        smallpopover.hidden = true
        dimmerforpopover.hidden = true
        
        opencatalogoutlet.hidden = false
        newquantitybutton.hidden = true
        quickaddoutlet.hidden = true
        
       // isdefaultpicture = true
       // defaultpicturename = imagestochoose[0].imagename
       // quickicon.image = imagestochoose[0].itemimage
        
        
        quickaddoutlet.layer.removeAllAnimations()
    }
    
    
    func slidepopover() {
        //
        
        
       // newquantitybutton.hidden = true
        // small workaround due to a bug
        if newquantitybutton.tintColor == UIColorFromRGB(0x979797) {
            poppresented = false
        }
        
        
        if poppresented == false {
            
            
            poppresented = true
            
            autocomplete.resignFirstResponder()
            
            newquantitybutton.tintColor = UIColorFromRGB(0xA2AF36)
            
            smallpopover.hidden = false
            
            dimmerforpopover.hidden = false
            
            
        } else {
            
            poppresented = false
            
            newquantitybutton.tintColor = UIColorFromRGB(0x979797)
            
            dimmerforpopover.hidden = true
            
            self.smallpopover.hidden = true
            
            getinfofrompop(quickunit, quantity: popqty.text!, perunit: quickperunit, price: quickpriceoutlet.text!, totalsum: quicksum.text!, icon: quickcategory.catimage, category: quickcategory, catUUID: quickcategoryUUID)
            
            
        }
        
        
        var pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale");
        pulseAnimation.duration = 1.0;
        pulseAnimation.fromValue = NSNumber(float: 0.9)
        pulseAnimation.toValue = NSNumber(float: 1.0);
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        pulseAnimation.autoreverses = true;
        pulseAnimation.repeatCount = FLT_MAX;
        quickaddoutlet.layer.addAnimation(pulseAnimation, forKey: nil)
    }
    
    
    @IBAction func slidesmallpopover(sender: AnyObject) {
        //
      //  slidepopover()
        self.view.endEditing(true)
        showproperties()
        
        /*
        // small workaround due to a bug
        if newquantitybutton.tintColor == UIColorFromRGB(0x979797) {
            poppresented = false
        }
        
        
        if poppresented == false {
        
            
        poppresented = true
            
            autocomplete.resignFirstResponder()

            newquantitybutton.tintColor = UIColorFromRGB(0xA2AF36)
            
            smallpopover.hidden = false
            
            dimmerforpopover.hidden = false
            

        } else {
            
            poppresented = false
            
            newquantitybutton.tintColor = UIColorFromRGB(0x979797)
            
            dimmerforpopover.hidden = true
          
            self.smallpopover.hidden = true
            
             getinfofrompop(quickunit, quantity: popqty.text!, perunit: quickperunit, price: quickpriceoutlet.text!, totalsum: quicksum.text!, icon: quickcategory.catimage, category: quickcategory, catUUID: quickcategoryUUID)

            
        }
        
        
        var pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale");
        pulseAnimation.duration = 1.0;
        pulseAnimation.fromValue = NSNumber(float: 0.8)
        pulseAnimation.toValue = NSNumber(float: 1.0);
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut);
        pulseAnimation.autoreverses = true;
        pulseAnimation.repeatCount = FLT_MAX;
        quickaddoutlet.layer.addAnimation(pulseAnimation, forKey: nil)
        */
    }
    
    
    
    @IBOutlet var smallpopover: UIView!
    
    @IBOutlet var inamountview: UIView! //44
    
    @IBOutlet var inunitsfield: UILabel!
    //44
    
//139
    
    @IBOutlet var capt1: UILabel! //21
    
    @IBOutlet var capt2: UILabel!
    
    
    @IBOutlet var capt3: UILabel!
    
    
    // MARK: small popover part
    
    
    @IBOutlet var lightbgview: UIView!
    
    var buttontitle = String()
    
    var doublenumber = Double()
    
    var pricevalue = Double()
    
    func closenumberpad(sender: UIButton) {
        popqty.resignFirstResponder()
    }
    
    func closenumberpad2(sender: UIButton) {
        quickpriceoutlet.resignFirstResponder()
    }
    
    func closenumberpad5(sender: UIButton) {
        quicksum.resignFirstResponder()
    }
    
    
    func addproductfromkeyboard(sender: UIButton) {
        quickpriceoutlet.resignFirstResponder()
        
        if (catalogitemtochoose != nil) {
            
            quickaddcatalogitem(catalogitemtochoose!)
            
        } else {
            
            quicknoncatalogitem()
        }

        
    }
    
    func editproductfromkeyboard(sender: UIButton) {
       // quickpriceoutlet.resignFirstResponder()
        self.view.endEditing(true)
       showproperties()
        
       
    }
    
    var closepadimage = UIImage(named: "ClosePad")!
    var editproductimage = UIImage(named:"4EditProduct20")!
    var addproductimage = UIImage(named:"4AddProduct20")!
    /*
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage {
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    */
   // var addproductimage
    
    
    @IBAction func decrement(sender: AnyObject) {
        
        var getvalue: Double {

            get {return popqty.text!.doubleConverter}
        }
        
        doublenumber = getvalue
        
        doublenumber -= 1
        
        var formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 4
        formatter.usesSignificantDigits = false
        formatter.minimumSignificantDigits = 1
        formatter.maximumSignificantDigits = 9
        
        popqty.text = formatter.stringFromNumber(doublenumber)
        
        multiplication()
    }
    
    
    @IBAction func increment(sender: AnyObject) {
        
        var getvalue: Double {

            get {return popqty.text!.doubleConverter}
        }
        
        doublenumber = getvalue
        
        doublenumber += 1
        
        var formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 4
        formatter.usesSignificantDigits = false
        formatter.minimumSignificantDigits = 1
        formatter.maximumSignificantDigits = 9
        
        popqty.text = formatter.stringFromNumber(doublenumber)
    
        
        multiplication()
    }
    
    
    @IBOutlet var popqty: UITextField!
    
    
    


    
    @IBAction func dismisssmallpopup(sender: AnyObject) {
        
        
         getinfofrompop(quickunit, quantity: popqty.text!, perunit: quickperunit, price: quickpriceoutlet.text!, totalsum: quicksum.text!, icon: quickcategory.catimage, category: quickcategory, catUUID: quickcategoryUUID)
        
        poppresented = false
        
        newquantitybutton.hidden = false
        
        newquantitybutton.tintColor = UIColorFromRGB(0x979797)
        
        dimmerforpopover.hidden = true
        
        self.smallpopover.hidden = true
        /*
             self.quicksmallconstraint.constant = -610

            UIView.animateWithDuration(0.4, animations: { () -> Void in

                self.view.layoutIfNeeded()
                
                }, completion: { (value: Bool) -> Void in
  
                    self.smallpopover.hidden = true
            })
*/
    }
    
    
    @IBOutlet var smalltopview: UIView!
    
    
    @IBOutlet var opencatalogoutlet: UIButton!
    
    
    @IBAction func opencatalog(sender: AnyObject) {
        
        performSegueWithIdentifier("NewAddItemWithOptions", sender: self)
    }
    
    
    @IBOutlet var shownoteview: UIView!
    
    
    @IBOutlet var listnameinview: CustomTextField!
    
    
    @IBOutlet var listnoteinview: UITextView!
    
    

    
    
    @IBAction func cancelview(sender: AnyObject) {
        
        dimmer.removeFromSuperview()
        
        notetopconstraint.constant = -300
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                
        })
        
        self.view.endEditing(true)
        
        self.shownoteview.hidden = true

        
    }
    
    var starteditname : Bool = false
    
    
   
    @IBAction func endeditlistname(sender: AnyObject) {
        
        
        
        let query = PFQuery(className:"shopLists")
        query.fromLocalDatastore()
        query.whereKey("listUUID", equalTo: currentList)
        query.getFirstObjectInBackgroundWithBlock() {
            (list: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let list = list {
                list["ShopListName"] = self.listnameinview.text
                list.pinInBackground()

                if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(self.currentList) {
                    UserLists[foundlist].listname = self.listnameinview.text
                   
                    
                }
                if let foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(self.currentList) {
                    UserShopLists[foundshoplist].listname = self.listnameinview.text
                   
                    
                }
                if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(self.currentList) {
                    UserFavLists[foundfavlist].listname = self.listnameinview.text
                    
                }

                self.view.endEditing(true)
  
            }
        }
        
        self.navigationItem.title = self.listnameinview.text
    
        /*
        navbutton.setTitle(self.listnameinview.text, forState: UIControlState.Normal)
        
        let spacing : CGFloat = 3;
        let insetAmount : CGFloat = 0.5 * spacing;
        
        navbutton.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);
        navbutton.sizeToFit()
        

        navbutton.titleEdgeInsets  = UIEdgeInsetsMake(0, -navbutton.imageView!.frame.size.width - insetAmount, 0,  navbutton.imageView!.frame.size.width  + insetAmount);
        navbutton.imageEdgeInsets  = UIEdgeInsetsMake(2, navbutton.titleLabel!.frame.size.width + insetAmount, 0, -navbutton.titleLabel!.frame.size.width - insetAmount);
        */
    }
    
    
    
   
    @IBAction func doneinview(sender: AnyObject) {
        
        let query = PFQuery(className:"shopLists")
        query.fromLocalDatastore()
        query.whereKey("listUUID", equalTo: currentList)
        query.getFirstObjectInBackgroundWithBlock() {
            (list: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
                
                self.dimmer.removeFromSuperview()
                
                self.notetopconstraint.constant = -300
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    
                    self.view.layoutIfNeeded()
                    }, completion: { (value: Bool) -> Void in
                        
                })
                self.shownoteview.hidden = true
               
            } else if let list = list {
                
                self.self.listnameinview.text = self.listnameinview.text
                
                list["ShopListName"] = self.listnameinview.text
                list["ShopListNote"] = self.listnoteinview.text
                list.pinInBackground()
                // list.saveEventually()
                
                
                if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(self.currentList) {
                    UserLists[foundlist].listname = self.listnameinview.text
                    UserLists[foundlist].listnote = self.listnoteinview.text
                    
                }
                
                if let foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(self.currentList) {
                    UserShopLists[foundshoplist].listname = self.listnameinview.text
                    UserShopLists[foundshoplist].listnote = self.listnoteinview.text
                    
                }
                
                if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(self.currentList) {
                    UserFavLists[foundfavlist].listname = self.listnameinview.text
                    UserFavLists[foundfavlist].listnote = self.listnoteinview.text
                    
                }
                
                self.dimmer.removeFromSuperview()
                
                self.notetopconstraint.constant = -300
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    
                    self.view.layoutIfNeeded()
                    }, completion: { (value: Bool) -> Void in
                  
                
                })
                
                self.view.endEditing(true)
                
                self.shownoteview.hidden = true

                
            }
        }
       
        
       
        
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        //shiftview(true)
        if textView == quickdescription {
            shiftview(true)
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        //shiftview(false)
        
        
        let query = PFQuery(className:"shopLists")
        query.fromLocalDatastore()
        query.whereKey("listUUID", equalTo: currentList)
        query.getFirstObjectInBackgroundWithBlock() {
            (list: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let list = list {
                list["ShopListName"] = self.listnoteinview.text
                list.pinInBackground()
                
                if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(self.currentList) {
                    
                    UserLists[foundlist].listnote = self.listnoteinview.text
                    
                }
                if let foundshoplist = UserShopLists.map({ $0.listid }).lazy.indexOf(self.currentList) {
                    
                    UserShopLists[foundshoplist].listnote = self.listnoteinview.text
                    
                }
                if let foundfavlist = UserFavLists.map({ $0.listid }).lazy.indexOf(self.currentList) {
                    
                    UserFavLists[foundfavlist].listnote = self.listnoteinview.text
                    
                }
                
                self.view.endEditing(true)
                
            }
        }
        
        
        navbutton.setTitle(self.listnameinview.text, forState: UIControlState.Normal)
        
        
        if textView == quickdescription {
            shiftview(false)
        }
        
    }
    
    
    
    @IBOutlet var notetopconstraint: NSLayoutConstraint!
    
    func shiftview(up: Bool) {
        
        if up == true {
            
            quicksmallconstraint.constant = -200
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                
                self.view.layoutIfNeeded()
                }, completion: { (value: Bool) -> Void in
                    
            })
            // self.view.frame.origin.y -= 200
            
        } else if up == false {
            
           quicksmallconstraint.constant = -1
            
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                
                self.view.layoutIfNeeded()
                }, completion: { (value: Bool) -> Void in
                    
            })
        }
    }

    
    func didSwipeCell(recognizer: UIGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.Ended {
            let swipeLocation = recognizer.locationInView(self.tableView)
            if let swipedIndexPath = tableView.indexPathForRowAtPoint(swipeLocation) {
                if let swipedCell = self.tableView.cellForRowAtIndexPath(swipedIndexPath) {
    
                    ////// DO STUFF
                    

                    
                    if showcats == false {
                        

                        let cell = swipedCell as! ItemShopListCell
                        
                        let indexPathCheck = swipedIndexPath
                        
                        
                        // itemtocheck = shoppingListItemsIds[indexPathCheck!.row]
                        itemtocheck = itemsDataDict[indexPathCheck.row]["ItemId"] as! String
                        
                        
                        // shoppingListItemsIsChecked[indexPathCheck!.row] = true
                        
                        itemsDataDict[indexPathCheck.row]["ItemIsChecked"] = true
                        // AND HERE It is possible to directly change the value! WTF?!
                        
                        // var thissectionsname : String = shoppingListItemsCategoriesNames[indexPathCheck!.row]
                        let thissectionsname : String = itemsDataDict[indexPathCheck.row]["ItemCategoryName"] as! String
                        // print(thissectionsname)
                        
                        
                        // var thisarray : Array<Dictionary<String,AnyObject>> = sections[thissectionsname]!
                        //this array is just to help me understand what's what
                        //  println("Array of this section is \(thisarray)")
                        
                        //for ( var i = 0; i < thisarray.count; i++ ) {
                        for ( var i = 0; i < sections[thissectionsname]!.count; i++ ) {
                            
                            
                            //if thisarray[i]["ItemId"] as? String == itemtocheck {
                            if sections[thissectionsname]![i]["ItemId"] as? String == itemtocheck {
                                
                                
                                //print(sections[thissectionsname]![i]["ItemId"])
                                // print(sections[thissectionsname]![i]["ItemIsChecked"])
                                
                                sections[thissectionsname]![i]["ItemIsChecked"] = true
                                
                                // print(sections[thissectionsname]![i]["ItemId"])
                                // print(sections[thissectionsname]![i]["ItemIsChecked"])
                                
                            }
                        }
                        
                        
                        
                        // if itemsDataDict[indexPathCheck!.row]["ItemIsChecked"] as! Bool == false {
                        
                        cell.checkedButtonOutlet.setImage(checkedImage, forState: .Normal)
                        

                        
                        cell.checkedview.hidden = false
                        
                        //new stuf
                        //cell.contentView.alpha = 0.6
                        
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()

                        
                        
                        let attributes = [NSStrikethroughStyleAttributeName : 1]
                        // var title = NSAttributedString(string: shoppingListItemsNames[indexPathCheck!.row], attributes: attributes)
                        let title = NSAttributedString(string: itemsDataDict[indexPathCheck.row]["ItemName"] as! String, attributes: attributes)
                        cell.itemName.attributedText = title
                        
                        let querynew = PFQuery(className:"shopItems")
                        querynew.fromLocalDatastore()
                        // querynew.getObjectInBackgroundWithId(itemtocheck) {
                        querynew.whereKey("itemUUID", equalTo: itemtocheck)
                        querynew.getFirstObjectInBackgroundWithBlock() {
                            (itemList: PFObject?, error: NSError?) -> Void in
                            if error != nil {
                                print(error)
                            } else if let itemList = itemList {
                                itemList["isChecked"] = true
                                itemList.pinInBackground()
                                // itemList.saveInBackground()
                                // itemList.saveEventually()
                                
                            }
                            
                            
                        }
                        
                        
                        checkeditemsqty += 1
                        //itemschecked.text = String(checkeditemsqty)
                        countitems()
                        
                        itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
                        
                showprogress()
                        
                    } else {
                        
                        let cell = swipedCell as! ItemShopListCell
                        
                            let section = swipedIndexPath.section
                            let rowsect = swipedIndexPath.row
                            
                            //var tableSection : [Dictionary<String, AnyObject>] = []
                            var tableSection = sections[sortedSections[section]]
                            var tableItem = tableSection![rowsect]
                            
    
                            
                            var checkedbitch = Bool()
                            
                            //itemtocheck = shoppingListItemsIds[indexPathCheck!.row]
                            
                            itemtocheck = (tableItem as NSDictionary).objectForKey("ItemId") as! String
    
                            
                            print(tableItem["ItemIsChecked"])
                            
                            //tableItem.updateValue(true, forKey: "ItemChecked")
                            tableItem.updateValue(true, forKey: "ItemIsChecked")
                            tableSection![rowsect] = tableItem
                            sections[sortedSections[section]] = tableSection
                            
                            for ( var i = 0; i < itemsDataDict.count; i++ ) {
                                if itemsDataDict[i]["ItemId"] as? String == itemtocheck {
                                    //var newdict = Dictionary<String, AnyObject>()//NSDictionary()
                                    var index = i
                                    //newdict = itemsDataDict[i]
                                    // newdict.updateValue(true, forKey: "ItemChecked")
                                    
                                    // shoppingListItemsIsChecked[index] = true
                                    
                                    print(itemsDataDict[i])
                                    
                                    itemsDataDict[i]["ItemIsChecked"] = true
                                    
                                    print(itemsDataDict[i])
                                    
                                }
                            }
                            
                            
                            cell.checkedButtonOutlet.setImage(checkedImage, forState: .Normal)
                            
 
                            
                            cell.checkedview.hidden = false
                            
                            self.activityIndicator.stopAnimating()
                            UIApplication.sharedApplication().endIgnoringInteractionEvents()
                            
                            
                            let attributes = [NSStrikethroughStyleAttributeName : 1]
                            let title = NSAttributedString(string: (tableItem as NSDictionary).objectForKey("ItemName") as! String, attributes: attributes)
                            cell.itemName.attributedText = title
                            
                            let querynew = PFQuery(className:"shopItems")
                            querynew.fromLocalDatastore()
                            // querynew.getObjectInBackgroundWithId(itemtocheck) {
                            querynew.whereKey("itemUUID", equalTo: (tableItem as NSDictionary).objectForKey("ItemId") as! String)
                            querynew.getFirstObjectInBackgroundWithBlock() {
                                (itemList: PFObject?, error: NSError?) -> Void in
                                if error != nil {
                                    print(error)
                                } else if let itemList = itemList {
                                    itemList["isChecked"] = true
                                    itemList.pinInBackground()
                                    // itemList.saveInBackground()
                                    //  itemList.saveEventually()
                                    
                                }
                                
                                
                            }

                            checkeditemsqty += 1
                            countitems()
                            
                            itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
                            showprogress()
                        
                    }
                    
                    
                    //////
                    
                    
                    
                }
            }
        }
    }
    
    
    @IBOutlet var openmenu: UIBarButtonItem!
    
    // MARK: save list info execution
    override func viewWillDisappear(animated: Bool) {
        
         additemstolistsarrayandsave()
    }
    
    
    // new quick parts
    
    
    
    
    @IBOutlet var quickpriceoutlet: UITextField!

    @IBOutlet var quicksum: UITextField!
    
    @IBOutlet var quickcurrency: UILabel!
    @IBOutlet var categoryview: UIView!
    @IBOutlet var quickicon: UIImageView!

    @IBOutlet var nomatchlabel: UILabel!
    @IBOutlet var prodiconview: UIView!
    
    
    //SUM ACTIONS
    
    @IBAction func sumbegin(sender: AnyObject) {
        
        sumline.backgroundColor = UIColorFromRGB(0x31797D)
        quicksum.textColor = UIColorFromRGB(0x31797D)
        quicksum.textInputView.tintColor = UIColorFromRGB(0x31797D)
    }
    
    
    @IBAction func sumend(sender: AnyObject) {
        
        if quicksum.text! != "0" && quicksum.text! != "" {
            sumline.backgroundColor = UIColorFromRGB(0x31797D)
            quicksum.textColor = UIColorFromRGB(0x31797D)
            quicksum.textInputView.tintColor = UIColorFromRGB(0x31797D)
        } else {
            sumline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            quicksum.textColor = UIColorFromRGB(0xE0E0E0)
            quicksum.textInputView.tintColor = UIColorFromRGB(0xE0E0E0)
        }

    }
    
    
    @IBAction func sumeditchanged(sender: AnyObject) {
        
        if quicksum.text! != "0" && quicksum.text! != "" {
            sumline.backgroundColor = UIColorFromRGB(0x31797D)
            quicksum.textColor = UIColorFromRGB(0x31797D)
            quicksum.textInputView.tintColor = UIColorFromRGB(0x31797D)
        } else {
            sumline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            quicksum.textColor = UIColorFromRGB(0xE0E0E0)
            quicksum.textInputView.tintColor = UIColorFromRGB(0xE0E0E0)
        }

    }
    
    
    @IBAction func sumvaluechanged(sender: AnyObject) {
        
        if quicksum.text! != "0" && quicksum.text! != "" {
            sumline.backgroundColor = UIColorFromRGB(0x31797D)
            quicksum.textColor = UIColorFromRGB(0x31797D)
            quicksum.textInputView.tintColor = UIColorFromRGB(0x31797D)
        } else {
            sumline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            quicksum.textColor = UIColorFromRGB(0xE0E0E0)
            quicksum.textInputView.tintColor = UIColorFromRGB(0xE0E0E0)
        }
        

    }
    
    
    // PRICE ACTIONS
    @IBAction func priceendedit(sender: AnyObject) {
        
        if quickpriceoutlet.text! != "0" && quickpriceoutlet.text! != "" {
            priceline.backgroundColor = UIColorFromRGB(0x31793D)
            quickpriceoutlet.textInputView.tintColor = UIColorFromRGB(0x31797D)
            quickpriceoutlet.textColor = UIColorFromRGB(0x31797D)
        } else {
            priceline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            quickpriceoutlet.textInputView.tintColor = UIColorFromRGB(0xE0E0E0)
            quickpriceoutlet.textColor = UIColorFromRGB(0xE0E0E0)
        }

        
        quickpriceoutlet.text!.doubleConverter
        multiplication()
    }
    
    
    @IBAction func pricebeginedit(sender: AnyObject) {
        
        priceline.backgroundColor = UIColorFromRGB(0x31793D)
       quickpriceoutlet.textInputView.tintColor = UIColorFromRGB(0x31797D)
        
        quickpriceoutlet.text!.doubleConverter
        multiplication()
    }
    
    
    @IBAction func pricevaluechanged(sender: AnyObject) {
        
        if quickpriceoutlet.text! != "0" && quickpriceoutlet.text! != "" {
            priceline.backgroundColor = UIColorFromRGB(0x31793D)
            quickpriceoutlet.textInputView.tintColor = UIColorFromRGB(0x31797D)
            quickpriceoutlet.textColor = UIColorFromRGB(0x31797D)
        } else {
            priceline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            quickpriceoutlet.textInputView.tintColor = UIColorFromRGB(0xE0E0E0)
            quickpriceoutlet.textColor = UIColorFromRGB(0xE0E0E0)
        }

        
        
        quickpriceoutlet.text!.doubleConverter
        multiplication()
    }
    
    
    @IBAction func priceeditchanged(sender: AnyObject) {
        
        if quickpriceoutlet.text! != "0" && quickpriceoutlet.text! != "" {
            priceline.backgroundColor = UIColorFromRGB(0x31793D)
            quickpriceoutlet.textInputView.tintColor = UIColorFromRGB(0x31797D)
            quickpriceoutlet.textColor = UIColorFromRGB(0x31797D)
        } else {
            priceline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            quickpriceoutlet.textInputView.tintColor = UIColorFromRGB(0xE0E0E0)
            quickpriceoutlet.textColor = UIColorFromRGB(0xE0E0E0)
        }
        
        
        
        quickpriceoutlet.text!.doubleConverter
        multiplication()
        
        
    }
    
    // Quantity Field Actions
    
    @IBAction func qtyendedit(sender: AnyObject) {
        
        popqty.text!.doubleConverter
        
        if (popqty.text != nil) {

            doublenumber = popqty.text!.doubleConverter
        } else {
            print("no number")
        }
        
        
        multiplication()

    }
    
    
    @IBAction func qtyeditchanged(sender: AnyObject) {
        
        multiplication()
    }
    
   
    @IBAction func qtyvaluechanged(sender: AnyObject) {
        
        popqty.text!.doubleConverter
        
        if (popqty.text != nil) {

            doublenumber = popqty.text!.doubleConverter
        } else {
            print("no number")
        }
        
        
        multiplication()

        
    }
    
    
    
    // MULTIPLICATION
    
    var newvalue = Double()
    
    func multiplication(){

        var unit =  quickunit
        var perunit = quickperunit

        
        var getvalueofprice: Double {

            get {return quickpriceoutlet.text!.doubleConverter}
        }
        
        var getvalue: Double {

            get {return popqty.text!.doubleConverter}
        }
        
        doublenumber = getvalue
        
        pricevalue = getvalueofprice
        

        var formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 4
        formatter.usesSignificantDigits = false
        formatter.minimumSignificantDigits = 1
        formatter.maximumSignificantDigits = 9
        
        if unit == perunit {

            newvalue = doublenumber*pricevalue

            self.quicksum.text = formatter.stringFromNumber(newvalue)
            
            nomatchlabel.hidden = true
        } else if (unit != "") && perunit == "" {
            
            nomatchlabel.hidden = true
            newvalue = doublenumber*pricevalue
            
            self.quicksum.text = formatter.stringFromNumber(newvalue)
            
        } else {
            
            if unit == units[3][1] && perunit == units[4][1] {
                newvalue = (doublenumber)*1000*pricevalue
                self.quicksum.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[4][1] && perunit == units[3][1] {
                newvalue = (doublenumber)*0.001*pricevalue
                self.quicksum.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[5][1] && perunit == units[6][1] {
                newvalue = (doublenumber)*1000*pricevalue
                self.quicksum.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[6][1] && perunit == units[5][1] {
                newvalue = (doublenumber)*0.001*pricevalue
                self.quicksum.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[11][1] && perunit == units[12][1] {
                newvalue = (doublenumber)*1000*pricevalue
                self.quicksum.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[12][1] && perunit == units[11][1] {
                newvalue = (doublenumber)*0.001*pricevalue
                self.quicksum.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[9][1] && perunit == units[8][1] {
                newvalue = (doublenumber)*16.000*pricevalue
                self.quicksum.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[8][1] && perunit == units[9][1] {
                newvalue = (doublenumber)*0.062*pricevalue
                self.quicksum.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[9][1] && perunit == units[3][1] {
                newvalue = (doublenumber)*0.453*pricevalue
                self.quicksum.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[3][1] && perunit == units[9][1] {
                newvalue = (doublenumber)*2.204*pricevalue
                self.quicksum.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[5][1] && perunit == units[7][1] {
                newvalue = (doublenumber)*33.814*pricevalue
                self.quicksum.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else if unit == units[7][1] && perunit == units[5][1] {
                newvalue = (doublenumber)*0.029*pricevalue
                self.quicksum.text = formatter.stringFromNumber(newvalue)
                nomatchlabel.hidden = true
            } else {
                //case when no match
                nomatchlabel.hidden = false
                nomatchlabel.text = NSLocalizedString("dontmatch", comment: "")
            }

            
        }
        
        if quicksum.text! != "0" && quicksum.text! != "" {
            sumline.backgroundColor = UIColorFromRGB(0x31797D)
            quicksum.textColor = UIColorFromRGB(0x31797D)
        } else {
            sumline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            quicksum.textColor = UIColorFromRGB(0xE0E0E0)
        }

        /// other case
        
    }
    
    /*
    func resetunitsback(scroller: ASHorizontalScrollView) {
        
        for button in scroller.subviews {
            
            if let tappedbutton = button as? UIButton {
                if tappedbutton.titleForState(.Normal) == "" {
                    tappedbutton.backgroundColor = UIColorFromRGB(0x31797D)
                    tappedbutton.tintColor = UIColorFromRGB(0xFAFAFA)
                    tappedbutton.setTitleColor(UIColorFromRGB(0xFAFAFA), forState: UIControlState.Normal)
                    tappedbutton.layer.borderWidth = 1
                    tappedbutton.layer.borderColor = UIColorFromRGB(0x31797D).CGColor
                } else {
                    tappedbutton.backgroundColor = UIColor.clearColor()
                    tappedbutton.tintColor = UIColorFromRGB(0x31797D)
                    tappedbutton.setTitleColor(UIColorFromRGB(0x31797D), forState: UIControlState.Normal)
                    tappedbutton.layer.borderWidth = 1
                    tappedbutton.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
                }
            }
        }
        
    }
    */
    
    @IBOutlet var picker: UIPickerView!
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns number of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return units.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        return units[row][0]//[1]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if currenttype == "unit" {
            
            chosenunit = units[row][1]
            // chosenperunit = units[row][1]
            
            
        } else if currenttype == "perunit" {
            
            chosenperunit = units[row][1]
        }
        
    }
    
    func showunitsview(buttontype: String) {
        
        
        if buttontype == "unit" {
            
            currenttype = "unit"
            
            
        } else if buttontype == "perunit" {
            
            currenttype = "perunit"
            
        }
        
        unitsview.hidden = false
        
        unitviewbottomconstraint.constant = 2
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                
        })
        
        
        
    }

    func saveUnit(){
        
        if currenttype == "unit" {
            if (chosenunit != "") && (perunitsbutton.titleForState(.Normal) == "") {
                unitsbutton.setTitle(chosenunit, forState: .Normal)
                perunitsbutton.setTitle(chosenunit, forState: .Normal)
                
                quickunit = chosenunit
                quickperunit = chosenunit
                
                if chosenunit != "" {
                    unline.backgroundColor = UIColorFromRGB(0x31797D)
                    perunline.backgroundColor = UIColorFromRGB(0x31797D)
                } else {
                    unline.backgroundColor = UIColorFromRGB(0xE0E0E0)
                    perunline.backgroundColor = UIColorFromRGB(0xE0E0E0)
                }

                
            } else {
                unitsbutton.setTitle(chosenunit, forState: .Normal)
                quickunit = chosenunit
                
                if chosenunit != "" {
                    unline.backgroundColor = UIColorFromRGB(0x31797D)
                } else {
                    unline.backgroundColor = UIColorFromRGB(0xE0E0E0)
                }
            }
            
            
        } else if currenttype == "perunit" {
            
            perunitsbutton.setTitle(chosenperunit, forState: .Normal)
            quickperunit = chosenperunit
            
            if chosenperunit != "" {
                
                perunline.backgroundColor = UIColorFromRGB(0x31797D)
            } else {
                
                perunline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            }
            
        }
        
        multiplication()
        
        
        
        unitviewbottomconstraint.constant = -347
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                self.unitsview.hidden = true
        })
        
        //restore
        self.picker.selectRow(0, inComponent: 0, animated: false)
        chosenunit = ""
        chosenperunit = ""
        
    }

    
     var currenttype : String = "unit"
    
    var chosenunit = String()
    var chosenperunit = String()
    
    @IBOutlet var unitsbutton: UIButton!
    @IBOutlet var perunitsbutton: UIButton!
    @IBOutlet var unitviewbottomconstraint: NSLayoutConstraint!

    @IBOutlet var unitsview: UIView!
    
    @IBAction func showunits(sender: AnyObject) {
        
         showunitsview("unit")
    }
    
    
    @IBAction func showperunits(sender: AnyObject) {
        
         showunitsview("perunit")
    }
    
    
    @IBAction func saveunits(sender: AnyObject) {
        
        saveUnit()
    }
    
    
    @IBAction func cancelunits(sender: AnyObject) {
        
        // show view constr = -8
        
        
        unitviewbottomconstraint.constant = -347
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            self.view.layoutIfNeeded()
            }, completion: { (value: Bool) -> Void in
                self.unitsview.hidden = true
        })
        
        self.picker.selectRow(0, inComponent: 0, animated: false)
        
        chosenunit = ""
        chosenperunit = ""
        
        if unitsbutton.titleForState(.Normal) == "" {
            
            unline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            
            
        }
        
        
        if perunitsbutton.titleForState(.Normal) == "" {
            
            perunline.backgroundColor = UIColorFromRGB(0xE0E0E0)
            
            
        }


    }
   
    func resetunitsback() {
        
         self.picker.selectRow(0, inComponent: 0, animated: false)
        
        chosenunit = ""
        chosenperunit = ""
        
        unitsbutton.setTitle("", forState: .Normal)
        perunitsbutton.setTitle("", forState: .Normal)
    }
    
    
    func pickedunit(sender: UIButton) {
        
        quickunit = sender.titleForState(.Normal)!
        
        
        
        
        // fuck, much easier just to change state to selected and then filter by state :)
        for button in horizontalScrollView.subviews {
            
            if let tappedbutton = button as? UIButton {
                if tappedbutton.tag == sender.tag {
                    sender.backgroundColor = UIColorFromRGB(0x31797D)
                    sender.tintColor = UIColorFromRGB(0xFAFAFA)
                    sender.setTitleColor(UIColorFromRGB(0xFAFAFA), forState: UIControlState.Normal)
                    sender.layer.borderWidth = 1
                    sender.layer.borderColor = UIColorFromRGB(0x31797D).CGColor
                } else {
                    tappedbutton.backgroundColor = UIColor.clearColor()
                    tappedbutton.tintColor = UIColorFromRGB(0x31797D)
                    tappedbutton.setTitleColor(UIColorFromRGB(0x31797D), forState: UIControlState.Normal)
                    tappedbutton.layer.borderWidth = 1
                    tappedbutton.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
                }
            }
        }
        
        
        // doesn't work. check titles
        
        if (sender.titleForState(.Normal)! != "") && (quickperunit == "") {
        
        for button in horizontalScrollViewper.subviews {
            
            if let tappedbutton = button as? UIButton {
                if tappedbutton.titleForState(.Normal) == quickunit { //tappedbutton.tag == sender.tag {
                    tappedbutton.backgroundColor = UIColorFromRGB(0x31797D)
                    tappedbutton.tintColor = UIColorFromRGB(0xFAFAFA)
                    tappedbutton.setTitleColor(UIColorFromRGB(0xFAFAFA), forState: UIControlState.Normal)
                    tappedbutton.layer.borderWidth = 1
                    tappedbutton.layer.borderColor = UIColorFromRGB(0x31797D).CGColor
                } else {
                    tappedbutton.backgroundColor = UIColor.clearColor()
                    tappedbutton.tintColor = UIColorFromRGB(0x31797D)
                    tappedbutton.setTitleColor(UIColorFromRGB(0x31797D), forState: UIControlState.Normal)
                    tappedbutton.layer.borderWidth = 1
                    tappedbutton.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
                }
            }
        }
            
            quickperunit = quickunit
            
    }
        
        multiplication()
    
    }
    
    func pickedperunit(sender: UIButton) {
        
        quickperunit = sender.titleForState(.Normal)!
        
        
        
        for button in horizontalScrollViewper.subviews {
            
            if let tappedbutton = button as? UIButton {
                if tappedbutton.tag == sender.tag {
                sender.backgroundColor = UIColorFromRGB(0x31797D)
                sender.tintColor = UIColorFromRGB(0xFAFAFA)
                sender.setTitleColor(UIColorFromRGB(0xFAFAFA), forState: UIControlState.Normal)
                sender.layer.borderWidth = 1
                sender.layer.borderColor = UIColorFromRGB(0x31797D).CGColor
                } else {
                tappedbutton.backgroundColor = UIColor.clearColor()
                tappedbutton.tintColor = UIColorFromRGB(0x31797D)
                tappedbutton.setTitleColor(UIColorFromRGB(0x31797D), forState: UIControlState.Normal)
                tappedbutton.layer.borderWidth = 1
                tappedbutton.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
                }
            }
        }
        
        multiplication()

    }
    
    
    @IBOutlet var dimmerforpopover: UIView!
    
   var horizontalScrollView = ASHorizontalScrollView()
    var horizontalScrollViewper = ASHorizontalScrollView()
    
    
    var settingsopen : Bool = false
    
   // func clickthetitle(button: UIButton) {
    func clickthetitle() {
        
        if !settingsopen {
            
            //navbutton.imageView!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            showsettings()
            settingsopen = true
            
        } else if settingsopen {
            //navbutton.imageView!.transform = CGAffineTransformMakeRotation(CGFloat(2*M_PI))
            closesets()
            settingsopen = false
            
        }
        
        
    }
    
    
    /// EDITING MODE PART
    @IBOutlet var tableconstraintbottom: NSLayoutConstraint! //3 in normal state; 50 in editing mode
    
    @IBOutlet var bottomeditingview: NSLayoutConstraint! //-93 in usual mode; 0 in editing mode
    
    @IBOutlet var editingview: UIView!
    

    @IBOutlet var copyoutlet: UIButton!
    @IBOutlet var pasteoutlet: UIButton!
    @IBOutlet var deleteoutlet: UIButton!
    @IBOutlet var canceloutlet: UIButton!
    
    func setupButtons(buttons: [UIButton]) {
        
        for button in buttons {
        let spacing: CGFloat = 6.0
        let imageSize: CGSize = button.imageView!.image!.size
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0)
        let labelString = NSString(string: button.titleLabel!.text!)
        let titleSize = labelString.sizeWithAttributes([NSFontAttributeName: button.titleLabel!.font])
        button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        button.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0)
        }
    }
    
    func moveeditview(mode: String) {
        
        if mode == "up" {
            
            dimmerforpopover.hidden = false
            
            tableconstraintbottom.constant = 50
            bottomeditingview.constant = 0 //-93 in usual mode; 0 in editing mode
            
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.view.layoutIfNeeded()
                }, completion: { (value: Bool) -> Void in
                    
            })

            
        } else if mode == "down" {
            
            dimmerforpopover.hidden = true
        
            tableconstraintbottom.constant = 3
            bottomeditingview.constant = -93 //-93 in usual mode; 0 in editing mode
            
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.view.layoutIfNeeded()
                }, completion: { (value: Bool) -> Void in
                    
            })

            
        }
        
    }
    
    
    
    @IBAction func editsbutton(sender: AnyObject) {
        
        navbutton.imageView!.transform = CGAffineTransformMakeRotation(CGFloat(2*M_PI))
        closesets()
        settingsopen = false
        
        entereditingmode()
    }
    
    
    func entereditingmode() {
        
        // autocomplete.resignFirstResponder()
        
        navbutton.userInteractionEnabled = false
        navbutton.imageView?.hidden = true
        
        temporaryshowcats = showcats
        showcats = false
        myeditingmode = true

        tableView.reloadData()
        
        moveeditview("up")
        
        // add targets to buttons
        copyoutlet.addTarget(self, action: Selector("copyitems:"), forControlEvents: UIControlEvents.TouchUpInside)
        pasteoutlet.addTarget(self, action: Selector("pasteitems:"), forControlEvents: UIControlEvents.TouchUpInside)
        deleteoutlet.addTarget(self, action: Selector("deleteitemsmode:"), forControlEvents: UIControlEvents.TouchUpInside)
        canceloutlet.addTarget(self, action: Selector("canceleditmode:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
    }
    
    func canceleditmode(sender: UIButton!) {
        
               for var i = 0; i < shoppingcheckedtocopy.count; i++ {
            shoppingcheckedtocopy[i] = false
        }
        
        itemsinbuffer.removeAll(keepCapacity: true)
        
        myeditingmode = false
        
        showcats = temporaryshowcats
        
        navbutton.userInteractionEnabled = true
        navbutton.imageView?.hidden = false
        
        // move the view and table back
        moveeditview("down")
        tableView.reloadData()

        
    }
    
    func canceledits() {
        
        for var i = 0; i < shoppingcheckedtocopy.count; i++ {
            shoppingcheckedtocopy[i] = false
        }
        
        itemsinbuffer.removeAll(keepCapacity: true)
        
        myeditingmode = false
        
        showcats = temporaryshowcats
        
        
        navbutton.userInteractionEnabled = true
        navbutton.imageView?.hidden = false
        // move the view and table back
        moveeditview("down")
        tableView.reloadData()
        
        
    }

    let navbutton =  UIButton(type: .Custom)
    
    
    
    
    //Progress stuff
    @IBOutlet var progressbar: KDCircularProgress!
    
    func changeprogress(overall: Int, checked: Int) -> (pcol:UIColor, theangle: Double) {
        
        if overall > 0 {
            var percentage : Double = 100.0 * Double(checked)/Double(overall)
            
            var theangle : Double = 360.0 * (percentage/100.0)
            
            //thelabel.text = "\(Int(percentage))%"
            
            if (percentage > 0.0) && (percentage <= 25.0) {
                return (UIColorFromRGB(0xF5A623), theangle)
                
            } else if (percentage > 25.0) && (percentage <= 50.0) {
                return (UIColorFromRGB(0xA2AF36), theangle)
            } else if (percentage > 50.0) && (percentage <= 75.0) {
                return (UIColorFromRGB(0x64B320), theangle)
            } else if (percentage > 75.0) && (percentage <= 90.0) {
                return (UIColorFromRGB(0x20B343), theangle)
            } else if (percentage > 90.0) && (percentage <= 100.0) {
                return (UIColorFromRGB(0x61C791), theangle)
            } else if (percentage == 0.0) {
                return (UIColorFromRGB(0xF23D55), 1.0)
            } else {
                return (UIColorFromRGB(0xD8D8D8), theangle)
            }
        } else {
            
            return (UIColorFromRGB(0xF23D55), 1.0)
        }
        
        //itemsoverallqty))/\(String(checkeditemsqty)
        
    }
    
    func showprogress() {
        
        progressbar.progressColors = [changeprogress(itemsoverallqty, checked: checkeditemsqty).pcol]
        progressbar.angle = changeprogress(itemsoverallqty, checked: checkeditemsqty).theangle
    }
    
    /*
     cell.progresscircle.progressColors = [changeprogress(UserLists[indexPath.row].listitemscount, checked: UserLists[indexPath.row].listcheckeditemscount, thelabel: cell.percents).pcol]
     cell.progresscircle.angle = changeprogress(UserLists[indexPath.row].listitemscount, checked: UserLists[indexPath.row].listcheckeditemscount, thelabel: cell.percents).theangle
 
    */
    
    
    @IBAction func additembutton(sender: AnyObject) {
        
        performSegueWithIdentifier("additemmodalsegue", sender: sender)
    }
    
    
    ///
    
    func addcustomhere(sender: UITapGestureRecognizer? = nil) {
        performSegueWithIdentifier("createcustomcategoryfromlist", sender: self)
    }
    
    func choosecategoryhere(sender: UITapGestureRecognizer? = nil) {
        
        var senderview : UIView = (sender?.view)!
        var sendertag : Int = (sender?.view!.tag)!
        
        var category : Category = catalogcategories[sendertag]
        
        //categorybutton.setTitle(category.catname, forState: .Normal)
        // categoryimageoutlet.image = category.catimage
        quickcategory = category
        quickcategoryUUID = category.catId
        
        
        for view in horizontalScrollView.subviews {
            
            //if let tappedview = view as? UIButton {
            if view.tag == sendertag {
                
                senderview.tintColor = UIColorFromRGB(0x31797D)
                for subview in senderview.subviews {
                    subview.tintColor = UIColorFromRGB(0x31797D)
                    //if let labelview : UILabel = subview as! UILabel {
                    if subview == subview as? UILabel {
                        // that's how one finds out the type
                        (subview as! UILabel).textColor = UIColorFromRGB(0x31797D)
                    }
                }
                senderview.layer.borderWidth = 1
                senderview.layer.borderColor = UIColorFromRGB(0x31797D).CGColor
            } else {
                
                view.tintColor = UIColorFromRGB(0x979797)
                for subview in view.subviews {
                    subview.tintColor = UIColorFromRGB(0x979797)
                    // if let labelview : UILabel == subview as? UILabel {
                    if subview == subview as? UILabel {
                        (subview as! UILabel).textColor = UIColorFromRGB(0x979797)
                    }
                }
                
                view.layer.borderWidth = 0
                view.layer.borderColor = UIColor.clearColor().CGColor
            }
            // }
        }
    }
    
    
    func setcategoryinscroller(type: String, catindex: Int?) {
        // catalog or usual
        
        if type == "catalog" {
            
                
                
                for view in horizontalScrollView.subviews {
                    
                    //if let tappedview = view as? UIButton {
                    if view.tag == catindex {
                        
                        view.tintColor = UIColorFromRGB(0x31797D)
                        for subview in view.subviews {
                            subview.tintColor = UIColorFromRGB(0x31797D)
                            //if let labelview : UILabel = subview as! UILabel {
                            if subview == subview as? UILabel {
                                // that's how one finds out the type
                                (subview as! UILabel).textColor = UIColorFromRGB(0x31797D)
                            }
                        }
                        view.layer.borderWidth = 1
                        view.layer.borderColor = UIColorFromRGB(0x31797D).CGColor
                    } else {
                        
                        view.tintColor = UIColorFromRGB(0x979797)
                        for subview in view.subviews {
                            subview.tintColor = UIColorFromRGB(0x979797)
                            // if let labelview : UILabel == subview as? UILabel {
                            if subview == subview as? UILabel {
                                (subview as! UILabel).textColor = UIColorFromRGB(0x979797)
                            }
                        }
                        
                        view.layer.borderWidth = 0
                        view.layer.borderColor = UIColor.clearColor().CGColor
                    }
                    // }
                }
                
                
                var vel: CGPoint = CGPointMake(horizontalScrollView.finditem(catindex!, inScrollView: horizontalScrollView), 0.0)
                horizontalScrollView.contentOffset = vel
            

            
        } else if type == "usual" {
            
            for view in horizontalScrollView.subviews {
                
                //if let tappedview = view as? UIButton {
                if view.tag == 0 {
                    
                    view.tintColor = UIColorFromRGB(0x31797D)
                    for subview in view.subviews {
                        subview.tintColor = UIColorFromRGB(0x31797D)
                        //if let labelview : UILabel = subview as! UILabel {
                        if subview == subview as? UILabel {
                            // that's how one finds out the type
                            (subview as! UILabel).textColor = UIColorFromRGB(0x31797D)
                        }
                    }
                    view.layer.borderWidth = 1
                    view.layer.borderColor = UIColorFromRGB(0x31797D).CGColor
                    
                    
                } else {
                    view.tintColor = UIColorFromRGB(0x979797)
                    for subview in view.subviews {
                        subview.tintColor = UIColorFromRGB(0x979797)
                        // if let labelview : UILabel == subview as? UILabel {
                        if subview == subview as? UILabel {
                            (subview as! UILabel).textColor = UIColorFromRGB(0x979797)
                        }
                    }
                    
                    view.layer.borderWidth = 0
                    view.layer.borderColor = UIColor.clearColor().CGColor
                }
            
            }
            
            var vel: CGPoint = CGPointMake(horizontalScrollView.finditem(0, inScrollView: horizontalScrollView), 0.0)
            horizontalScrollView.contentOffset = vel
        }
    }
    
    
    func setupbuttonview(buttonview: UIView, buttonimage: UIImageView, buttonlabel: UILabel) {
        
        buttonview.layer.cornerRadius = 8
        
        buttonlabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        buttonlabel.numberOfLines = 2
        buttonlabel.font = UIFont(name: "AvenirNext-Regular", size: 9)
        buttonlabel.textColor = UIColorFromRGB(0x979797)
        buttonlabel.textAlignment = .Center
        
        buttonimage.tintColor = UIColorFromRGB(0x979797)
        
        
    }
    
    
    func categoriessetup() {
        //categories setup
        
        // add custom cat button
        let addcustom = UIView(frame: CGRectZero)
        let labelview = UILabel(frame: CGRectMake(2, 36, 66, 31))
        let imageview = UIImageView(frame: CGRectMake(21, 8, 28, 28)) // left top widht height
        
        labelview.text = NSLocalizedString("addcustom", comment: "")//"Add Custom"
        imageview.image = UIImage(named: "4EmptyImage")
        
        addcustom.addSubview(labelview)
        addcustom.addSubview(imageview)
        
        addcustom.tag = catalogcategories.count + 10
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("addcustomhere:"))
        addcustom.userInteractionEnabled = true
        addcustom.addGestureRecognizer(tapGestureRecognizer)
        
        setupbuttonview(addcustom, buttonimage: imageview, buttonlabel: labelview)
        horizontalScrollView.addItem(addcustom)
        
        
        for i in (0..<catalogcategories.count) {
            
            let addcat = UIView(frame: CGRectZero)
            let labelview = UILabel(frame: CGRectMake(2, 36, 66, 31))
            let imageview = UIImageView(frame: CGRectMake(21, 8, 28, 28))
            
            labelview.text = catalogcategories[i].catname
            imageview.image = catalogcategories[i].catimage
            
            addcat.addSubview(labelview)
            addcat.addSubview(imageview)
            
            addcat.tag = i
            //"addcustomhere:"
            
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("choosecategoryhere:"))
            addcat.userInteractionEnabled = true
            addcat.addGestureRecognizer(tapGestureRecognizer)
            
            
            setupbuttonview(addcat, buttonimage: imageview, buttonlabel: labelview)
            horizontalScrollView.addItem(addcat)
        }
        
        self.categoryview.addSubview(horizontalScrollView)
        
    }
    
    @IBOutlet var unline: UIView!
    
    @IBOutlet var perunline: UIView!
    
    @IBOutlet var priceline: UIView!
    
    @IBOutlet var sumline: UIView!
    
    
    @IBOutlet var nameview: UIView!
    
    @IBOutlet var noteview: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.tableFooterView = UIView()
         //UINavigationBar.appearance().backgroundColor = UIColor.clearColor()
        
        nameview.layer.borderWidth = 1
        nameview.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        
        noteview.layer.borderWidth = 1
        noteview.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        
        unitsview.hidden = true
        
        unitsview.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        unitsview.layer.borderWidth = 1
        
        picker.delegate = self
        picker.dataSource = self
        
        setupButtons([copyoutlet, pasteoutlet, deleteoutlet, canceloutlet])
        
        resetunitsback()
        //resetunitsback(horizontalScrollViewper)
        
        // SCROLLS
        horizontalScrollView = ASHorizontalScrollView(frame:CGRectMake(12, 4, categoryview.frame.width - 24, 70))//viewforcats.frame.height - 5))
        horizontalScrollView.uniformItemSize = CGSizeMake(70, 70)
        horizontalScrollView.leftMarginPx = 0
        horizontalScrollView.miniMarginPxBetweenItems = 0
        horizontalScrollView.miniAppearPxOfLastItem = 10
        horizontalScrollView.setItemsMarginOnce()
        
        categoriessetup()
        /*
        horizontalScrollView = ASHorizontalScrollView(frame:CGRectMake(0, 0, horscrollview.frame.width, 34))
        horizontalScrollViewper = ASHorizontalScrollView(frame:CGRectMake(0, 0, horscrollviewper.frame.width, 34))
        horizontalScrollView.uniformItemSize = CGSizeMake(40, 34)
        horizontalScrollViewper.uniformItemSize = CGSizeMake(40, 34)
        horizontalScrollView.leftMarginPx = 0
        horizontalScrollViewper.leftMarginPx = 0
        horizontalScrollView.miniMarginPxBetweenItems = 8
        horizontalScrollView.miniAppearPxOfLastItem = 10
        horizontalScrollViewper.miniMarginPxBetweenItems = 8
        horizontalScrollViewper.miniAppearPxOfLastItem = 10
        horizontalScrollView.setItemsMarginOnce()
        horizontalScrollViewper.setItemsMarginOnce()
        
        
        
        for i in (0..<units.count) {

            var button = UIButton(frame: CGRectZero)
            button.backgroundColor = UIColor.clearColor()
            button.setTitle(units[i][1], forState: .Normal)
            button.titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 14)
            button.tintColor = UIColorFromRGB(0x31797D)
            button.setTitleColor(UIColorFromRGB(0x31797D), forState: UIControlState.Normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
            button.layer.cornerRadius = 8
            
            button.addTarget(self, action: "pickedunit:", forControlEvents: UIControlEvents.TouchDown)
            button.tag = 0 + i
            
            var buttonper = UIButton(frame:CGRectMake(0, 0, 52, 42))
            buttonper.backgroundColor = UIColor.clearColor()
            buttonper.titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 14)
            buttonper.tintColor = UIColorFromRGB(0x31797D)
            buttonper.setTitleColor(UIColorFromRGB(0x31797D), forState: UIControlState.Normal)
            
            buttonper.layer.borderWidth = 1
            buttonper.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
            buttonper.layer.cornerRadius = 8
            buttonper.setTitle(units[i][1], forState: .Normal)
            buttonper.addTarget(self, action: "pickedperunit:", forControlEvents: UIControlEvents.TouchDown)
            buttonper.tag = 10 + i
            
            horizontalScrollView.addItem(button)
            horizontalScrollViewper.addItem(buttonper)
        }
        */
        
      // self.horscrollview.addSubview(horizontalScrollView)
       // self.horscrollviewper.addSubview(horizontalScrollViewper)
        
        // not sure
        itemsDataDict.removeAll(keepCapacity: true)
        
        openmenu.target = self.revealViewController()
        //openmenu.action = Selector("openmenuaction:")
       
        openmenu.action = Selector("revealToggle:")
        

        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        
         var popoverup = UISwipeGestureRecognizer(target: self, action: Selector("handleUPSwipe:"))
         popoverup.direction = .Up
            smallpopover.addGestureRecognizer(popoverup)
        /*
        var swipecell = UISwipeGestureRecognizer(target: self, action: "didSwipeCell:")
        swipecell.direction = .Right
        self.tableView.addGestureRecognizer(swipecell)
        */
        
        let nib = UINib(nibName: "TableSectionHeader", bundle: nil)
        tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: "TableSectionHeader")
        
        
        autocomplete.text = NSLocalizedString("additemtext", comment: "")
        autocomplete.autocorrectionType = .No

        listnameinview.leftTextMargin = 1
        
        shownoteview.hidden = true
        
        quickaddoutlet.hidden = true
        opencatalogoutlet.hidden = false
        newquantitybutton.hidden = true
        
        smallpopover.hidden = true
        dimmerforpopover.hidden = true
        

        
        listnameinview.delegate = self
        listnoteinview.delegate = self
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableAfterPush", name: "reloadTableShop", object: nil)
        
        let toolFrame = CGRectMake(0, 0, self.view.frame.size.width, 46);
        let toolView: UIView = UIView(frame: toolFrame);
        let closepadframe: CGRect = CGRectMake(self.view.frame.size.width - 66, 1, 56, 42);
        let closepad: UIButton = UIButton(frame: closepadframe);
        closepad.setImage(closepadimage, forState: UIControlState.Normal)
        toolView.addSubview(closepad);
        closepad.addTarget(self, action: "closenumberpad:", forControlEvents: UIControlEvents.TouchDown);
        
        popqty.inputAccessoryView = toolView
        
        let toolFrame2 = CGRectMake(0, 0, self.view.frame.size.width, 46);
        let toolView2: UIView = UIView(frame: toolFrame2);
        let closepadframe2: CGRect = CGRectMake(self.view.frame.size.width - 66, 1, 56, 42);
        let closepad2: UIButton = UIButton(frame: closepadframe2);
        closepad2.setImage(closepadimage, forState: UIControlState.Normal)
        toolView2.addSubview(closepad2);
        closepad2.addTarget(self, action: "closenumberpad2:", forControlEvents: UIControlEvents.TouchDown);
        
        quickpriceoutlet.inputAccessoryView = toolView2
        
        let toolFrame3 = CGRectMake(0, 0, self.view.frame.size.width, 46); // x y w h
        let toolView3: UIView = UIView(frame: toolFrame3);
        toolView3.backgroundColor = UIColorFromRGB(0xFAFAFA)
        let linetop : UIView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 1))
        linetop.backgroundColor = UIColorFromRGB(0xE0E0E0)
        let linebottom : UIView = UIView(frame: CGRectMake(0, 45, self.view.frame.size.width, 1))
        linebottom.backgroundColor = UIColorFromRGB(0x31797D)
        let closepadframe3: CGRect = CGRectMake(0, 0, self.view.frame.size.width / 2, 46)
        let closepadframe4: CGRect = CGRectMake(self.view.frame.size.width / 2, 0, self.view.frame.size.width / 2, 46)
        let editproduct: UIButton = UIButton(frame: closepadframe3);
        let addproduct: UIButton = UIButton(frame: closepadframe4);
        editproduct.setTitle(NSLocalizedString("qeditproduct", comment: ""), forState: UIControlState.Normal)
        addproduct.setTitle(NSLocalizedString("qaddproduct", comment: ""), forState: UIControlState.Normal)
        editproduct.tintColor = UIColorFromRGB(0x1695A3)
        addproduct.tintColor = UIColorFromRGB(0x31797D)
        editproduct.setImage(editproductimage, forState: UIControlState.Normal)
        addproduct.setImage(addproductimage, forState: UIControlState.Normal)
        editproduct.titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 12)
        addproduct.titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 12)
        editproduct.setTitleColor(UIColorFromRGB(0x1695A3), forState: .Normal)
        editproduct.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        editproduct.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 10);
        addproduct.setTitleColor(UIColorFromRGB(0x31797D), forState: .Normal)
        addproduct.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        addproduct.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 10);
        toolView3.addSubview(editproduct);
        toolView3.addSubview(addproduct);
        toolView3.addSubview(linetop);
       // toolView3.addSubview(linebottom);
        editproduct.addTarget(self, action: "editproductfromkeyboard:", forControlEvents: UIControlEvents.TouchDown);
        addproduct.addTarget(self, action: "addproductfromkeyboard:", forControlEvents: UIControlEvents.TouchDown);
        
        autocomplete.inputAccessoryView = toolView3
        
        
        let toolFrame5 = CGRectMake(0, 0, self.view.frame.size.width, 46);
        let toolView5: UIView = UIView(frame: toolFrame5);
        let closepadframe5: CGRect = CGRectMake(self.view.frame.size.width - 66, 1, 56, 42);
        let closepad5: UIButton = UIButton(frame: closepadframe5);
        closepad5.setImage(closepadimage, forState: UIControlState.Normal)
        toolView5.addSubview(closepad5);
        closepad5.addTarget(self, action: "closenumberpad5:", forControlEvents: UIControlEvents.TouchDown);
        
        quicksum.inputAccessoryView = toolView5
        
        
        popqty.text = ""
        
        popqty.delegate = self
        
        quickpriceoutlet.text = ""
        quickpriceoutlet.delegate = self
        
        quicksum.delegate = self
        

      //  quickcategorybutton.setTitle(catalogcategories[0].catname, forState: .Normal)
        
         setcategoryinscroller("usual", catindex: nil)
        
        quickicon.image = imagestochoose[0].itemimage
        
       // quickcaticon.image = catalogcategories[0].catimage
        
        
        
      
        
        //addedindicator.hidden = true
        addedindicator.alpha = 0
        addedindicator.layer.cornerRadius = 8
        addedindicator.backgroundColor = UIColorFromRGBalpha(0xFFFFFF, alp: 1) //2a2f36
        
        addedindicator.layer.borderWidth = 1
         addedindicator.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        
        
        autocomplete.delegate = self

        
        // TITLE
     
        
       // self.view.backgroundColor = UIColorFromRGB(0xF1F1F1)//(0x2a2f36)F1F1F1
        
        
        //tableView.backgroundColor = UIColorFromRGB(0xF1F1F1) //f1
        
        smallpopover.backgroundColor = UIColorFromRGB(0xFFFFFF)//UIColorFromRGB(0xF7F7F7)
        
        smallpopover.hidden = true
        /*
        inamountview.layer.cornerRadius = 8
        
        inamountview.layer.borderWidth = 1
        inamountview.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        
        
        quickpriceoutlet.layer.cornerRadius = 8
        
        quickpriceoutlet.layer.borderWidth = 1
        quickpriceoutlet.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        
        quicksum.layer.cornerRadius = 8
        
        quicksum.layer.borderWidth = 1
        quicksum.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        */
        
        
        
        /*
        prodiconview.layer.cornerRadius = 8
        
        prodiconview.layer.borderWidth = 1
        prodiconview.layer.borderColor = UIColorFromRGB(0xE0E0E0).CGColor
        */
        
       autocomplete.leftTextMargin = 5
        
  
        
        myeditingmode = false
        
        //for autocomplete part
        self.generateDataAuto()
        autocomplete.mDelegate = self
        

        
        
        
        if justCreatedList == true {
            
          //  noitemview.hidden = false
            
            showcats = false
            
            colorcode = dgreen
            
            let todaydate = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            let namedate = dateFormatter.stringFromDate(todaydate)
            
            
            
            self.listnameinview.text = "\(NSLocalizedString("listshop", comment: ""))"
            
            self.navigationItem.title = "\(NSLocalizedString("listshop", comment: ""))"
            
            
            self.listnoteinview.text = ""
            
            let local = NSLocale.currentLocale()
            symbol = local.objectForKey(NSLocaleCurrencySymbol) as! String
           // code = local.objectForKey(NSLocaleCurrencyCode) as! String
            if let currencyCode = NSLocale.currentLocale().objectForKey(NSLocaleCurrencyCode) as? String {
                code = currencyCode
                 //Will display "USD", for example
            }
            
            quickcurrency.text = symbol
            
           // choosecurrency.setTitle(String(stringInterpolationSegment: symbol), forState: .Normal)
            
            
            newPFObject()
            
            
               // noitemview.hidden = false
           
           // let button =  UIButton(type: .Custom)
            // NAV TITILE AS A BUTTON
            /*
            navbutton.frame = CGRectMake((((self.view.frame.size.width) / 2) - 130),0,260,40) as CGRect
            navbutton.setTitle(NSLocalizedString("listshop", comment: ""), forState: UIControlState.Normal)
            navbutton.titleLabel!.font = UIFont(name: "AvenirNext-Regular", size: 14)
            navbutton.setTitleColor(self.UIColorFromRGB(0x31797D), forState: .Normal)

            let titleimage = UIImage(named: "myliststitle") as UIImage?
            navbutton.setImage(titleimage, forState: .Normal)

            let spacing : CGFloat = 3;
            let insetAmount : CGFloat = 0.5 * spacing;
            
            // First set overall size of the button:
            navbutton.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);
            navbutton.sizeToFit()
            
            // Then adjust title and image insets so image is flipped to the right and there is spacing between title and image:
            navbutton.titleEdgeInsets  = UIEdgeInsetsMake(0, -navbutton.imageView!.frame.size.width - insetAmount, 0,  navbutton.imageView!.frame.size.width  + insetAmount);
            navbutton.imageEdgeInsets  = UIEdgeInsetsMake(2, navbutton.titleLabel!.frame.size.width + insetAmount, 0, -navbutton.titleLabel!.frame.size.width - insetAmount);
            
            navbutton.addTarget(self, action: Selector("clickthetitle:"), forControlEvents: UIControlEvents.TouchUpInside)
            self.navigationItem.titleView = navbutton
            */
            showprogress()
            
        } else {
            
            //  if senderVC == senderVC as? MainMenuViewController {
            
            // currentList = globalshoplistid
            // currentList = activeList!
            // tableView.reloadData()
            
            //  } else {
            
            currentList = activeList!
            dataretrievallist()
            //dataretrievalinorder()
            //summationPrices()
            
          //  print("DICT IS \(itemsDataDict)")
            
           
            
            
           // if let foundlist = find(lazy(UserLists).map({ $0.listid }), activeList!) {
            
              if let foundlist = UserLists.map({ $0.listid }).lazy.indexOf(activeList!) {
                if (UserLists[foundlist].listcategories != nil) {
                    showcats = UserLists[foundlist].listcategories!
                    
                } else {
                    showcats = false
                }
                // part about code here
                if (UserLists[foundlist].listcolorcode != nil) {
                    colorcode = UserLists[foundlist].listcolorcode!
                    
                    //Doing this in order to compensate for deleted color in previous versions
                    if (UserLists[foundlist].listcolorcode) as! String == "DAFFA4" {
                        colorcode = gold
                    }
                    
                } else {
                    colorcode = dgreen
                }
            }
            
            
            
            //quickcurrency.text = symbol
            
            tableView.reloadData()
            
            
            
            //fillthedict()
            // }
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        var shoppingListItemBelongsTo = activeList
        
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("sortArray"), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl) //require this because tableviww is within the VC
        
        
        //for rearranging
        
        
        let longpress = UILongPressGestureRecognizer(target: self, action: "longPressGestureRecognized:")
        
        tableView.addGestureRecognizer(longpress)
        

        
        summationPrices()
        summationcheckedPrices()
        countitems()
        countchecked()
        //itemsoverall.text = "\(String(itemsoverallqty))/\(String(checkeditemsqty))"
        itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
        showprogress()
    }
    
    
    //lets do it only if uncategorized so far
    
    
    
    ///// REARRANGING CELLS START /////
    func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        
        if showcats == false {
        
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        
        let state = longPress.state
        
        let locationInView = longPress.locationInView(tableView)
        
        let indexPath = tableView.indexPathForRowAtPoint(locationInView)
        
        
        struct My {
            static var cellSnapshot : UIView? = nil
        }
        struct Path {
            static var initialIndexPath : NSIndexPath? = nil
        }
        
        
        switch state {
        case UIGestureRecognizerState.Began:
            if indexPath != nil {
                Path.initialIndexPath = indexPath
                let cell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
                My.cellSnapshot = snapshopOfCell(cell)
                var center = cell.center
                
                My.cellSnapshot!.center = center
                
                My.cellSnapshot!.alpha = 0.0
                
                tableView.addSubview(My.cellSnapshot!)
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    center.y = locationInView.y
                    
                    My.cellSnapshot!.center = center
                    
                    My.cellSnapshot!.transform = CGAffineTransformMakeScale(1.05, 1.05)
                    
                    My.cellSnapshot!.alpha = 0.98
                    
                    cell.alpha = 0.0
                    
                    }, completion: { (finished) -> Void in
                        
                        if finished {
                            
                            cell.hidden = true
                            
                        }
                        
                })
                
            }
            
        case UIGestureRecognizerState.Changed:
            var center = My.cellSnapshot!.center
            center.y = locationInView.y
            My.cellSnapshot!.center = center
            if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                swap(&itemsDataDict[indexPath!.row], &itemsDataDict[Path.initialIndexPath!.row])
                
                swap(&shoppingcheckedtocopy[indexPath!.row], &shoppingcheckedtocopy[Path.initialIndexPath!.row])
                
                tableView.moveRowAtIndexPath(Path.initialIndexPath!, toIndexPath: indexPath!)
                Path.initialIndexPath = indexPath
            }
            
        default:
            let cell = tableView.cellForRowAtIndexPath(Path.initialIndexPath!) as UITableViewCell!
            cell.hidden = false
            cell.alpha = 0.0
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                My.cellSnapshot!.center = cell.center
                My.cellSnapshot!.transform = CGAffineTransformIdentity
                My.cellSnapshot!.alpha = 0.0
                cell.alpha = 1.0
                }, completion: { (finished) -> Void in
                    if finished {
                        Path.initialIndexPath = nil
                        My.cellSnapshot!.removeFromSuperview()
                        My.cellSnapshot = nil
                    }
            })
            
            
            
        }
        
        } else {
            print("Showcats mode on")
        }
    
    }
    
    func snapshopOfCell(inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    ///// REARRANGING CELLS END /////
    //end of if showcats == true statement
    
    
    
    func sortArray() {

        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    func ListsTapped(sender:UIButton) {
        print("All lists pressed")
        
        listsBarButtonTapped()
    }
    
    func SettingsTapped(sender:UIButton) {
        print("Settings pressed")
        dismissViewControllerAnimated(true, completion: nil)
    }
    // 5
    func addTapped (sender:UIButton) {
        print("add pressed")
        // Do any additional setup after loading the view.
        
        addBarButtonTapped()
        
    }
    
    func addMultipleTapped (sender:UIButton) {
        print("multiple add pressed")
        // Do any additional setup after loading the view.
        
        addMultipleFunc()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        if showcats == true {
            
            let set = NSSet(array: shoppingListItemsCategoriesNames)
                      return sections.count
            
        } else {
            
            return 1
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        //if itemsDataDict.count != 0 {
        
        if showcats == true {
            //   return sections[section].length
            return sections[sortedSections[section]]!.count
        } else {
            
            // return shoppingListItemsIds.count
            return itemsDataDict.count
            // }
        }
        //} else {
        ////    return 0
       // }
    }
    
    func edititem(sender: UIButton!) {
        
        
        if showcats == false {
            
            let button = sender as UIButton
            let view = button.superview!
            let innerview = view.superview!
            //let cell = view.superview as! ItemShopListCell
            let cell = innerview.superview as! ItemShopListCell
            let indexPathItem = tableView.indexPathForCell(cell)
            
            //itemtoedit = shoppingListItemsIds[indexPathItem!.row]
            itemtoedit = itemsDataDict[indexPathItem!.row]["ItemId"] as! String
            
            //performSegueWithIdentifier("EditItem", sender: self)
            performSegueWithIdentifier("edititemmodalsegue", sender: self)
        } else {
            let button = sender as UIButton
            let view = button.superview!
            let innerview = view.superview!
            //let cell = view.superview as! ItemShopListCell
            let cell = innerview.superview as! ItemShopListCell
            
            let position: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
            if let indexPathIteminSection = self.tableView.indexPathForRowAtPoint(position)
            {
                let section = indexPathIteminSection.section
                let rowsect = indexPathIteminSection.row
                
                
                let tableSection = sections[sortedSections[section]]
                let tableItem = tableSection![rowsect]
 
                
                itemtoedit = (tableItem as NSDictionary).objectForKey("ItemId") as! String
                
                // performSegueWithIdentifier("EditItem", sender: self)
                performSegueWithIdentifier("edititemmodalsegue", sender: self)
            }
            
            
         
            
        }
        
    }
    
    
    func restoreitem(sender: UIButton!) {
        
        
       //  self.activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        if showcats == false {
        
        let button = sender as UIButton
        let view = button.superview!
        let nextview = view.superview!
        //let nextview2 = nextview.superview!
        let cell = nextview.superview as! ItemShopListCell
        let indexPathCheck = tableView.indexPathForCell(cell)

        itemtocheck = itemsDataDict[indexPathCheck!.row]["ItemId"] as! String
        
        //let checkbutton = cell.viewWithTag(70) as! UIButton //checkbuttontag
            
            itemsDataDict[indexPathCheck!.row]["ItemIsChecked"] = false
 
            let thissectionsname : String = itemsDataDict[indexPathCheck!.row]["ItemCategoryName"] as! String
            

            for ( var i = 0; i < sections[thissectionsname]!.count; i++ ) {
                

                if sections[thissectionsname]![i]["ItemId"] as? String == itemtocheck {

                    sections[thissectionsname]![i]["ItemIsChecked"] = false

                    
                }
            }
        
        
        //checkbutton.setImage(notcheckedImage, forState: .Normal) // PERFECT, WORKS!
           

           // movechecked(true, cell: cell)
            
            view.hidden = true
            
            let attributes = [NSStrikethroughStyleAttributeName : 0]
            // var title = NSAttributedString(string: shoppingListItemsNames[indexPathCheck!.row], attributes: attributes)
            let title = NSAttributedString(string: itemsDataDict[indexPathCheck!.row]["ItemName"] as! String, attributes: attributes)
            
            cell.itemName.attributedText = title
            
            
            //self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
        let querynew = PFQuery(className:"shopItems")
        querynew.fromLocalDatastore()
        // querynew.getObjectInBackgroundWithId(itemtocheck) {
        querynew.whereKey("itemUUID", equalTo: itemtocheck)
        querynew.getFirstObjectInBackgroundWithBlock() {
            (itemList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let itemList = itemList {
                itemList["isChecked"] = false
                itemList.pinInBackground()
                // itemList.saveInBackground()
              //  itemList.saveEventually()
                
            }
            
            
        }
        
        // shoppingListItemsIsChecked[indexPathCheck!.row] = false
        
      
        
        checkeditemsqty -= 1
            countitems()
        summationcheckedPrices()
            itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"

        showprogress()
    } else {
           
            let button = sender as UIButton
            let view = button.superview!
            let nextview = view.superview!
            let cell = nextview.superview as! ItemShopListCell
            
            let position: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
            if let indexPathIteminSection = self.tableView.indexPathForRowAtPoint(position)
            {
                let section = indexPathIteminSection.section
                let rowsect = indexPathIteminSection.row
                
                //var tableSection : [Dictionary<String, AnyObject>] = []
                var tableSection = sections[sortedSections[section]]
                var tableItem = tableSection![rowsect]
   
                
               
                itemtocheck = (tableItem as NSDictionary).objectForKey("ItemId") as! String

              //  let checkbutton = cell.viewWithTag(70) as! UIButton //checkbuttontag
                

                
                tableItem.updateValue(false, forKey: "ItemIsChecked")

                tableSection![rowsect] = tableItem
                
                sections[sortedSections[section]] = tableSection

                for ( var i = 0; i < itemsDataDict.count; i++ ) {
                    if itemsDataDict[i]["ItemId"] as? String == itemtocheck {

                        var index = i

                        itemsDataDict[i]["ItemIsChecked"] = false

                    }
                }

                
               // checkbutton.setImage(notcheckedImage, forState: .Normal) // PERFECT, WORKS!
                

                view.hidden = true
                
               // movechecked(true, cell: cell)

                let attributes = [NSStrikethroughStyleAttributeName : 0]
                let title = NSAttributedString(string: (tableItem as NSDictionary).objectForKey("ItemName") as! String, attributes: attributes)
                cell.itemName.attributedText = title
                
                //self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                
                let querynew = PFQuery(className:"shopItems")
                querynew.fromLocalDatastore()

                querynew.whereKey("itemUUID", equalTo: (tableItem as NSDictionary).objectForKey("ItemId") as! String)
                querynew.getFirstObjectInBackgroundWithBlock() {
                    (itemList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let itemList = itemList {
                        itemList["isChecked"] = false
                        itemList.pinInBackground()

                        
                    }
                    
                    
                }

                checkeditemsqty -= 1

                countitems()
                summationcheckedPrices()
                itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
                
                showprogress()
            }
            
        }
        
    }
    
    
    
    
    func checkitem(indexPathCheck: NSIndexPath) {
        
        //self.activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        let cell = tableView.cellForRowAtIndexPath(indexPathCheck) as! ItemShopListCell
        
        if showcats == false {
            
            /*
            let button = sender as UIButton
            let view = button.superview!
            let innerview = view.superview!
            let cell = innerview.superview as! ItemShopListCell
            let indexPathCheck = tableView.indexPathForCell(cell)
            */

            itemtocheck = itemsDataDict[indexPathCheck.row]["ItemId"] as! String
            
            print(itemsDataDict[indexPathCheck.row]["ItemName"])

            itemsDataDict[indexPathCheck.row]["ItemIsChecked"] = true
            
            print(itemsDataDict[indexPathCheck.row]["ItemIsChecked"])

            let thissectionsname : String = itemsDataDict[indexPathCheck.row]["ItemCategoryName"] as! String

            for ( var i = 0; i < sections[thissectionsname]!.count; i++ ) {

                if sections[thissectionsname]![i]["ItemId"] as? String == itemtocheck {

                    sections[thissectionsname]![i]["ItemIsChecked"] = true

                }
            }
            
            
                //button.setImage(checkedImage, forState: .Normal)
                
                cell.checkedview.hidden = false
            
             //   movechecked(false, cell: cell)

              //  self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()

                let attributes = [NSStrikethroughStyleAttributeName : 1]

                let title = NSAttributedString(string: itemsDataDict[indexPathCheck.row]["ItemName"] as! String, attributes: attributes)
                cell.itemName.attributedText = title
                
                let querynew = PFQuery(className:"shopItems")
                querynew.fromLocalDatastore()
                querynew.whereKey("itemUUID", equalTo: itemtocheck)
                querynew.getFirstObjectInBackgroundWithBlock() {
                    (itemList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let itemList = itemList {
                        itemList["isChecked"] = true
                        itemList.pinInBackground()

                    }
                    
                    
                }
            
                checkeditemsqty += 1
            countitems()
            summationcheckedPrices()
            
            itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
                showprogress()
            
        } else {
            

                let section = indexPathCheck.section//indexPathIteminSection.section
                let rowsect = indexPathCheck.row//indexPathIteminSection.row

                var tableSection = sections[sortedSections[section]]
                var tableItem = tableSection![rowsect]

                var checkedbitch = Bool()
                
                itemtocheck = (tableItem as NSDictionary).objectForKey("ItemId") as! String

                tableItem.updateValue(true, forKey: "ItemIsChecked")
                tableSection![rowsect] = tableItem
                sections[sortedSections[section]] = tableSection
                
                for ( var i = 0; i < itemsDataDict.count; i++ ) {
                    if itemsDataDict[i]["ItemId"] as? String == itemtocheck {
                        var index = i
                        itemsDataDict[i]["ItemIsChecked"] = true

                    }
                }
                    //button.setImage(checkedImage, forState: .Normal)
                    cell.checkedview.hidden = false
                    //self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                
                    let attributes = [NSStrikethroughStyleAttributeName : 1]
                    let title = NSAttributedString(string: (tableItem as NSDictionary).objectForKey("ItemName") as! String, attributes: attributes)
                    cell.itemName.attributedText = title
                    
                    let querynew = PFQuery(className:"shopItems")
                    querynew.fromLocalDatastore()
                    querynew.whereKey("itemUUID", equalTo: (tableItem as NSDictionary).objectForKey("ItemId") as! String)
                    querynew.getFirstObjectInBackgroundWithBlock() {
                        (itemList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                        } else if let itemList = itemList {
                            itemList["isChecked"] = true
                            itemList.pinInBackground()
                            
                        }
                        
                        
                    }

                checkeditemsqty += 1
                countitems()
                summationcheckedPrices()
                itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
                showprogress()
                //}
            }
        
        
    }
    
    func getcategoriesnames(categoryIds: [String]) -> [String] {
        
        for categoryid in categoryIds {
            
            if (categoryid as NSString).containsString("custom") {
                //CASE IF CATEGORY IS CUSTOM
               // print(categoryIds)
                
                //PIZDEC, BUT MUST WORK
                
                let querycat = PFQuery(className:"shopListsCategory")
                querycat.fromLocalDatastore()
                querycat.whereKey("categoryUUID", equalTo: categoryid)
                let categories = querycat.findObjects()
                if (categories != nil) {
                    for category in categories! {
                        if let thiscatname = category["catname"] as? String {
                            print("NAME IS \(thiscatname)")
                            self.shoppingListItemsCategoriesNames.append(thiscatname)
                        }
                    }
                } else {
                    print("No custom cats yet")
                }
                
            } else {
                // CASE IF IT IS DEFAULT CATEGORY
                
                
                
                // Find this object of product type which has property catId = itemcategoryUUID
                
                //if let foundcategory = find(lazy(catalogcategories).map({ $0.catId }), categoryid) {
                
                if let foundcategory = catalogcategories.map({ $0.catId }).lazy.indexOf(categoryid) {
                let catalogname = catalogcategories[foundcategory].catname
                    
                  
                    
                    self.shoppingListItemsCategoriesNames.append(catalogname)
                    
                    
                }
                
                
            }
            
            
            
                 } // end of for loop
        
        return shoppingListItemsCategoriesNames
    }
    
    
   

    
    func swipedeleteitem(deleterow: NSIndexPath) {
        
        
        
        
        itemtodelete = itemsDataDict[deleterow.row]["ItemId"] as? String
        
        dictionary.removeValueForKey("ItemId")
        dictionary.removeValueForKey("ItemName")
        dictionary.removeValueForKey("ItemNote")
        // dictionary.removeValueForKey("ItemImage")
        dictionary.removeValueForKey("ItemImage2")
        dictionary.removeValueForKey("ItemImagePath")
        dictionary.removeValueForKey("ItemQuantity")
        dictionary.removeValueForKey("ItemTotalPrice")
        dictionary.removeValueForKey("ItemUnit")
        dictionary.removeValueForKey("ItemIsChecked")
        dictionary.removeValueForKey("ItemCategory")
        dictionary.removeValueForKey("itemCategoryName")
        dictionary.removeValueForKey("ItemOneUnitPrice")
        dictionary.removeValueForKey("ItemIsFav")
        dictionary.removeValueForKey("ItemPerUnit")
        dictionary.removeValueForKey("ItemCreation")
        dictionary.removeValueForKey("ItemUpdate")
        
        ///DELETE FROM SECTIONS
        
        
        // var thissectionsname : String = shoppingListItemsCategoriesNames[indexPathDelete!.row]
        let thissectionsname : String = itemsDataDict[deleterow.row]["ItemCategoryName"] as! String
        for ( var i = 0; i < sections[thissectionsname]!.count; i++ ) {
            
            if sections[thissectionsname]![i]["ItemId"] as? String == itemtodelete {
                
                sections[thissectionsname]!.removeAtIndex(i)
                // tableView.reloadData() //this was really necessary
                
            }
        }
        
        
        itemsDataDict.removeAtIndex(deleterow.row)
        
        
        let querynew1 = PFQuery(className:"shopItems")
        querynew1.fromLocalDatastore()
        //  querynew1.getObjectInBackgroundWithId(itemtodelete!) {
        querynew1.whereKey("itemUUID", equalTo: itemtodelete!)
        querynew1.getFirstObjectInBackgroundWithBlock() {
            (itemList: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let itemList = itemList {
                
                itemList.unpinInBackground()
                
                
            }
            //self.dataretrievallist() no need to do that, otherwise delete and immediately restored since data hasnt been passed to the server by this time
            
        }
        
        
        // remove the deleted item from the `UITableView`
        self.tableView.deleteRowsAtIndexPaths([deleterow], withRowAnimation: UITableViewRowAnimation.Automatic)
        
        tableView.reloadData()
        
        //self.tableView.deleteRowsAtIndexPaths([indexPathDelete!], withRowAnimation: UITableViewRowAnimation.Automatic)
        //tableView.reloadData()
        summationPrices()
        summationcheckedPrices()
     
       
        countitems()
        countchecked()
        itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
        showprogress()
        //IF SHOWCATS == TRUE
        
        
        
        
    }
    
    func tableView(tableView: UITableView,
        willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.separatorInset = UIEdgeInsetsZero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    
    //func deleteitem(sender: UIButton!) {
    func deleteitem(deleterow: NSIndexPath) {
        
        //WORKS!!!
        //First, I am getting the cell in which the tapped button is contained
        if showcats == false {
            
            
             itemtodelete = itemsDataDict[deleterow.row]["ItemId"] as? String
            
            dictionary.removeValueForKey("ItemId")
            dictionary.removeValueForKey("ItemName")
            dictionary.removeValueForKey("ItemNote")
            // dictionary.removeValueForKey("ItemImage")
            dictionary.removeValueForKey("ItemImage2")
            dictionary.removeValueForKey("ItemImagePath")
            dictionary.removeValueForKey("ItemQuantity")
            dictionary.removeValueForKey("ItemTotalPrice")
            dictionary.removeValueForKey("ItemUnit")
            dictionary.removeValueForKey("ItemIsChecked")
            dictionary.removeValueForKey("ItemCategory")
            dictionary.removeValueForKey("itemCategoryName")
            dictionary.removeValueForKey("ItemOneUnitPrice")
            dictionary.removeValueForKey("ItemIsFav")
            dictionary.removeValueForKey("ItemPerUnit")
            dictionary.removeValueForKey("ItemCreation")
            dictionary.removeValueForKey("ItemUpdate")
            
            ///DELETE FROM SECTIONS
            
            
            // var thissectionsname : String = shoppingListItemsCategoriesNames[indexPathDelete!.row]
            let thissectionsname : String = itemsDataDict[deleterow.row]["ItemCategoryName"] as! String
            for ( var i = 0; i < sections[thissectionsname]!.count; i++ ) {
                
                if sections[thissectionsname]![i]["ItemId"] as? String == itemtodelete {
                    
                    sections[thissectionsname]!.removeAtIndex(i)
                    // tableView.reloadData() //this was really necessary
                    
                }
            }
            
            
            itemsDataDict.removeAtIndex(deleterow.row)
            
            
            
            let querynew1 = PFQuery(className:"shopItems")
            querynew1.fromLocalDatastore()
            //  querynew1.getObjectInBackgroundWithId(itemtodelete!) {
            querynew1.whereKey("itemUUID", equalTo: itemtodelete!)
            querynew1.getFirstObjectInBackgroundWithBlock() {
                (itemList: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let itemList = itemList {
                    
                    itemList.unpinInBackground()
                    
                    
                }
                //self.dataretrievallist() no need to do that, otherwise delete and immediately restored since data hasnt been passed to the server by this time
                
            }
            
            
            // remove the deleted item from the `UITableView`
            self.tableView.deleteRowsAtIndexPaths([deleterow], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            tableView.reloadData()
            
          
            summationPrices()
            summationcheckedPrices()
            countitems()
            countchecked()
            itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(itemsoverallqty))/\(String(checkeditemsqty))"
            showprogress()
        } else {
            // case when showcats == true
                   }//END OF IF
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if showcats == true {
            return 30.0
        } else {
            return 0
        }

    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        
        return 51
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if showcats == true {
            // return shoppingListItemsCategoriesNames[section]
            // return sortedSections[section]
            //return sections[section].title
            return nil//sortedSections[section]
        } else {
            return nil
        }
    }
    
    var thiscatpicture = UIImage()
    
    
    var headerimages = [UIImage]()
    
    func getcategorypicture(section: Int) -> UIImage {
    
        var key: String = sortedSections[section]
        
        //((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemImage2")) as? UIImage
        
       var cat = (sections as NSDictionary).objectForKey(key) as! [Dictionary<String,AnyObject>]
        var catid : String = (cat[0] as NSDictionary).objectForKey("ItemCategory") as! String
        
       
        
        if (catid as NSString).containsString("custom") {
  
            
            var querycat = PFQuery(className:"shopListsCategory")
            querycat.fromLocalDatastore()
            querycat.whereKey("categoryUUID", equalTo: catid)
            var categories = querycat.findObjects()
            if (categories != nil) {
                for category in categories! {
                   
                       
                        if category["defaultpicture"] as! Bool == false {
  
                            
                            self.loadImageFromLocalStore(category["imagePath"] as! String)
                            thiscatpicture = self.imageToLoad
                            
                        } else {
                            
                            var imagename = category["OriginalInDefaults"] as! String
                            
                            if (UIImage(named: "\(imagename)") != nil) {
                                thiscatpicture = UIImage(named: "\(imagename)")!
                            } else {
                                thiscatpicture = defaultcatimages[0].itemimage
                            }
                            
                        }
                    
                }
            } else {
                print("No custom cats yet")
            }
    
            
        } else {
            // CASE IF IT IS DEFAULT CATEGORY
                if var foundcategory = catalogcategories.map({ $0.catId }).lazy.indexOf(catid) {

            var catalogpicture = catalogcategories[foundcategory].catimage
                
                thiscatpicture = catalogpicture
                
                
                
            }
            
            
        }
        
        
        return thiscatpicture
       // var catid2: ca
        
    }
  
    
    
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        // Dequeue with the reuse identifier
        let cell = self.tableView.dequeueReusableHeaderFooterViewWithIdentifier("TableSectionHeader")
        let header = cell as! TableSectionHeader
        
        header.title.text = sortedSections[section]
        
        header.pict.image = headerimages[section]
        
        return cell

        
    }
   
    
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        
        if showcats == true {
            return index
        } else {
            return 0
        }
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ItemCellIdentifier = "NewListItem"
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! ItemShopListCell
        
        
        
        if itemsDataDict.count == 0 {

            //noitemview.hidden = false
        } else {
           // noitemview.hidden = true
        }
        /*
        if indexPath.row % 2 == 0 {
            
            cell.backgroundColor = UIColorFromRGB(0xFAFAFA)
        } else {
            cell.backgroundColor = UIColorFromRGB(0xF4F3F3)
        }
*/
        
            if myeditingmode == false {
                
                cell.userInteractionEnabled = true
                cell.selectionStyle = UITableViewCellSelectionStyle.None//Default
        
                if showcats == false {
            
            
            cell.itemImage.image = ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemImage2")) as? UIImage
            // }
            //acctss dict
            //....text = dict.objectForKey("key") as String or whatever it is
            
            cell.itemName.text = ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemName")) as? String
            
            cell.itemNote.text = ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemNote")) as? String
            
            if ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemNote")) as? String == "" {
                cell.nametopconstraint.constant = 14
            } else {
                cell.nametopconstraint.constant = 9
            }
            
           
            let qty : String = ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemQuantity")) as! String
            
            let unit : String = ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemUnit")) as! String
            
            cell.itemQuantity.text = "\(qty) \(unit)"
            
            /*
            cell.itemQuantity.text = ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemQuantity")) as? String
            
            cell.itemUnit.text = ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemUnit")) as? String
            */
            let doubleprice = ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemTotalPrice")) as! String
            if doubleprice != "" && doubleprice != "0" {
            cell.itemPrice.text = "\(doubleprice) \(symbol)"//((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemTotalPrice")) as? Double//as? String
            } else {
                cell.itemPrice.text = ""
            }
            
            if cell.itemPrice.text == "" {
                cell.amounttopconstraint.constant = 18
            } else {
                cell.amounttopconstraint.constant = 10
            }
            
            
          
            cell.copybuttonoutlet.hidden = true
           // cell.copybuttonoutlet.setImage(notcheckedImageToCopy, forState: .Normal)
            cell.copybuttonoutlet.selected = false
           // cell.editItemOutlet.hidden = false
          //  cell.checkedButtonOutlet.hidden = false
            cell.itemPrice.hidden = false
            cell.itemQuantity.hidden = false
            
            if (((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemIsChecked")) as? Bool) == true {
                
               
                
               // cell.checkedButtonOutlet.setImage(checkedImage, forState: .Normal)
                
                
                let attributes = [NSStrikethroughStyleAttributeName : 1]
                // var title = NSAttributedString(string: shoppingListItemsNames[indexPathCheck!.row], attributes: attributes)
                let title = NSAttributedString(string: ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemName")) as! String, attributes: attributes)
                cell.itemName.attributedText = title
                
                //cell.checkedview.frame = cell.bounds
                
              // cell.heightconstraint.constant = cell.frame.size.height
              //  cell.widthconstraint.constant = cell.frame.size.width
                
               // cell.bringSubviewToFront(cell.checkedview)
                
               // cell.checkedview.bringSubviewToFront(cell.restorebutton)
                
                cell.checkedview.hidden = false

                cell.restorebutton.addTarget(self, action: "restoreitem:", forControlEvents: UIControlEvents.TouchUpInside)
                
                cell.selectionStyle = UITableViewCellSelectionStyle.None


                
            } else {
                //cell.checkedButtonOutlet.setImage(notcheckedImage, forState: .Normal)
                
                let attributes = [NSStrikethroughStyleAttributeName : 0]
                // var title = NSAttributedString(string: shoppingListItemsNames[indexPathCheck!.row], attributes: attributes)
                let title = NSAttributedString(string: ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemName")) as! String, attributes: attributes)
                cell.itemName.attributedText = title

                
                
                //cell.checkedview.frame = cell.bounds
                
                cell.checkedview.hidden = true
                
                   cell.restorebutton.addTarget(self, action: "restoreitem:", forControlEvents: UIControlEvents.TouchUpInside)
                
                
            }
            
            /*
            cell.itemName.text = shoppingListItemsNames[indexPath.row]
            cell.itemNote.text = shoppingListItemsNotes[indexPath.row]
            cell.itemQuantity.text = shoppingListItemsQuantity[indexPath.row]
            cell.itemPrice.text = "\(shoppingListItemsPrices[indexPath.row])" //must convert double to STRING
            */
            //cell.itemName.text = self.testarray[indexPath.row]
            
            //self.tableView.reloadData()
            
            // Configure the cell...
            
            //code for deletion of an item
            //cell.deleteItemOutlet.tag = indexPath.row
           // cell.deleteItemOutlet.addTarget(self, action: "deleteitem:", forControlEvents: .TouchUpInside)
            
            //cell.deleteItemOutlet.tag = indexPath.row
           // cell.editItemOutlet.addTarget(self, action: "edititem:", forControlEvents: .TouchUpInside)
            
           // cell.deleteItemOutlet.tag = indexPath.row
           // cell.checkedButtonOutlet.addTarget(self, action: "checkitem:", forControlEvents: .TouchUpInside)
            
            
        }//end of showcats if
        else {
            //if showcats == true
            
            //cell.textLabel?.text = array[sections[indexPath.section].index + indexPath.row]
            
            //     cell.itemName.text = ((itemsDataDict[sections[indexPath.section].index + indexPath.row] as NSDictionary).objectForKey("ItemName")) as? String
            
            //   cell.itemNote.text = ((itemsDataDict[sections[indexPath.section].index + indexPath.row] as NSDictionary).objectForKey("ItemNote")) as? String
            
            
            let tableSection = sections[sortedSections[indexPath.section]]
            let tableItem = tableSection![indexPath.row]
            
            cell.itemName.text = (tableItem as NSDictionary).objectForKey("ItemName") as? String//["ItemName"]
            cell.itemNote.text = (tableItem as NSDictionary).objectForKey("ItemNote") as? String
            if (tableItem as NSDictionary).objectForKey("ItemNote") as? String == ""
            {
                cell.nametopconstraint.constant = 14
            } else {
                cell.nametopconstraint.constant = 9
            }
            
            
            
            cell.itemImage.image = (tableItem as NSDictionary).objectForKey("ItemImage2") as? UIImage
            
            let qty : String = (tableItem as NSDictionary).objectForKey("ItemQuantity") as! String

            
            let unit : String = (tableItem as NSDictionary).objectForKey("ItemUnit") as! String
            
            cell.itemQuantity.text = "\(qty) \(unit)"
            
            /*
            cell.itemQuantity.text = (tableItem as NSDictionary).objectForKey("ItemQuantity") as? String
            
            cell.itemUnit.text = (tableItem as NSDictionary).objectForKey("ItemUnit") as? String
            */
            let doubleprice = (tableItem as NSDictionary).objectForKey("ItemTotalPrice") as! String
            
            if doubleprice != ""  && doubleprice != "0" {
                cell.itemPrice.text = "\(doubleprice) \(symbol)"//((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemTotalPrice")) as? Double//as? String
            } else {
                cell.itemPrice.text = ""
            }

            if cell.itemPrice.text == "" {
                cell.amounttopconstraint.constant = 18
            } else {
                cell.amounttopconstraint.constant = 10
                
            }
            
           
            
           // cell.itemPrice.text = "\(doubleprice) \(symbol)"
            
            
            cell.copybuttonoutlet.hidden = true
            //cell.copybuttonoutlet.setImage(notcheckedImageToCopy, forState: .Normal)
            cell.copybuttonoutlet.selected = false
            //cell.editItemOutlet.hidden = false
            //cell.checkedButtonOutlet.hidden = false
            
            
            cell.itemPrice.hidden = false
            cell.itemQuantity.hidden = false
            
            if ((tableItem as NSDictionary).objectForKey("ItemIsChecked") as? Bool) == true {
                
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                
               // cell.checkedButtonOutlet.setImage(checkedImage, forState: .Normal)
                
                let attributes = [NSStrikethroughStyleAttributeName : 1]
                // var title = NSAttributedString(string: shoppingListItemsNames[indexPathCheck!.row], attributes: attributes)
                let title = NSAttributedString(string: ((tableItem as NSDictionary).objectForKey("ItemName") as! String), attributes: attributes)
                cell.itemName.attributedText = title
                
                
                //cell.checkedview.frame = cell.bounds
                
                // cell.heightconstraint.constant = cell.frame.size.height
                //  cell.widthconstraint.constant = cell.frame.size.width
                
               // cell.bringSubviewToFront(cell.checkedview)
                
               // cell.checkedview.bringSubviewToFront(cell.restorebutton)
                
                cell.checkedview.hidden = false
                
                cell.restorebutton.addTarget(self, action: "restoreitem:", forControlEvents: UIControlEvents.TouchUpInside)

                
                
            } else {
               // cell.checkedButtonOutlet.setImage(notcheckedImage, forState: .Normal)
                
                let attributes = [NSStrikethroughStyleAttributeName : 0]
                // var title = NSAttributedString(string: shoppingListItemsNames[indexPathCheck!.row], attributes: attributes)
                let title = NSAttributedString(string: ((tableItem as NSDictionary).objectForKey("ItemName") as! String), attributes: attributes)
                cell.itemName.attributedText = title
                
                
                  cell.checkedview.hidden = true
                
                 cell.restorebutton.addTarget(self, action: "restoreitem:", forControlEvents: UIControlEvents.TouchUpInside)
                
            }
            
            //  cell.deleteItemOutlet.tag = sectionIndex
           // cell.deleteItemOutlet.addTarget(self, action: "deleteitem:", forControlEvents: .TouchUpInside)
            
            //cell.deleteItemOutlet.tag = tableSection![indexPath.row]
            //cell.editItemOutlet.addTarget(self, action: "edititem:", forControlEvents: .TouchUpInside)
            
            //cell.deleteItemOutlet.tag = tableSection![indexPath.row]
           // cell.checkedButtonOutlet.addTarget(self, action: "checkitem:", forControlEvents: .TouchUpInside)
            
            
        }
        ///// END IF ITEMS != 0 CASE
        //  } else {
        // items = 0 case
        
        
        // }
        
        return cell
        
    } else {
    //when editing mode
                
                // cell.userInteractionEnabled = true
                cell.selectionStyle = UITableViewCellSelectionStyle.Default
                // cell.selectionStyle = UITableViewCellSelectionStyle.None
                
                if showcats == false {
                    
                   
                    
                    cell.itemImage.image = ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemImage2")) as? UIImage
                    // }
                    //acctss dict
                    //....text = dict.objectForKey("key") as String or whatever it is
                    
                    cell.itemName.text = ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemName")) as? String
                    
                    cell.itemNote.text = ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemNote")) as? String
                    
                    if ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemNote")) as? String == ""
                    {
                        cell.nametopconstraint.constant = 14
                    } else {
                        cell.nametopconstraint.constant = 9
                    }
                    
                    
                    let qty : String = ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemQuantity")) as! String
                    
                    let unit : String = ((itemsDataDict[indexPath.row] as NSDictionary).objectForKey("ItemUnit")) as! String
                    
                    cell.itemQuantity.text = "\(qty) \(unit)"

                   // cell.checkedButtonOutlet.hidden = true
                    cell.itemPrice.hidden = true
                    cell.itemQuantity.hidden = true
                    cell.checkedview.hidden = true
                    //fucking
                    
                    
                
                    cell.copybuttonoutlet.hidden = false
                    
                    
                    
                    if shoppingcheckedtocopy[indexPath.row] == false {
                    // cell.copybuttonoutlet.setImage(notcheckedImageToCopy, forState: .Normal)
                        //cell.copybuttonoutlet.tintColor = UIColorFromRGB(0xC6C6C6)
                        cell.copybuttonoutlet.selected = false
                    } else {
                       // cell.copybuttonoutlet.setImage(checkedImageToCopy, forState: .Normal)
                        //cell.copybuttonoutlet.tintColor = UIColorFromRGB(0x61C791)
                        cell.copybuttonoutlet.selected = true
                    }
                    
                    if cell.copybuttonoutlet.selected {
                        cell.copybuttonoutlet.tintColor = UIColorFromRGB(0x61C791)
                    } else {
                        cell.copybuttonoutlet.tintColor = UIColorFromRGB(0xC6C6C6)
                    }
                    
                    
                   // cell.copybuttonoutlet.setImage(notcheckedImageToCopy, forState: .Normal) // not sure if needed
                    cell.copybuttonoutlet.addTarget(self, action: "checktocopy:", forControlEvents: .TouchUpInside)
                    
                }//end of showcats if
                else {

                    
                    let tableSection = sections[sortedSections[indexPath.section]]
                    let tableItem = tableSection![indexPath.row]
                    
                    cell.itemName.text = (tableItem as NSDictionary).objectForKey("ItemName") as? String//["ItemName"]
                    cell.itemNote.text = (tableItem as NSDictionary).objectForKey("ItemNote") as? String
                    
                    cell.itemImage.image = (tableItem as NSDictionary).objectForKey("ItemImage2") as? UIImage
                    
                    let qty : String = (tableItem as NSDictionary).objectForKey("ItemQuantity") as! String
                    
                    let unit : String = (tableItem as NSDictionary).objectForKey("ItemUnit") as! String
                    
                    cell.itemQuantity.text = "\(qty) \(unit)"
                    

                   // cell.checkedButtonOutlet.hidden = true
                    cell.itemPrice.hidden = true
                    cell.itemQuantity.hidden = true
                    cell.checkedview.hidden = true
                    
                   
                    cell.copybuttonoutlet.hidden = false
                    //cell.copybuttonoutlet.setImage(notcheckedImageToCopy, forState: .Normal)
                   // cell.copybuttonoutlet.tintColor = UIColorFromRGB(0xC6C6C6)
                    cell.copybuttonoutlet.selected = false
                    cell.copybuttonoutlet.addTarget(self, action: "checktocopy:", forControlEvents: .TouchUpInside)
                    
                }
                ///// END IF ITEMS != 0 CASE
                //  } else {
                // items = 0 case
                
                
                // }
                
                return cell

                
                
        }
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
       // let ItemCellIdentifier = "NewListItem"
       // let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! ItemShopListCell
        
        if myeditingmode == false {
        
        checkitem(indexPath)
            
        } else {
            
            

            var cell = tableView.cellForRowAtIndexPath(indexPath) as! ItemShopListCell
            
            var checkbutton = cell.copybuttonoutlet
            
            if !checkbutton.selected {
                //means it is unchecked

                itemtocopy = itemsDataDict[indexPath.row]
                shoppingcheckedtocopy[indexPath.row] = true

                
                itemsinbuffer.append(itemtocopy)
                
                checkbutton.selected = true
                
                tableView.reloadData()

            } else if checkbutton.selected {
                //means it is checked
    
                
                shoppingcheckedtocopy[indexPath.row] = false
                
                
                var itemtoremove = itemsDataDict[indexPath.row]["ItemId"] as! String
                
                for ( var i = 0; i < itemsinbuffer.count; i++ ) {
                    
                    if itemsinbuffer[i]["ItemId"] as? String == itemtoremove {
                        
                        itemsinbuffer.removeAtIndex(i)
                        
                    }
                }
                
                checkbutton.selected = false
                
                tableView.reloadData()

                
            }
            

        
        }
        
        /*
        if myeditingmode == false {
        
        if showcats == false {
            
            if itemsDataDict[indexPath.row]["ItemIsChecked"] as! Bool == false {

            itemtoedit = itemsDataDict[indexPath.row]["ItemId"] as! String
            
            performSegueWithIdentifier("edititemmodalsegue", sender: self)
            
            } else {
               
            }

            
        } else {

            
      
            
                let section = indexPath.section
                let rowsect = indexPath.row
                
                
                let tableSection = sections[sortedSections[section]]
                let tableItem = tableSection![rowsect]
            
                if (tableItem as NSDictionary).objectForKey("ItemIsChecked") as! Bool == false {
            
                itemtoedit = (tableItem as NSDictionary).objectForKey("ItemId") as! String
                
                performSegueWithIdentifier("edititemmodalsegue", sender: self)
            
                } else {
                    
            }
            

            
        }

        } else {
            print("editing mode enabled")
        }
       */

    }
    
    
    func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            
            
            
            switch editingStyle {

                
            case .Delete:
                // remove the deleted item from the model
                if self.showcats == false {
                  //  self.swipedeleteitem(indexPath)
                    
                    self.deleteitem(indexPath)
                    //better to use usual
                    
                } else {
                    //showcats == true case
                    
                    // let button = sender as UIButton
                    // let view = button.superview!
                    // let cell = view.superview as! ItemShopListCell
                    
                    // var position: CGPoint = sender.convertPoint(CGPointZero, toView: self.tableView)
                    // if let indexPathIteminSection = self.tableView.indexPathForRowAtPoint(position)
                    //{
                    let section = indexPath.section//indexPathIteminSection.section
                    let rowsect = indexPath.row//indexPathIteminSection.row
                    
                    
                    var tableSection = self.sections[self.sortedSections[section]]
                    let tableItem = tableSection![rowsect]
                    
                    // itemtodelete = (tableItem as NSDictionary).objectForKey("ItemId") as! String
                    
                    /////////// CODE OF DELETETION
                    //println(indexPathDelete!.row)
                    self.itemtodelete = (tableItem as NSDictionary).objectForKey("ItemId") as? String
                    // Remains the same
                    self.dictionary.removeValueForKey("ItemId")
                    self.dictionary.removeValueForKey("ItemName")
                    self.dictionary.removeValueForKey("ItemNote")
                    // dictionary.removeValueForKey("ItemImage")
                    self.dictionary.removeValueForKey("ItemImage2")
                    self.dictionary.removeValueForKey("ItemImagePath")
                    self.dictionary.removeValueForKey("ItemQuantity")
                    self.dictionary.removeValueForKey("ItemTotalPrice")
                    self.dictionary.removeValueForKey("ItemUnit")
                    self.dictionary.removeValueForKey("ItemIsChecked")
                    self.dictionary.removeValueForKey("ItemCategory")
                    self.dictionary.removeValueForKey("itemCategoryName")
                    self.dictionary.removeValueForKey("ItemOneUnitPrice")
                    self.dictionary.removeValueForKey("ItemIsFav")
                    self.dictionary.removeValueForKey("ItemPerUnit")
                    
                    self.dictionary.removeValueForKey("ItemCreation")
                    self.dictionary.removeValueForKey("ItemUpdate")
                    
                    
                    let thissectionsname : String = self.sortedSections[section]
                    
                    for ( var i = 0; i < self.sections[thissectionsname]!.count; i++ ) {
                        
                        
                        // if thisarray[i]["ItemId"] as? String == itemtocheck {
                        if self.sections[thissectionsname]![i]["ItemId"] as? String == self.itemtodelete {
                            
                            self.sections[thissectionsname]!.removeAtIndex(i)
                            
                            break;
                            
                        }
                    }
                    
                    let idtodelete : String = (tableItem as NSDictionary).objectForKey("ItemId") as! String
                    var indextodelete = Int()
                    
                    
                    for ( var i = 0; i < itemsDataDict.count; i++ ) {
                        
                        //if let newid : String = itemsDataDict[i]["ItemId"] as? String {
                        if itemsDataDict[i]["ItemId"] as? String == self.itemtodelete {
                            //idtodelete = newid
                            indextodelete = i
                            
                            itemsDataDict.removeAtIndex(i)
                            
                        }
                    }
                    
                    /*
                    dispatch_async(dispatch_get_main_queue(), {
                        let querynew = PFQuery(className:"shopItems")
                        querynew.whereKey("itemUUID", equalTo: idtodelete)
                        querynew.getFirstObjectInBackgroundWithBlock() {
                            (itemList: PFObject?, error: NSError?) -> Void in
                            if error != nil {
                                print(error)
                            } else if let itemList = itemList {
                                
                                itemList.deleteInBackground()
                                
                            }
                        }
                    })
                    */
                    
                    let querynew1 = PFQuery(className:"shopItems")
                    querynew1.fromLocalDatastore()
                    //  querynew1.getObjectInBackgroundWithId(itemtodelete!) {
                    querynew1.whereKey("itemUUID", equalTo: idtodelete)
                    querynew1.getFirstObjectInBackgroundWithBlock() {
                        (itemList: PFObject?, error: NSError?) -> Void in
                        if error != nil {
                            print(error)
                        } else if let itemList = itemList {
                            itemList.unpinInBackground()
                            
                        }
                        
                    }
                    
                    
                    self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    
                    // NOW IT WORKS!
                    if self.sections[thissectionsname]! == [] {
                        //if sections[thissectionsname]!.count == 0 {
                        self.sections.removeValueForKey(thissectionsname)
                        self.sortedSections.removeAtIndex(section)//[section]
                        
                        
                        
                        //sections[sortedSections[section]]?.removeAll(keepCapacity: true)
                        tableView.reloadData()
                    }
                    
                    
                    tableView.reloadData()
                    
                    self.summationPrices()
                    self.summationcheckedPrices()
                    self.countitems()
                    self.countchecked()
                    self.itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(self.itemsoverallqty))/\(String(self.checkeditemsqty))"
                    self.showprogress()
                    //self.itemschecked.text = String(self.checkeditemsqty)
                    
                    
                    /////////// END CODE
                    //}
                    
                    
                    
                }
                
                // self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            default:
                return
            }
            
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        
        // Maybe
       /* if tableView.editing == true {
        let ItemCellIdentifier = "NewListItem"
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! ItemShopListCell
        
        cell.editItemOutlet.hidden = true
        cell.checkedButtonOutlet.hidden = true
        cell.copybuttonoutlet.hidden = false
        }
        */ //DOESN'T WORK LIKE THIS
        if myeditingmode == false {
        return true
        } else {
            return false
        }
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func UIColorFromRGBalpha(rgbValue: UInt, alp: Double) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alp)//(1.0)
        )
    }
    
    /*
    func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
        
        let ItemCellIdentifier = "NewListItem"
        let cell = tableView.dequeueReusableCellWithIdentifier(ItemCellIdentifier, forIndexPath: indexPath) as! ItemShopListCell
        
        cell.editItemOutlet.hidden = true
        cell.checkedButtonOutlet.hidden = true
        cell.copybuttonoutlet.hidden = false
    }
*/
  
    
    func addtofavs(itemid: String) {
        

        for item in itemsDataDict {
            if item["ItemId"] as! String == itemid {
                
                var shopItem = PFObject(className:"shopItems")
                var uuid = NSUUID().UUIDString
                var itemid = "shopitem\(uuid)"
                
                shopItem["itemUUID"] = itemid
                shopItem["itemName"] = item["ItemName"]
                shopItem["itemNote"] = item["ItemNote"]
                
                //shopItem["itemQuantity"] = itemQuantityOutlet.text
                shopItem["itemQuantity"] = item["ItemQuantity"]
                shopItem["itemPriceS"] = item["ItemOneUnitPrice"]
                shopItem["TotalSumS"] = item["ItemTotalPrice"]
                
                shopItem["ItemsList"] = ""
                
                shopItem["belongsToUser"] = PFUser.currentUser()!.objectId!
                
                
                shopItem["itemUnit"] = item["ItemUnit"]
                
                shopItem["perUnit"] = item["ItemPerUnit"]
                
                
                shopItem["chosenFromHistory"] = false
                shopItem["itemImage"] = NSNull()
                shopItem["isChecked"] = false
                
                shopItem["Category"] = item["ItemCategory"]
                
                shopItem["isCatalog"] = item["ItemIsCatalog"]
                
                shopItem["originalInCatalog"] = item["ItemOriginal"]
                
                shopItem["isFav"] = true
                
                shopItem["chosenFromFavs"] = false
                
                var date = NSDate()
                
                shopItem["CreationDate"] = date
                shopItem["UpdateDate"] = date
                
                shopItem["ServerUpdateDate"] = date.dateByAddingTimeInterval(-120)
                
                shopItem["isHistory"] = false //for filtering purposes when deleting the list and all its items
                shopItem["isDeleted"] = false
                
                // self.saveImageLocally(imageData)
                
                
                shopItem["defaultpicture"] = item["ItemIsDefPict"]
                shopItem["OriginalInDefaults"] = item["ItemOriginalInDefaults"]
                
                
                if item["ItemIsDefPict"] as! Bool == true {
                    shopItem["itemImage"] = NSNull()
                    
                    
                    
                } else {
                    
                    
                    shopItem["itemImage"] = NSNull()//imageFile
                    
                }
                
                
                shopItem["imageLocalPath"] = item["ItemImagePath"]
                //self.imagePath
                
                shopItem.pinInBackgroundWithBlock({ (success, error) -> Void in
                    if success {
                        
                        print("saved item")
                        
                    } else {
                        print("no id found")
                    }
                    
                    
                    
                    
                })

                break;
            }
        }
        
        addedindicator.alpha = 1
        addedindicator.fadeOut()
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .Normal, title: "    ") { (action , indexPath ) -> Void in
            
            
            self.editing = false
            if self.showcats == false {

                self.deleteitem(indexPath)
            } else {
                let section = indexPath.section//indexPathIteminSection.section
                let rowsect = indexPath.row//indexPathIteminSection.row
                
                
                var tableSection = self.sections[self.sortedSections[section]]
                let tableItem = tableSection![rowsect]
                
                /////////// CODE OF DELETETION
                //println(indexPathDelete!.row)
                self.itemtodelete = (tableItem as NSDictionary).objectForKey("ItemId") as? String
                // Remains the same
                self.dictionary.removeValueForKey("ItemId")
                self.dictionary.removeValueForKey("ItemName")
                self.dictionary.removeValueForKey("ItemNote")
                // dictionary.removeValueForKey("ItemImage")
                self.dictionary.removeValueForKey("ItemImage2")
                self.dictionary.removeValueForKey("ItemImagePath")
                self.dictionary.removeValueForKey("ItemQuantity")
                self.dictionary.removeValueForKey("ItemTotalPrice")
                self.dictionary.removeValueForKey("ItemUnit")
                self.dictionary.removeValueForKey("ItemIsChecked")
                self.dictionary.removeValueForKey("ItemCategory")
                self.dictionary.removeValueForKey("itemCategoryName")
                self.dictionary.removeValueForKey("ItemOneUnitPrice")
                self.dictionary.removeValueForKey("ItemIsFav")
                self.dictionary.removeValueForKey("ItemPerUnit")
                
                self.dictionary.removeValueForKey("ItemCreation")
                self.dictionary.removeValueForKey("ItemUpdate")
                
                
                let thissectionsname : String = self.sortedSections[section]
                
                for ( var i = 0; i < self.sections[thissectionsname]!.count; i++ ) {
                    
                    
                    // if thisarray[i]["ItemId"] as? String == itemtocheck {
                    if self.sections[thissectionsname]![i]["ItemId"] as? String == self.itemtodelete {
                        
                        self.sections[thissectionsname]!.removeAtIndex(i)
                        
                        break;
                        
                    }
                }
                
                let idtodelete : String = (tableItem as NSDictionary).objectForKey("ItemId") as! String
                var indextodelete = Int()
                
                
                for ( var i = 0; i < itemsDataDict.count; i++ ) {
                    
                    //if let newid : String = itemsDataDict[i]["ItemId"] as? String {
                    if itemsDataDict[i]["ItemId"] as? String == self.itemtodelete {
                        //idtodelete = newid
                        indextodelete = i
                        
                        itemsDataDict.removeAtIndex(i)
                        
                    }
                }
              

                let querynew1 = PFQuery(className:"shopItems")
                querynew1.fromLocalDatastore()
                //  querynew1.getObjectInBackgroundWithId(itemtodelete!) {
                querynew1.whereKey("itemUUID", equalTo: idtodelete)
                querynew1.getFirstObjectInBackgroundWithBlock() {
                    (itemList: PFObject?, error: NSError?) -> Void in
                    if error != nil {
                        print(error)
                    } else if let itemList = itemList {
                        itemList.unpinInBackground()
                        
                    }
                    
                }
                
                
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                
                // NOW IT WORKS!
                if self.sections[thissectionsname]! == [] {
                    
                    self.sections.removeValueForKey(thissectionsname)
                    self.sortedSections.removeAtIndex(section)//[section]

                    tableView.reloadData()
                }
                
                
                tableView.reloadData()
                
                self.summationPrices()
                self.summationcheckedPrices()
                self.countitems()
                self.countchecked()
                self.itemsoverall.text = "\(NSLocalizedString("items", comment: "")) \(String(self.itemsoverallqty))/\(String(self.checkeditemsqty))"
                self.showprogress()
                
                
            }
        }
        
        if let adelete = UIImage(named: "4DeleteButton50") {
            deleteAction.backgroundColor = UIColor.imageWithBackgroundColor(adelete, bgColor: UIColorFromRGB(0xF23D55), w: 50, h: 50)
        }
        

        
        // EDIT
         let editAction = UITableViewRowAction(style: .Normal, title: "    ") { (action , indexPath ) -> Void in
            
            if self.myeditingmode == false {
                
                if self.showcats == false {
                    
                   // if itemsDataDict[indexPath.row]["ItemIsChecked"] as! Bool == false {
                        
                        self.itemtoedit = itemsDataDict[indexPath.row]["ItemId"] as! String
                        
                        self.performSegueWithIdentifier("edititemmodalsegue", sender: self)
                        
                    //} else {
                        
                   // }
                    
                    
                } else {

                    let section = indexPath.section
                    let rowsect = indexPath.row
                    
                    let tableSection = self.sections[self.sortedSections[section]]
                    let tableItem = tableSection![rowsect]
                    
                   // if (tableItem as NSDictionary).objectForKey("ItemIsChecked") as! Bool == false {
                        
                        self.itemtoedit = (tableItem as NSDictionary).objectForKey("ItemId") as! String
                        
                        self.performSegueWithIdentifier("edititemmodalsegue", sender: self)
                        
                   // } else {
                        
                  //  }
                    
                    
                    
                }
                
            } else {
                print("editing mode enabled")
            }
            
        }
        
        if let editpict = UIImage(named: "4EditButton50") {
        editAction.backgroundColor = UIColor.imageWithBackgroundColor(editpict, bgColor: UIColorFromRGB(0x7ED0A5), w: 50, h: 50)
        }
        
        // Add to favourites
        let favAction = UITableViewRowAction(style: .Normal, title: "    ") { (action , indexPath ) -> Void in
            
            if self.myeditingmode == false {
                
                if self.showcats == false {
                    
                    self.itemtofavs = itemsDataDict[indexPath.row]["ItemId"] as! String
                    
                    print(self.itemtofavs)
                    
                    self.addtofavs(self.itemtofavs)
                    
                } else {
                    
                    let section = indexPath.section
                    let rowsect = indexPath.row
                    
                    let tableSection = self.sections[self.sortedSections[section]]
                    let tableItem = tableSection![rowsect]
                    
                    print(self.itemtofavs)
  
                    self.itemtofavs = (tableItem as NSDictionary).objectForKey("ItemId") as! String
                    
                    self.addtofavs(self.itemtofavs)
                    
                }
                
            } else {
                print("editing mode enabled")
            }
            
        }
        
        if let favpict = UIImage(named: "4AddFav50") {
            favAction.backgroundColor = UIColor.imageWithBackgroundColor(favpict, bgColor: UIColorFromRGB(0xA2AF36), w: 50, h: 50)
        }
        
       // if self.myeditingmode == false {
        return [deleteAction, editAction, favAction]//, shareAction]
       // } else {
       //     return []
       // }
    }
    /*
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
    
    }
    
    
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    var moveImage = shoppingListItemsImages[fromIndexPath.row]
    var moveId = shoppingListItemsIds[fromIndexPath.row]
    var moveName = shoppingListItemsNames[fromIndexPath.row]
    var moveNote = shoppingListItemsNotes[fromIndexPath.row]
    var moveQuantity = shoppingListItemsQuantity[fromIndexPath.row]
    var movePrice = shoppingListItemsPrices[fromIndexPath.row]
    //var movDelButton =
    shoppingListItemsImages.removeAtIndex(fromIndexPath.row)
    shoppingListItemsImages.insert(moveImage, atIndex: toIndexPath.row)
    
    shoppingListItemsIds.removeAtIndex(fromIndexPath.row)
    shoppingListItemsIds.insert(moveId, atIndex: toIndexPath.row)
    
    shoppingListItemsNames.removeAtIndex(fromIndexPath.row)
    shoppingListItemsNames.insert(moveName, atIndex: toIndexPath.row)
    
    shoppingListItemsNotes.removeAtIndex(fromIndexPath.row)
    shoppingListItemsNotes.insert(moveNote, atIndex: toIndexPath.row)
    
    shoppingListItemsQuantity.removeAtIndex(fromIndexPath.row)
    shoppingListItemsQuantity.insert(moveQuantity, atIndex: toIndexPath.row)
    
    shoppingListItemsPrices.removeAtIndex(fromIndexPath.row)
    shoppingListItemsPrices.insert(movePrice, atIndex: toIndexPath.row)
    
    
    }
    */
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    
    //// FINDOBJECTS PATTERN
    /* querycat.findObjectsInBackgroundWithBlock {
    (objects: [AnyObject]?, error: NSError?) -> Void in
    
    if error == nil {
    
    println("Successfully retrieved \(objects!.count) scores.")
    if let categoriesids = objects as? [PFObject] {
    for object in categoriesids {
    
    
    }
    
    
    }
    } else {
    // Log details of the failure
    println("Error: \(error!) \(error!.userInfo!)")
    }
    }
    */
    
 
    
    /*
    func popoverPresentationControllerShouldDismissPopover(popoverPresentationController: UIPopoverPresentationController) -> Bool {
    
    }
    */
    
    
    
    
    
    ///// END ALERT CODE
    
    
    ////// INFO ABOUT CURRENCIES
    ///// LOCAL CODE AND SYMBOL
    /*
    let local = NSLocale.currentLocale()
    var symbol = local.objectForKey(NSLocaleCurrencySymbol)
    var code = local.objectForKey(NSLocaleCurrencyCode)
    */
    
    /// GET ALL CURRENCIES
    /*
    let currencies = NSLocale.ISOCurrencyCodes()
    
    
    
    var arrayofcodesandsymbols = [[AnyObject]]()
    
    for currency in currencies { //Currency = "USD" etc
    let localeComponents = [NSLocaleCurrencyCode: currency]
    let localeIdentifier = NSLocale.localeIdentifierFromComponents(localeComponents)
    let locale = NSLocale(localeIdentifier: localeIdentifier)
    let currencySymbol = locale.objectForKey(NSLocaleCurrencySymbol) as! String
    
    arrayofcodesandsymbols.append([currency,currencySymbol])
    
    }
    
    println(arrayofcodesandsymbols)
    */
    
}
