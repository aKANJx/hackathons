using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bot : MonoBehaviour
{
    public bool bot;

    public bool vertical;
    public bool inverse;

    public Transform ball;

    Vector3 targetPos;

    float speed = 2;

    public float offset;
    float offsetValue = 1;


    public Animator anim;

    void Start()
    {
        StartCoroutine( OffsetRand());

    }

    // Update is called once per frame
    void Update()
    {



        if (vertical)
        {
            
            Vector3 v = transform.localPosition;
            float f = ball.transform.position.z + offset;
            f = Mathf.Clamp(f, -3, 3);

            if (inverse)
                f = -f;

            v.z = f;

            targetPos = v;
        }
        else {


            Vector3 v = transform.localPosition;
            float f = ball.transform.position.x + offset;
            f = Mathf.Clamp(f, -3, 3);

            v.z = f;

            targetPos = v;
        }

        transform.localPosition = Vector3.Lerp(transform.localPosition, targetPos, speed * Time.deltaTime);


        anim.SetFloat("Move", Vector3.Distance(transform.localPosition, targetPos));
    }

    IEnumerator OffsetRand()
    {
        while (0 == 0)
        {
            offset = Random.Range(-offsetValue, offsetValue);
            yield return new WaitForSeconds(Random.Range(1f,3f));
        }
    }

}
