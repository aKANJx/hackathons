using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class HUDController : MonoBehaviour
{
    public  GameObject playerInfo;
    // Start is called before the first frame update
    void Start()
    {
        GameObject[] players = GameObject.FindGameObjectsWithTag("Player");
        foreach (GameObject player in players)
        {
            Vector3 screenPos = Camera.main.WorldToScreenPoint(player.transform.position);
            GameObject playerInfoGO = Instantiate(playerInfo, screenPos, transform.rotation, this.transform);
            playerInfoGO.GetComponent<PlayerInfoController>().player = player.GetComponent<PlayerController>();                  
        }
    }
}
