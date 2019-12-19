using System;
using UnityEngine;

public class Hidden : MonoBehaviour {

    private RevealableObject revealable;

    void Awake()
    {
        this.revealable = this.GetComponent<RevealableObject>();

        if (this.revealable == null)
            throw new NullReferenceException("A RevealableObject based component is missing in this GameObject.");

        this.revealable.OnChanged += this.changed;

        foreach (Transform child in transform)
            child.gameObject.SetActive(false);
    }

    private void changed()
    {
        if (this.revealable.IsRevealed)
        {
            foreach (Transform child in transform)
                child.gameObject.SetActive(true);
        }
        else if (!this.revealable.IsRevealed)
        {
            foreach (Transform child in transform)
                child.gameObject.SetActive(false);
        }
    }
}
