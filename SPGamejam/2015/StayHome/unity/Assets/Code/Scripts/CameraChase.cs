using UnityEngine;

public class CameraChase : MonoBehaviour
{
    private float zoomSpeed;
    private float panSpeed;

    public float ZoomNear = -5;
    public float ZoomFar = -10;
    public float ZoomSelection = -3;
    public float ZoomSpeed = 5;
    public float PanSpeed = 5;

    void Awake()
    {
        this.ZoomNear = this.transform.localPosition.z;
        this.zoomSpeed = this.ZoomSpeed;
        this.panSpeed = this.PanSpeed;
    }

    void FixedUpdate()
    {
        float zoomSpeed = Main.Instance.State == GameState.Entering ? this.ZoomSpeed * 4 : this.ZoomSpeed;
        float panSpeed = Main.Instance.State == GameState.Entering ? this.PanSpeed * 2 : this.PanSpeed;
        this.zoomSpeed += (zoomSpeed - this.zoomSpeed) * Time.deltaTime * 10;
        this.panSpeed += (panSpeed - this.panSpeed) * Time.deltaTime * 10;

        Vector3 position = this.transform.localPosition;
        float distance = Player.Instance.transform.position.x - position.x;

        position.x += distance * Time.deltaTime * this.panSpeed;
        distance -= (Player.Instance.transform.localPosition.y + 0.42f) * 2;
        float zoom = Main.Instance.State == GameState.Inventory ? this.ZoomSelection : this.ZoomNear + Mathf.Abs(distance) * (this.ZoomFar - this.ZoomNear);

        if (Player.Instance.Room != null)
        {
            position.y += (Player.Instance.Room.transform.position.y - position.y) * Time.deltaTime * this.panSpeed;
            zoom += Player.Instance.Room.transform.position.z;
        }

        position.z += (zoom - position.z) * Time.deltaTime * this.zoomSpeed;
        this.transform.localPosition = position;
    }
}