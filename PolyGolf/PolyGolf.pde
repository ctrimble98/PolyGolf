import java.util.*;

PreDefCourses courseGenerator;
EnvironmentGenerator environmentGenerator;

PolygonGenerator polyGen;

CollisionDetector collisionDetect;
ContactResolver contactResolver;

List<Contact> contacts;

PVector dragStart;

GameMode gameMode;

final color PLAYER_COLOUR = color(255);

PFont infoFont;

Course course;

Hole hole;
Player player;

PVector offset;
int gridWidth;
int gridHeight;
int tileSize;

public void settings(){
    fullScreen();
}

void setup() {
    frameRate(Constants.FPS);
    noCursor();

    infoFont = createFont("SansSerif", 24);

    gameMode = GameMode.GAME;
    courseGenerator = new PreDefCourses();
    environmentGenerator = new EnvironmentGenerator();

    polyGen = new PolygonGenerator();
    collisionDetect = new CollisionDetector();
    contactResolver = new ContactResolver();
    contacts = new ArrayList<Contact>();

    dragStart = new PVector(-1, -1);

    gridHeight = displayHeight - 100;
    tileSize = gridHeight/Constants.GRID_HEIGHT;
    gridWidth = tileSize*Constants.GRID_WIDTH;

    offset = new PVector(displayWidth/2 - gridWidth/2, displayHeight/2 - gridHeight/2);

    player = new Player(polyGen.getRegularStar(3, 1, Constants.PLAYER_RADIUS, PI/4, new PVector(Constants.PLAYER_RADIUS, Constants.PLAYER_RADIUS)));
    course = new Course(courseGenerator.getBasicCourse(), environmentGenerator.getGrass(), player);
}

void draw() {

    switch(gameMode) {
        case MENU:
            break;
        case GAME:
            course.update(player);
            course.drawCourse();
            drawForce();
            drawStats();
            break;
    }

    drawCursor();
}

public void drawStats() {
    fill(0);
    textAlign(LEFT, TOP);
    text(frameRate, 0, 0);
}

void mousePressed() {
    switch(gameMode) {
        case MENU:
            break;
        case GAME:
            if (player.isStopped() && course.getMode() == CourseMode.PLAY) {
                dragStart = new PVector(mouseX, mouseY);
            }
            break;
    }
}

void mouseReleased() {
    switch(gameMode) {
        case MENU:
            break;
        case GAME:
            if (dragStart.x != -1  && course.getMode() == CourseMode.PLAY && player.isStopped()) {
                player.addForce(dragStart, dragStart.copy().sub(mouseX, mouseY).mult(-1).mult(5));
                dragStart = new PVector(-1, -1);
                player.addShot();
            }
            break;
    }
}

void drawForce() {

    if (dragStart.x != -1 && course.getMode() == CourseMode.PLAY) {
        stroke(0);
        strokeWeight(5);

        PVector force = dragStart.copy().sub(mouseX, mouseY);
        PVector headHeight = force.copy().normalize().mult(15);
        PVector headHalfWidth = force.copy().normalize().rotate(PI/2).mult(5);

        PVector point0 = new PVector(mouseX, mouseY);
        point0.sub(headHeight.copy().div(2));
        PVector point1 = point0.copy().add(headHeight).add(headHalfWidth);
        PVector point2 = point1.copy().sub(headHalfWidth.mult(2));

        line(dragStart.x, dragStart.y, mouseX, mouseY);
        triangle(point0.x, point0.y, point1.x, point1.y, point2.x, point2.y);
    }
}

void drawCursor() {

    stroke(0);
    strokeWeight(1);
    fill(0);
    circle(mouseX, mouseY, 8);
}
