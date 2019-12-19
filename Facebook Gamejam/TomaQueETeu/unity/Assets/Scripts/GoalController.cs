using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GoalController : MonoBehaviour
{
    public PlayerController playerController;
    ScoreManager scoreManager;
    
    // Start is called before the first frame update
    void Start()
    {
        scoreManager = FindObjectOfType<ScoreManager>();
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    private void OnTriggerEnter(Collider other) {

        if (other.gameObject.tag == "Ball") {

            Debug.Log("Tomou Gol");


            int playerIndex = playerController.playerIndex;
            //scoreManager.removeScore(playerController, playerIndex);
            scoreManager.addScore(playerController, playerIndex);

            BallController ball = other.gameObject.GetComponent<BallController>();
            ball.BallWillFall();
        }
    }
}