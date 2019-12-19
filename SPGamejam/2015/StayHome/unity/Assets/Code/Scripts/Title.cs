using System.Collections;
using System.Collections.Generic;
using System.Text;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Text))]
public class Title : MonoBehaviour
{
    private StringBuilder stringBuilder = new StringBuilder();
    private Text text;
    private Queue<string> queue = new Queue<string>();

    public static Title Instance;
    public float CharTime = 0.03f;
    public float StayTime = 3;

    void Awake()
    {
        Instance = this;
        this.text = this.GetComponent<Text>();
    }

    public void SetTitle(string title)
    {
        this.queue.Enqueue(title);
        this.StopAllCoroutines();
        this.StartCoroutine(this.update());
    }

    private IEnumerator update()
    {
        while (this.queue.Count > 0)
        {
            string full = this.queue.Dequeue();

            if (this.stringBuilder.Length > 0)
                this.stringBuilder.Remove(0, this.stringBuilder.Length);

            while (this.stringBuilder.Length < full.Length)
            {
                this.stringBuilder.Append(full.Substring(this.stringBuilder.Length, 1));
                this.text.text = this.stringBuilder.ToString();
                yield return new WaitForSeconds(this.CharTime);
            }

            yield return new WaitForSeconds(this.StayTime);

            while (this.stringBuilder.Length > 0)
            {
                this.stringBuilder.Remove(this.stringBuilder.Length - 1, 1);
                this.text.text = this.stringBuilder.ToString();
                yield return new WaitForSeconds(this.CharTime / 2);
            }
        }
    }
}
