using UnityEngine;

public class ClockManager : MonoBehaviour
{
    private float startTimeSeconds;
    private float travelTimeSeconds;
    private float currentTimeSeconds;
    [SerializeField]
    private Transform hoursHandle;
    [SerializeField]
    private Transform minutesHandle;
    [SerializeField]
    private Transform secondsHandle;

    public Vector3 startTime;
    public Vector3 travelTime;
    public float SecondTime = 1;
    public float HandTime = 10;

    void Start()
    {
        if (this.hoursHandle == null)
            this.hoursHandle = this.transform.Find("hour");

        if (this.minutesHandle == null)
            this.minutesHandle = this.transform.Find("minute");

        if (this.secondsHandle == null)
            this.secondsHandle = this.transform.Find("second");

        this.startTimeSeconds = /*this.startTime.x * 86400 +*/ this.startTime.x * 3600 + this.startTime.y * 60 + this.startTime.z;
        this.travelTimeSeconds = /*this.travelTime.x * 86400 +*/ this.travelTime.x * 3600 + this.travelTime.y * 60 + this.travelTime.z;
        this.Reset();
    }

    void Update()
    {
        if (Main.Instance.State != GameState.Playing)
            return;

        if (this.currentTimeSeconds < this.travelTimeSeconds)
        {
            this.currentTimeSeconds += Time.deltaTime * this.SecondTime;
            this.updateWatch();
        }
        else if (Main.Instance.State != GameState.Died)
        {
            Main.Instance.State = GameState.Died;
        }
    }

    public void Reset()
    {
        this.currentTimeSeconds = this.startTimeSeconds;
    }

    private void updateWatch()
    {
        float time = Time.deltaTime * this.HandTime;

        if (this.hoursHandle != null)
        {
            float currentHours = Mathf.Ceil(this.currentTimeSeconds / 3600 - 1);
            this.hoursHandle.rotation = Quaternion.Slerp(this.hoursHandle.rotation, Quaternion.Euler(new Vector3(0, 0, currentHours * -(360f / 12))), time);
        }

        if (this.minutesHandle != null)
        {
            float currentMinutes = Mathf.Ceil(this.currentTimeSeconds / 60 - 1);
            this.minutesHandle.rotation = Quaternion.Slerp(this.minutesHandle.rotation, Quaternion.Euler(new Vector3(0, 0, currentMinutes * -(360f / 60))), time);
        }

        if (this.secondsHandle != null)
        {
            float currentSeconds = Mathf.Ceil(this.currentTimeSeconds - 1);
            this.secondsHandle.rotation = Quaternion.Slerp(this.secondsHandle.rotation, Quaternion.Euler(new Vector3(0, 0, currentSeconds * -(360f / 60))), time);
        }
    }
}
