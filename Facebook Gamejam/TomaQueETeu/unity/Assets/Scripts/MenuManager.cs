using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


public class MenuManager : MonoBehaviour
{
    public GameObject buttonsPanel;
    public GameObject friendsPanel;

  
   void Start()
   {
       buttonsPanel.SetActive(true);
       friendsPanel.SetActive(false);
   }

   public void StartGamePressed() {
       SceneManager.LoadScene(1);
   }

   public void OpenFriendsPressed() {
       buttonsPanel.SetActive(false);
       friendsPanel.SetActive(true);
   }

   public void CloseFriendsPressed() {
        buttonsPanel.SetActive(true);
       friendsPanel.SetActive(false);
   }
}
