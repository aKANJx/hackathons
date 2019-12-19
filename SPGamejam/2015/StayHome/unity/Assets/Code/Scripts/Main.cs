using System;
using UnityEngine;

public enum GameState 
{
    Intro,
    Playing,
    Died,
    Won,
    Inventory,
    Entering,
}

public class Main : MonoBehaviour
{
    public static Main Instance;
    public GameState State;
    public GameObject StartintSpawnPoint;

    void Awake()
    {
        Instance = this;

        if (this.StartintSpawnPoint == null)
            throw new NullReferenceException("StartintSpawnPoint is missing in Editor.");
    }

    void Start()
    {
        this.State = GameState.Playing;
        Player.Instance.GoToRoom(this.StartintSpawnPoint);
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Tab))
        {
            if (this.State == GameState.Playing)
                this.State = GameState.Inventory;
            else
                this.State = GameState.Playing;
        }
    }
}
