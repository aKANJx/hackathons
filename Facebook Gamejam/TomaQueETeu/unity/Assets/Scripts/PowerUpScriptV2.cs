using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PowerUpScriptV2 : MonoBehaviour
{

    float rotationSpeed = 100.0f;

    // Use this for initialization
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
        transform.Rotate(Vector3.up * rotationSpeed * Time.deltaTime, Space.Self);
    }

    private void OnTriggerEnter(Collider other)
    {
        Debug.Log("PowerUp Enter!");
        Destroy(transform.gameObject);

    }
}
