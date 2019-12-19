using System;
using UnityEngine;

public class Shadow : MonoBehaviour
{
    private RaycastHit2D hit;

    public GameObject ShadowCaster;
    public LayerMask FloorMask;

    void Awake()
    {
        if (this.ShadowCaster == null)
            throw new NullReferenceException("ShadowCaster is missing in Editor.");
    }

    void FixedUpdate()
    {
        Vector3 position = this.ShadowCaster.transform.position;
        Vector2 end = position;
        end.y -= 1;
        this.hit = Physics2D.Linecast(position, end, this.FloorMask, position.z - 0.2f, position.z + 0.2f);
    }

    void LateUpdate()
    {
        Vector3 position = this.transform.position;
        position.x = this.hit.point.x;
        position.y = this.hit.point.y;
        this.transform.position = position;
    }
}
