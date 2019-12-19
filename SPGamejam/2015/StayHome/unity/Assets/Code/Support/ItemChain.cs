using UnityEngine;

public abstract class ItemChain : MonoBehaviour
{
    private Color colorOriginal;
    private float pulse;
    private float pulseSpeed = 10;

    [HideInInspector]
    public SpriteRenderer SpriteRenderer;
    [HideInInspector]
    public ItemChain Parent;
    [HideInInspector]
    public ItemChain Child;

    protected virtual void Awake()
    {
        this.SpriteRenderer = this.GetComponentInChildren<SpriteRenderer>();
        this.colorOriginal = this.SpriteRenderer.color;
    }

    protected virtual void Update()
    {
        if (Main.Instance.State != GameState.Inventory || Player.Instance.Selected != this)
        {
            if (this.pulse > 0)
            {
                this.SpriteRenderer.color = this.colorOriginal;
                this.pulse = 0;
            }

            return;
        }

        this.pulse += Time.deltaTime * this.pulseSpeed;
        Color color = this.SpriteRenderer.color;
        color.a = (Mathf.Cos(this.pulse) + 1) / 2;
        this.SpriteRenderer.color = color;
    }
}