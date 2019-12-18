import Foundation

public class Guide {
	public var id : Int?
	public var name : String?
	public var photoURL : String?
    public var backgroundPhoto : String?
	public var language : Array<String>?
	public var place : Place?
	public var stars : Int?
	public var about : String?
	public var experiences : Int?
	public var recommendations : Array<Recommendations>?
	public var interests : Array<String>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let json4Swift_Base_list = Json4Swift_Base.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Json4Swift_Base Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Guide]
    {
        var models:[Guide] = []
        for item in array
        {
            models.append(Guide(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Json4Swift_Base Instance.
*/
	required public init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		photoURL = dictionary["photoURL"] as? String
        backgroundPhoto = dictionary["backgroundPhoto"] as? String
//		if (dictionary["language"] != nil) { language = Language.modelsFromDictionaryArray(array: dictionary["language"] as! NSArray) }
		if (dictionary["place"] != nil) { place = Place(dictionary: dictionary["place"] as! NSDictionary) }
		stars = dictionary["stars"] as? Int
		about = dictionary["about"] as? String
		experiences = dictionary["experiences"] as? Int
		if (dictionary["recommendations"] != nil) { recommendations = Recommendations.modelsFromDictionaryArray(array: dictionary["recommendations"] as! NSArray) }
//		if (dictionary["interests"] != nil) { interests = Interests.modelsFromDictionaryArray(dictionary["interests"] as! NSArray) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.photoURL, forKey: "photoURL")
        dictionary.setValue(self.backgroundPhoto, forKey: "backgroundPhoto")
		dictionary.setValue(self.place?.dictionaryRepresentation(), forKey: "place")
		dictionary.setValue(self.stars, forKey: "stars")
		dictionary.setValue(self.about, forKey: "about")
		dictionary.setValue(self.experiences, forKey: "experiences")

		return dictionary
	}

}
