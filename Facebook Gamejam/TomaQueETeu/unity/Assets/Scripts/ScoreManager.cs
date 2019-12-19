using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ScoreManager : MonoBehaviour
{
  
    public Text[] listTextScore;
    public int[] scores;

    // Start is called before the first frame update
    void Start()
    {

        Debug.Log("Score: " + scores[1]);

        PlayerController[] players = FindObjectsOfType<PlayerController>();


        for (int i = 0; i < players.Length; ++i)
        {
            listTextScore[i].text = players[i].playerName;


        }
    }

    // Update is called once per frame
    void Update()
    {

    }

    public void addScore(PlayerController gameObject, int index)
    {
        scores[index] = scores[index] + 1;

        string playerName = gameObject.GetComponentInParent<PlayerController>().playerName;
        listTextScore[index].text = playerName + " | Score: " + scores[index];

        if(scores[index] == 10)
        {
            Debug.Log(playerName + " ganhou");
        }

    }

    public void removeScore(PlayerController gameObject, int index)
    {
        scores[index] = scores[index] - 1;

        string playerName = gameObject.playerName;
        listTextScore[index].text = playerName + " | Score: " + scores[index];

        if (scores[index] == -5)
        {
            Debug.Log(playerName + " perdeu");
        }
    }
}
