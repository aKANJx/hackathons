using UnityEngine;

[RequireComponent(typeof(BoxCollider2D))]
public class OpenableObject : RevealableObject
{
    private BoxCollider2D boxCollider2D;
    private bool isInteractable;
    private bool isInputLocked;

    public SpriteRenderer Sprite;
    public Sprite Open;
    public Sprite Closed;
    public bool IsOpenByDefault;
    public bool IsResettingBounds;

    void Awake()
    {
        if (this.Sprite == null)
            this.Sprite = this.GetComponent<SpriteRenderer>();

        this.boxCollider2D = this.GetComponent<BoxCollider2D>();
        this.boxCollider2D.isTrigger = true;
        this.Sprite.sprite = this.IsOpenByDefault ? this.Open : this.Closed;
    }

    void Update()
    {
        if (!this.isInteractable)
            return;

        if (!this.boxCollider2D.isTrigger)
            this.isInteractable = false;

        bool isDirty = false;

        if (Input.GetAxisRaw("Jump") == 1 && !this.isInputLocked)
        {
            this.IsRevealed = !this.IsRevealed;
            this.isInputLocked = true;
            isDirty = true;

            if (this.OnChanged != null)
                this.OnChanged();
        }
        else if (Input.GetAxisRaw("Jump") == 0 && this.isInputLocked)
        {
            this.isInputLocked = false;
            isDirty = true;
        }

        if (isDirty)
        {
            this.Sprite.sprite = this.IsRevealed ? this.Open : this.Closed;

            if (this.IsResettingBounds)
            {
                this.boxCollider2D.size = this.Sprite.bounds.size;
                this.boxCollider2D.offset = this.Sprite.sprite.bounds.center;
            }
        }
    }

    void OnTriggerEnter2D(Collider2D other)
    {
        if (other.gameObject != Player.Instance.gameObject)
            return;

        this.isInteractable = true;
    }

    void OnTriggerExit2D(Collider2D other)
    {
        if (other.gameObject != Player.Instance.gameObject)
            return;

        this.isInteractable = false;
    }
}
