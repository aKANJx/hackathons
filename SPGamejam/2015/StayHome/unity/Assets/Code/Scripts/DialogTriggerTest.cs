using UnityEngine;

public class DialogTriggerTest : MonoBehaviour
{
    private Animator animator;
    private bool dialogIsShowing = false;

    void Start()
    {
        this.animator = this.gameObject.GetComponent<Animator>();
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            if (this.dialogIsShowing == false)
            {
                this.animator.SetTrigger("showDialog");
                this.dialogIsShowing = true;
            }
            else
            {
                this.animator.SetTrigger("hideDialog");
                this.dialogIsShowing = false;
            }
        }
    }
}
