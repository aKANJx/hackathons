using System.Collections;
using UnityEngine;

[RequireComponent(typeof(SpriteRenderer))]
[RequireComponent(typeof(BoxCollider2D))]
public class InteractableObject : MonoBehaviour
{
    private Color colorOriginal;
    private SpriteRenderer spriteRenderer;
    private BoxCollider2D boxCollider2D;
    private Color blinkColor = Color.red;

    public bool IsHeightSensitive;

    void Awake()
    {
        this.spriteRenderer = this.GetComponent<SpriteRenderer>();
        this.boxCollider2D = this.GetComponent<BoxCollider2D>();
        this.boxCollider2D.isTrigger = true;
        this.colorOriginal = this.spriteRenderer.color;
        this.blinkColor.a = this.colorOriginal.a;

        if (this.IsHeightSensitive)
            return;

        Vector2 size = this.boxCollider2D.size;
        size.y = 2;
        this.boxCollider2D.size = size;
    }

    void OnTriggerEnter2D(Collider2D other)
    {
        if (other.gameObject != Player.Instance.gameObject)
            return;

        this.spriteRenderer.color = blinkColor;
        //this.StartCoroutine(this.blink());
    }

    void OnTriggerExit2D(Collider2D other)
    {
        if (other.gameObject != Player.Instance.gameObject)
            return;

        this.spriteRenderer.color = this.colorOriginal;
        //this.StartCoroutine(this.blink());
    }

    private IEnumerator blink()
    {
        this.spriteRenderer.color = blinkColor;
        yield return new WaitForSeconds(0.1f);
        this.spriteRenderer.color = this.colorOriginal;
    }
}
