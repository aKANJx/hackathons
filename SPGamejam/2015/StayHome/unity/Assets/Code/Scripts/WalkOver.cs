using UnityEngine;

[RequireComponent(typeof(BoxCollider2D))]
public class WalkOver : MonoBehaviour
{
    private BoxCollider2D boxCollider2D;
    private float threshold = -0.2f;
    private bool isTriggerOriginal;

    public LayerMask FloorMask;

    void Awake()
    {
        this.boxCollider2D = this.GetComponent<BoxCollider2D>();
        this.boxCollider2D.isTrigger = true;
        this.gameObject.layer = this.FloorMask.GetLayer();
    }

    void Update()
    {
        float playerY = Player.Instance.transform.position.y;
        float collisionTop = this.transform.position.y + this.boxCollider2D.offset.y + (this.boxCollider2D.size.y / 2f);
        this.boxCollider2D.isTrigger = playerY < collisionTop + this.threshold;
    }
}
