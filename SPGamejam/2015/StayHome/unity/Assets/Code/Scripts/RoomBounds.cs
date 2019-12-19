using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(SpriteRenderer))]
public class RoomBounds : MonoBehaviour
{
    private EdgeCollider2D floor;
    private EdgeCollider2D walls;
    private SpriteRenderer spriteRenderer;

    public LayerMask FloorMask;
    public LayerMask WallMask;
    public bool IsLeftOpen;
    public bool IsRightOpen;

    void Awake()
    {
        this.spriteRenderer = this.GetComponent<SpriteRenderer>();

        // We could just create two EdgeCollider2D here, but by doing that we couldn't have distinct layers for collision
        GameObject walls = new GameObject("walls");
        walls.transform.SetParent(this.transform, false);
        this.floor = this.gameObject.AddComponent<EdgeCollider2D>();
        this.walls = walls.gameObject.AddComponent<EdgeCollider2D>();
        float spriteWidthHalf = this.spriteRenderer.sprite.rect.width / 100 / 2;
        float spriteHeightHalf = this.spriteRenderer.sprite.rect.height / 100 / 2;
        List<Vector2> points = new List<Vector2>();

        this.floor.points = new Vector2[] {
            new Vector2(-spriteWidthHalf, -0.42f),
            new Vector2(spriteWidthHalf, -0.42f)
        };

        if (!this.IsLeftOpen)
            points.Add(new Vector2(-spriteWidthHalf, -0.42f));

        points.Add(new Vector2(-spriteWidthHalf, spriteHeightHalf));
        points.Add(new Vector2(spriteWidthHalf, spriteHeightHalf));

        if (!this.IsRightOpen)
            points.Add(new Vector2(spriteWidthHalf, -0.42f));

        this.walls.points = points.ToArray();
        this.gameObject.layer = this.FloorMask.GetLayer();
        walls.layer = this.WallMask.GetLayer();
    }
}
