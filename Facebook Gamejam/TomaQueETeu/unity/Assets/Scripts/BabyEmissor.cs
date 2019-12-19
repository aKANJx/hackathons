using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BabyEmissor : MonoBehaviour
{
    public GameObject babyGO;
    // Start is called before the first frame update
    void Start()
    {
        InvokeRepeating("InstantiateBaby", 0, Random.Range(1,3));
    }

   void InstantiateBaby() {
       float xPosition = transform.position.x;
       GameObject go = Instantiate(babyGO, new Vector3(Random.Range(xPosition-3, xPosition+1), transform.position.y, transform.position.z), transform.rotation);
   }
}