using System.Collections;
using UnityEngine;

public enum VerticalInput
{
    None = 0,
    Up = 1,
    Down = -1,
}

public enum HorizontalInput
{
    None = 0,
    Left = -1,
    Right = 1,
}

public class Portal : InteractableObject
{
    public VerticalInput VerticalInput = VerticalInput.None;
    public HorizontalInput HorizontalInput = HorizontalInput.None;
    public GameObject SpawnObject;

    void OnTriggerStay2D(Collider2D other)
    {
        if (Main.Instance.State != GameState.Playing)
            return;

        if (other.gameObject != Player.Instance.gameObject)
            return;

        if (Player.Instance.IsJumping)
            return;

        if (this.SpawnObject == null)
            return;

        float vertical = Input.GetAxisRaw("Vertical");
        float horizontal = Input.GetAxisRaw("Horizontal");

        if ((vertical != 0 && vertical == (int)this.VerticalInput) || (horizontal != 0 && horizontal == (int)this.HorizontalInput))
            Player.Instance.GoToRoom(this.SpawnObject);
    }
}
