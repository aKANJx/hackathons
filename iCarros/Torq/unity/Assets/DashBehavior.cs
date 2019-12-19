using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DashBehavior : MonoBehaviour {

    public Transform pointer;
    public AudioSource engine;
    public Sprite carDashWithLight;
    private SpriteRenderer spriteRenderer;

	private void Start()
	{
        Invoke("idleEngine", 2f);
        spriteRenderer = GetComponent<SpriteRenderer>();
	}

    private void idleEngine() 
    {
        engine.Play();
    }
	private void Update()
	{
        if (Input.GetKey(KeyCode.RightArrow))
        {
            accelerate();
        }
        else if (Input.GetKey(KeyCode.LeftArrow))
        {
            deccelerate();
        }
        else if (Input.GetKey(KeyCode.C)) {
            changeSprite();
        }
	}

    void changeSprite() {
        spriteRenderer.sprite = carDashWithLight;
    }

    void accelerate() {
        throtle(-1);
    }

    void deccelerate() {
        throtle(1);
    }

    void throtle(float multiplier) {
        pointer.Rotate(new Vector3(0, 0, 1) * multiplier * 20 * Time.deltaTime);
        float engineRPM = Mathf.Abs(pointer.eulerAngles.z - 360);
        float maxRPM = 150;
        engine.pitch = Mathf.Abs(engineRPM / maxRPM) + 1.0f;
        if (engine.pitch > 2.0f)
        {
            engine.pitch = 2.0f;
        }
        else if (engine.pitch < 0.0f) 
        {
            engine.pitch = 0.0f;
        }
    }
}
