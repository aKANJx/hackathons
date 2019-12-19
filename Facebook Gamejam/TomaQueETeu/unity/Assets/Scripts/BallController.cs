using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BallController : MonoBehaviour
{
    public PhysicMaterial frictionPM;
    public AudioClip[] listAudioClips;

    float ballForce = 300;
    ParticleSystem particleSystem;
    AudioSource audioSource;
    float currentForce = 5;
    Rigidbody rb;
    SphereCollider col;
    int countPlaySound;
    int currentCountPlaySound;
    ScoreManager scoreManager;


    public TrailRenderer trail;

    Vector3 lastDir;

    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody>();
        col = GetComponent<SphereCollider>();
        //GetComponent<Rigidbody>().AddForce(Vector3.left*ballForce);
        particleSystem = GetComponent<ParticleSystem>();
        audioSource = GetComponent<AudioSource>();
        scoreManager = FindObjectOfType<ScoreManager>();

        countPlaySound = Mathf.Abs(Random.Range(7, 10));
        currentCountPlaySound = 0;

        StartCoroutine(GoBall());

        

    }

    private void Update()
    {
        transform.Rotate(lastDir, 200 * Time.deltaTime);
    }

    private void OnTriggerEnter(Collider coll)
    {
        


        if (coll.transform.tag == "Paddle")
        {
            Debug.Log("Hit Paddle");

            coll.transform.parent.GetComponent<PlayerController>().anim.SetTrigger("Hit");

            GameObject playerObject = coll.gameObject;
            int playerIndex = playerObject.GetComponentInParent<PlayerController>().playerIndex;
            Debug.Log(playerIndex);

            //scoreManager.addScore(playerObject, playerIndex);

            Vector3 dir = transform.position - coll.transform.position;
            dir.y = 0;
            dir = dir.normalized;

            lastDir = dir;
            //Debug.Log(dir);
            currentForce *= 1.05f;
            rb.velocity = dir * currentForce;

        }
    }






    void RestartGame()
    {



        StartCoroutine(GoBall());
        //Invoke("GoBall", 1);
    }

    void ResetBall()
    {
        rb.Sleep();

        currentForce = 5;


        rb.velocity = new Vector3(0, 0, 0);
        lastDir = Vector3.zero;
        trail.enabled = false;
        transform.position = Vector3.up;
    }


    IEnumerator GoBall()
    {
        rb.useGravity = false;

        


        yield return new WaitForSeconds(1);


        ResetBall();



        yield return new WaitForSeconds(1);

        trail.enabled = true;

        float rand = Random.Range(0, 4);

        switch (rand)
        {
            case 1:
                rb.AddForce(Vector3.left * ballForce);
                lastDir = Vector3.left;
                break;
            case 2:
                rb.AddForce(Vector3.right * ballForce);
                lastDir = Vector3.right;
                break;
            case 3://
                rb.AddForce(Vector3.forward * ballForce);
                lastDir = Vector3.up;
                break;
            default:
                rb.AddForce(Vector3.back * ballForce);
                lastDir = Vector3.down;
                break;
        }

        /*
        if (rand < 1)
        {
            //rb2d.AddForce(new Vector2(20, -15));
            //rb
            rb.AddForce(Vector3.left * ballForce);
            lastDir = Vector3.left;
        }
        else
        {
            //rb2d.AddForce(new Vector2(-20, -15));
            //rb
            rb.AddForce(Vector3.right * ballForce);
            lastDir = Vector3.right;
        }*/
    }


    /*
    private void OnCollisionEnter(Collision coll)
    {
        if(coll.transform.tag == "Paddle")
        {
            Debug.Log("Hit Paddle");

            Vector3 vel;
            Vector3 dir = transform.position - coll.transform.position;
            dir.y = 0;
            dir = dir.normalized;

            lastDir = dir;
            Debug.Log(dir);
            rb.velocity = dir *2;

        }
    }*/

    /*
    void OnCollisionEnter2D(Collision2D coll)
    {
        if (coll.collider.CompareTag("Player"))
        {
            Vector2 vel;
            vel.x = rb2d.velocity.x;
            vel.y = (rb2d.velocity.y / 2.0f) + (coll.collider.attachedRigidbody.velocity.y / 3.0f);
            rb2d.velocity = vel;
        }
    }*/

    private void OnDrawGizmos()
    {
        Gizmos.color = Color.blue;
        Gizmos.DrawLine(transform.position, transform.position + lastDir);
    }

    private void OnCollisionEnter(Collision collision)
    {

        particleSystem.Play();


        

        if(currentCountPlaySound >= countPlaySound)
        {
            StartCoroutine("PlayBabySound");

        }
        else
        {
            currentCountPlaySound++;
        }
    }

    IEnumerator PlayBabySound()
    {
        int index = Random.Range(0, listAudioClips.Length);
        audioSource.clip = listAudioClips[index];
        audioSource.Play();

        countPlaySound = Mathf.Abs(Random.Range(7, 10));
        currentCountPlaySound = 0;

        yield return new WaitForSeconds(0.5f);

        audioSource.Stop();

    }

    public void BallWillFall() {
        //Debug.Log("Entered");
        rb.constraints = RigidbodyConstraints.None;
        rb.useGravity = true;
        //col.material = frictionPM;

        RestartGame();
        
    }

   
}
