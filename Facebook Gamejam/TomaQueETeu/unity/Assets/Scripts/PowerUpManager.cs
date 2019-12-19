using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PowerUpManager : MonoBehaviour
{

    public GameObject[] listPrefabs;

    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine("SpawnPowerUp");

    }

    // Update is called once per frame
    void Update()
    {
        
    }

    // Return Position Proximity Object
    Vector3 RandomCircle(Vector3 center, float radius)
    {
        float ang = Random.value * 360;
        Vector3 pos;
        pos.x = center.x + radius * Mathf.Sin(ang * Mathf.Deg2Rad);
        pos.y = center.y;
        pos.z = center.z;
        return pos;
    }

    IEnumerator SpawnPowerUp()
    {
        yield return new WaitForSeconds(10f);

        GameObject ball = GameObject.FindWithTag("Ball");
            
        Vector3 center = ball.transform.position;
       
        Vector3 pos = RandomCircle(center, 3.0f);

        int index = Random.Range(0, listPrefabs.Length);

        GameObject obj = Instantiate(listPrefabs[index], pos, Quaternion.identity);
        Destroy(obj, 5f);

        StartCoroutine("SpawnPowerUp");

    }
}
