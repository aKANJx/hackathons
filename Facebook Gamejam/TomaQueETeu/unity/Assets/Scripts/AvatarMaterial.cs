using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AvatarMaterial : MonoBehaviour
{
    public Color color;

    public Texture texture;

    private Renderer render;

    public void Change()
    {

    }



    // Start is called before the first frame update
    void Awake()
    {
        render = GetComponent<Renderer>();
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
