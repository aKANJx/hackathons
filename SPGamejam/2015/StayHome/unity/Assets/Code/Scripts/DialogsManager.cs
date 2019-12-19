using System.Collections.Generic;
using UnityEngine;

public class DialogsManager : MonoBehaviour
{
    // declaration
    public Dictionary<string, string> ItemTips = new Dictionary<string, string>();

    public static DialogsManager Instance;

    public string[] boyCutscenes = new string[] {
		"But mom, I don't wanna go to Aunt Bernette's! I want to play vidjagaaaaahmes.",
		"Dang it, I don't wanna...",
	};

    public string[] momCutscenes = new string[] {
		"Alright, sweetie, pack your stuff. We're leaving in 3 hours."
	};

    public string[] fatherCutscenes = new string[] {
		"No more of that, son. Pack your stuff, car drives off at 3 PM."
	};

    public string[] drekCutscenes = new string[] {
		"I say we ditch those losers and stay here, but first, we need GEAR.",
		"Take a stroll around the house, see if ya can find anything we can use and bring it back. We'll MacGyver our way out.",
		"I'll hold down the fort. Ain't much a plush like me can do other than give ideas, ya know."
	};

    public string[] drekAdvices = new string[] {
		"We need to find a way to fool those guys. Do ya have any long lost twin brothers?",
		"Look, the only way (for now, because the devs didn't have time to implement multiple solutions) for us to stay here is to trick your parents.",
		"Here's a thought: why don't ya go on the trip… but also DON'T go on the trip? That do anything for ya?",
		"Got the time?",
		"I'd tell ya what time it is, but Mama Drek never taught me math. Stay in school, kids.",
		"If ya have anything interesting on ya, leave it on the desk. Better than dragging it around for no reason."
	};

    public string[] momAdvices = new string[] {
		"Have you packed your things, sweetie?",
		"We're leaving in a bit, honey.",
		"Don't forget your incredibly creepy doll, sweetie.",
	};

    public string[] fatherAdvices = new string[] {
		"Look at this +1 biceps, son!",
		"BEEF CAKE! Also, get your stuff ready.",
		"We're leaving at 3 o'clock, son, so get your things ready."
	};

    public void Awake()
    {
        Instance = this;
    }

    public void Start()
    {
        this.ItemTips["Flour Bag"] = "The ultimate test for an animator. Can also be turned into pie through magic.";
        this.ItemTips["Closed Paint Can"] = "A heavy can of pink paint with it lid sealed tight. If only you had big, strong muscles. You also wouldn't mind having brains, looks and money while you're at it.";
        this.ItemTips["Open Paint Can"] = "A heavy can of pink paint. The lid is now gone and you can see the paint is really damn pink, like gum. Maybe it even tastes like it?...... Answer: no.";
        this.ItemTips["Golden Key"] = "Why do we have a solid gold key that opens the hallway cabinet?";
        this.ItemTips["Shirt Buttons"] = "These look like ghoulish eyes, devoid of any emotion or soul. They are also creepy and very spoopy.";
        this.ItemTips["Broken Broom Stick"] = "It wasn't your fault! Mom says accidents happen every time, especially in the bedroom. It's still sturdy enough and very long, so not that useless.";
        this.ItemTips["Broom Head"] = "Oops. Well, on the bright side, you have a broom head. That's good, right?";
        this.ItemTips["Hair Comb"] = "Any kid your age has GOT to have an iconic accessory to establish style. At least you think it's iconic. It's iconic if you say it is, right?";
        this.ItemTips["Tuft of Grass"] = "It's grass. It's green. Insects love it. Seriously, what else would you expect, a 30-page essay on photosynthesis?";
        this.ItemTips["Glue"] = "Fast-working super glue. Keep away from the children it'd be funny if not for the fact you tried to eat glue in class last week.";
        this.ItemTips["Cookie"] = "Chocolate chip goodness that brings joy to every kid. Not sure how it can be useful, but it's a snack in case you get stuck in the car for hours.";
        this.ItemTips["Shampoo Bottle"] = "Well, if you can't stop the trip, at least your hair will soft and smell like lavander.";
        this.ItemTips["Dad's Trophy"] = "Beer lifting and hotdog eating champion 1973 Dad says it was his proudest moment. Mom says it speaks volumes about his life.";
        this.ItemTips["Blue Candy"] = "Blue Candy you found in your Dad's things. Not sure how it tastes like, but you've seen how happily Dad eats these, so they must be amazing";
    }
}
