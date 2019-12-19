using System;
using System.Collections;
using UnityEngine;

[RequireComponent(typeof(Rigidbody2D))]
public class Player : ItemChain
{
    private Rigidbody2D rigid2D;
    private float timer;
    private bool isDirty;

    public static Player Instance;
    public SpriteRenderer Sprite;
    public AnimationCurve Move;
    public Sprite Stand;
    public Sprite Jump;
    [HideInInspector]
    public ItemChain Last;
    [HideInInspector]
    public ItemChain Selected;
    public float Face { get; private set; }
    public float RotationSpeed = 5;
    public float WalkSpeed = 10;    
    public float JumpSpeed = 4;
    public float PortalTime = 0.67f;
    [HideInInspector]
    public Room Room;
    public bool IsJumping { get; private set; }
    public bool IsFalling { get; private set; }
        
    protected override void Awake()
    {
        base.Awake();
        Instance = this;
        this.Selected = this;
        this.Last = this;
        this.Face = 1;
        this.rigid2D = this.GetComponent<Rigidbody2D>();

        if (this.Sprite == null)
            throw new NullReferenceException("Sprite is missing in Editor.");
    }

    void FixedUpdate()
    {
        float direction = 0;
        int directionInt = (int)Input.GetAxisRaw("Horizontal");
        float jump = Input.GetAxisRaw("Vertical");
        this.IsJumping = this.rigid2D.velocity.y != 0;
        this.IsFalling = this.rigid2D.velocity.y < -0.1f;

        switch (Main.Instance.State)
        {
            case GameState.Entering:
            {
                this.rigid2D.velocity = Vector2.zero;
                break;
            }

            case GameState.Playing:
            {
                if (directionInt != 0)
                    this.Face = directionInt;

                if (jump == 1 && !this.IsJumping)
                    this.rigid2D.velocity += Vector2.up * this.JumpSpeed;

                direction = Input.GetAxis("Horizontal");
                break;
            }

            case GameState.Inventory:
            {
                directionInt *= -(int)this.Face;

                if (directionInt == 0 && this.isDirty)
                    this.isDirty = false;
                
                if (this.isDirty)
                    break;

                if (directionInt == 1)
                {
                    this.isDirty = true;
                    this.Selected = this.Selected.Child;

                    if (this.Selected == null)
                        this.Selected = this;
                }
                else if (directionInt == -1)
                {
                    this.isDirty = true;
                    this.Selected = this.Selected.Parent;

                    if (this.Selected == null)
                        this.Selected = this.Last;
                }

                break;
            }
        }

        float walkSpeed = this.WalkSpeed;
        float speed = Mathf.Abs(direction) + 1;

        //if (Application.isEditor)
        {
            if (Input.GetKey(KeyCode.LeftShift))
            {
                walkSpeed *= 2;
                speed *= 2;
            }
        }

        this.rigid2D.velocity = new Vector2(direction * walkSpeed, this.rigid2D.velocity.y);
        this.timer += Time.deltaTime * speed;
        float curve = this.Move.Evaluate(this.timer);
        float curveHalf = this.Move.Evaluate(this.timer / 2);
        float flip = ((this.Face - 1) / 2) * 180;
        float move = (curveHalf * 2 - 1) * 8;
        float walk = this.IsJumping ? 0 : direction * curve * 0.07f;
        this.Sprite.transform.localPosition = new Vector3(0, walk * this.Face, 0);
        //this.Sprite.transform.rotation = Quaternion.Lerp(this.Sprite.transform.rotation, Quaternion.Euler(new Vector3(0, flip, move)), Time.deltaTime * this.RotationSpeed);
        float flipLast = this.Sprite.transform.rotation.eulerAngles.y;
        this.Sprite.transform.rotation = Quaternion.Euler(new Vector3(0, Mathf.LerpAngle(flipLast, flip, Time.deltaTime * this.RotationSpeed), move));
        this.Sprite.sprite = this.IsFalling ? this.Jump : this.Stand;
    }

    public void GoToRoom(GameObject spawnPoint)
    {
        this.Room = spawnPoint.GetComponentInParent<Room>();
        Title.Instance.SetTitle(this.Room.Name);
        Main.Instance.State = GameState.Entering;
        this.transform.SetParent(spawnPoint.transform.parent, false);
        this.transform.localPosition = spawnPoint.transform.localPosition;
        this.StartCoroutine(this.entered());
    }

    private IEnumerator entered()
    {
        yield return new WaitForSeconds(this.PortalTime);
        Main.Instance.State = GameState.Playing;
    }
}
