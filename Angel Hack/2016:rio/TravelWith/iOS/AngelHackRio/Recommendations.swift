import Foundation
 
public class Recommendations {
	public var name : String?
	public var photoURL : String?
	public var comments : String?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let recommendations_list = Recommendations.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Recommendations Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Recommendations]
    {
        var models:[Recommendations] = []
        for item in array
        {
            models.append(Recommendations(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let recommendations = Recommendations(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Recommendations Instance.
*/
	required public init?(dictionary: NSDictionary) {

		name = dictionary["name"] as? String
		photoURL = dictionary["photoURL"] as? String
		comments = dictionary["comments"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.photoURL, forKey: "photoURL")
		dictionary.setValue(self.comments, forKey: "comments")

		return dictionary
	}

}
