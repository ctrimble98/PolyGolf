static class PhysicsEngine {


    //https://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection
    public static boolean circleAllignedRect(PVector circle, float radius, PVector rect, float rectWidth, float rectHeight) {

        float circX = circle.x;
        float circY = circle.y;

        float rectHalfWidth = rectWidth/2;
        float rectHalfHeight = rectHeight/2;
        float rectCenterX = rect.x + rectHalfWidth;
        float rectCenterY = rect.y + rectHalfHeight;

        float distX = abs(circX - rectCenterX);
        float distY = abs(circY - rectCenterY);

        if (distX > (rectHalfWidth + radius)) {
            return false;
        }
        if (distY > (rectHalfHeight + radius)) {
            return false;
        }

        if (distX <= rectHalfWidth) {
            return true;
        }
        if (distY <= rectHalfHeight) {
            return true;
        }

        return (sq(distX - rectHalfWidth) + sq(distY - rectHalfHeight) <= sq(radius));
    }
}
