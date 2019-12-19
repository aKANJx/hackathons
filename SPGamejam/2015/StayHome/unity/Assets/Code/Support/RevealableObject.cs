using System;
using UnityEngine;

public abstract class RevealableObject : MonoBehaviour
{
    public Action OnChanged;

    public bool IsRevealed { get; protected set; }
}
