using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class PlayerInfoController : MonoBehaviour
{
    public PlayerController player;
    void Start()
    {
        Destroy(this.gameObject, 5f);
        TextMeshProUGUI nameLabel = GetComponentInChildren<TextMeshProUGUI>();
        if (player.playerType == PlayerController.PlayerType.P1) {
            nameLabel.text = "Jogador 1";
            nameLabel.fontStyle = FontStyles.Bold;
            Color color = new Color(56, 77, 178, 255);
            nameLabel.outlineColor = color;
            nameLabel.faceColor = color;
        }
        else {
            nameLabel.text = NamesDB.shared.Pop();
        }


    }
}
