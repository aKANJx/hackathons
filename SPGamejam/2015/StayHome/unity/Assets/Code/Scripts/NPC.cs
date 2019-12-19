using System;
using UnityEngine;

[RequireComponent(typeof(Rigidbody2D))]
public class NPC : ItemChain
{
    private Rigidbody2D rigid2D;
    private float timer;
    private bool isDirty;

    public SpriteRenderer Sprite;
    public AnimationCurve Move;
    public float Face = 1;
    public float RotationSpeed = 5;
    public float WalkSpeed = 10;
    public float JumpSpeed = 4;
    public bool IsFalling { get; private set; }

    protected override void Awake()
    {
        base.Awake();
        this.rigid2D = this.GetComponent<Rigidbody2D>();

        if (this.Sprite == null)
            throw new NullReferenceException("Sprite is missing in Editor.");
    }

    void FixedUpdate()
    {
        float direction = 0;
        this.IsFalling = this.rigid2D.velocity.y < -0.1f;

        switch (Main.Instance.State)
        {
            case GameState.Playing:
            {
                direction = this.Face;
                break;
            }
        }

        float speed = Mathf.Abs(direction) + 1;
        this.rigid2D.velocity = new Vector2(direction * this.WalkSpeed, this.rigid2D.velocity.y);
        this.timer += Time.deltaTime * speed;
        float curve = this.Move.Evaluate(this.timer);
        float curveHalf = this.Move.Evaluate(this.timer / 2);
        float flip = ((this.Face - 1) / 2) * 180;
        float move = (curveHalf * 2 - 1) * 8;
        float walk = direction * curve * 0.07f;
        this.Sprite.transform.localPosition = new Vector3(0, walk * this.Face, 0);
        float flipLast = this.Sprite.transform.rotation.eulerAngles.y;
        this.Sprite.transform.rotation = Quaternion.Euler(new Vector3(0, Mathf.LerpAngle(flipLast, flip, Time.deltaTime * this.RotationSpeed), move));
    }

    void OnCollisionEnter2D(Collision2D other)
    {
        this.Face *= -1;
    }
}
