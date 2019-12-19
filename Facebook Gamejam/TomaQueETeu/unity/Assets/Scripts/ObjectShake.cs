using UnityEngine;
using System.Collections;

public class ObjectShake : MonoBehaviour {

	private Vector3 originPosition;
	private Quaternion originRotation;
	public float shakeIntensity = 0.1f;
	
	void Start()
	{
		originPosition = transform.position;
		InvokeRepeating("Shake", 0, .01f);
	}

	void Shake() {
		float modifier = Random.Range(-0.1f, 0.1f) * shakeIntensity;
		transform.position = new Vector3(originPosition.x + modifier, originPosition.y + modifier, originPosition.z);
	}
}