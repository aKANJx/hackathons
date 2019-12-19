using UnityEngine;

public static class Extensions
{
    public static int GetLayer(this LayerMask mask)
    {
        return (int)Mathf.Log(mask.value, 2);
    }
}
