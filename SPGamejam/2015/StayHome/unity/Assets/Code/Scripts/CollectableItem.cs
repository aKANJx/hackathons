using UnityEngine;

[RequireComponent(typeof(BoxCollider2D))]
public class CollectableItem : ItemChain
{
    private BoxCollider2D boxCollider2D;
    private Vector3 positionLast;
    private float followSpeed = 10;
    private float timer;

    public string Name;
    public string Description;

    protected override void Awake()
    {
        base.Awake();
        this.boxCollider2D = this.GetComponent<BoxCollider2D>();
        this.boxCollider2D.isTrigger = true;
    }

    void OnTriggerEnter2D(Collider2D other)
    {
        if (other.gameObject != Player.Instance.gameObject)
            return;

        this.Parent = Player.Instance.Last;
        this.Parent.Child = this;
        Player.Instance.Selected = this;
        Player.Instance.Last = this;
        this.boxCollider2D.enabled = false;

        if (this.transform.parent != null && this.transform.parent.parent != null)
            this.transform.SetParent(this.transform.parent.parent, true);
    }

    public void Drop()
    {
        this.boxCollider2D.enabled = true;

        if (this.Child != null)
            this.Child.Parent = this.Parent;

        Player.Instance.Selected = this.Parent;
        this.Parent = null;
        this.Child = null;
    }

    void FixedUpdate()
    {
        if (this.Parent == null)
            return;

        Vector3 distance = this.transform.position - this.positionLast;
        this.positionLast = this.transform.position;
        this.timer += distance.magnitude;
        float curve = Player.Instance.Move.Evaluate(this.timer * 2);
        float flip = ((Player.Instance.Face - 1) / 2) * 180;
        float move = (curve * 2 - 1) * 8;
        float walk = curve * 0.05f;

        this.transform.rotation = Quaternion.Lerp(this.transform.rotation, Quaternion.Euler(new Vector3(0, flip, move)), Time.deltaTime * Player.Instance.RotationSpeed);

        if (Main.Instance.State == GameState.Entering)
        {
            this.transform.position = this.Parent.transform.position + new Vector3(-Player.Instance.Face * this.boxCollider2D.size.x, walk, 0);
        }
        else
        {
            this.transform.position += (this.Parent.transform.position + new Vector3(-Player.Instance.Face * this.boxCollider2D.size.x, walk, 0) - this.transform.position) * Time.deltaTime * this.followSpeed;
        }
    }
}
