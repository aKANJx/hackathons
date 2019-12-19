using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FallingBaby : MonoBehaviour
{
    float angularSpeed;
    public GameObject babyGO;
    public GameObject bigGO;
    // Start is called before the first frame update
    void Start()
    {
        bool isBaby = Random.Range(0,100) < 80;
        babyGO.SetActive(isBaby);
        bigGO.SetActive(!isBaby);
        Destroy(this.gameObject, 5f);
        angularSpeed = Random.Range(-60,60);
    }

    // Update is called once per frame
    void Update()
    {
        transform.Rotate(Vector3.one, angularSpeed*Time.deltaTime);
    }
}
