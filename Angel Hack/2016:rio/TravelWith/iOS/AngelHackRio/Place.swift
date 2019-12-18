import Foundation
 
public class Place {
	public var baseDescription : String?
	public var latitude : Double?
	public var longitude : Double?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let place_list = Place.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Place Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Place]
    {
        var models:[Place] = []
        for item in array
        {
            models.append(Place(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let place = Place(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Place Instance.
*/
	required public init?(dictionary: NSDictionary) {

		baseDescription = dictionary["baseDescription"] as? String
		latitude = dictionary["latitude"] as? Double
		longitude = dictionary["longitude"] as? Double
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.baseDescription, forKey: "baseDescription")
		dictionary.setValue(self.latitude, forKey: "latitude")
		dictionary.setValue(self.longitude, forKey: "longitude")

		return dictionary
	}

}
