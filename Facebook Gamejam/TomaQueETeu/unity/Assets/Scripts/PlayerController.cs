using System.Collections;
using System.Collections.Generic;
using UnityEngine;



public class PlayerController : MonoBehaviour
{
    float speed = 5.0f;
    float lastXTouchPosition;
    public PlayerType playerType = PlayerType.PC; 
    bool isFirstTouch = true;

    public enum PlayerType { P1, P2, PC };

    public Animator anim;

    public string playerName;
    public int playerIndex;

    void Start()
    {

        Debug.Log(lastXTouchPosition);

    }

    void Update()
    {

        if(playerType == PlayerType.P1) {
            //HandleMobileMovement();
            HandleMovement();
        }
    }

    void HandleMovement() {
        if (Application.platform == RuntimePlatform.IPhonePlayer || Application.platform == RuntimePlatform.Android) {
            HandleMobileMovement();
        }
        else {
            HandlePCMovement();
        }
    }

    void HandleMobileMovement() {
        if (Input.touchCount > 0) {
            float currentXTouchPosition = Input.GetTouch(0).position.x;
            float xDistance =  currentXTouchPosition - lastXTouchPosition;
            Debug.Log(xDistance);
            lastXTouchPosition = currentXTouchPosition;
            if (isFirstTouch) {
                isFirstTouch = false;
                return;
            }
            Vector3 position = new Vector3(Mathf.Clamp(transform.position.x+xDistance*Time.deltaTime, -3, 3), transform.position.y, transform.position.z);
            transform.position = position;
        }
    }

    void HandlePCMovement() {
        float fAxis = Input.GetAxis("Horizontal");
        anim.SetFloat("Move", fAxis);


        Vector3 position = transform.localPosition;
        position.z += fAxis * Time.deltaTime * speed;
        Mathf.Clamp(position.z, -3, 3);
        transform.localPosition = position;
    }


    public void PlayerLost() {

    }

    private void OnTriggerEnter(Collider other)
    {
        print(other.transform.tag);
    }

    private void OnCollisionEnter(Collision coll)
    {

        print("foi");

        if (coll.transform.tag == "Ball")
        {
            anim.SetTrigger("hit");

        }
    }

}
