using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NamesDB : MonoBehaviour
{
    public static Stack<string> shared = new Stack<string>(new[] {"Marcos", "Giovana", "Jean", "Roberto"});
}
