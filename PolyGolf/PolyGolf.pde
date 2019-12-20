import java.util.*;

PreDefCourses courseGenerator;
EnvironmentGenerator environmentGenerator;

List<Environment> environments;
int currentEnvironmentIndex;

PolygonGenerator polyGen;

CollisionDetector collisionDetect;
ContactResolver contactResolver;

List<Contact> contacts;

PVector dragStart;

GameMode gameMode;

// final color PLAYER_COLOUR = color(255);

int[][] polygons;
int currentPolygonIndex;
float rotation;

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

    gameMode = GameMode.MENU;
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

    environments = environmentGenerator.getEnvironments();
    currentEnvironmentIndex = 0;

    fillPolygons();
}

void draw() {

    switch(gameMode) {
        case MENU:
            drawMenu();
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

void drawMenu() {
    textAlign(CENTER, CENTER);
    background(environments.get(currentEnvironmentIndex).getGroundColour());
    fill(environments.get(currentEnvironmentIndex).getObstacleColour());
    PFont titleFont = createFont("SansSerif.bold", 180);
    textFont(titleFont);
    text("POLYGOLF", displayWidth/2, displayHeight/4);

    textFont(infoFont);
    noStroke();
    rectMode(CENTER);
    pushMatrix();
    translate(displayWidth/2, displayHeight/2 - 50);
    fill(environments.get(currentEnvironmentIndex).getObstacleColour());
    rect(0, 0, Constants.BUTTON_WIDTH, Constants.BUTTON_HEIGHT);
    fill(environments.get(currentEnvironmentIndex).getGroundColour());
    text("Play", 0, 0);
    translate(0, 150);
    fill(environments.get(currentEnvironmentIndex).getObstacleColour());
    rect(0, 0, Constants.BUTTON_WIDTH, Constants.BUTTON_HEIGHT);
    fill(environments.get(currentEnvironmentIndex).getGroundColour());
    text("Change Environment", 0, 0);
    translate(0, 150);
    fill(environments.get(currentEnvironmentIndex).getObstacleColour());
    rect(0, 0, Constants.BUTTON_WIDTH, Constants.BUTTON_HEIGHT);
    fill(environments.get(currentEnvironmentIndex).getGroundColour());
    text("Change Polygon", 0, 0);
    translate(0, 150);
    fill(environments.get(currentEnvironmentIndex).getObstacleColour());
    rect(0, 0, Constants.BUTTON_WIDTH, Constants.BUTTON_HEIGHT);
    fill(environments.get(currentEnvironmentIndex).getGroundColour());
    text("Random Polygon", 0, 0);
    popMatrix();

    Shape currentPolygon = polyGen.getRegularStar(polygons[currentPolygonIndex][0], polygons[currentPolygonIndex][1], 200, 0, new PVector(200, 200));
    PGraphics pg = createGraphics(400,400);
    pg.beginDraw();
    pg.noStroke();
    pg.fill(environments.get(currentEnvironmentIndex).getPlayerColour());
    currentPolygon.setImage(pg);
    pg.endDraw();

    imageMode(CENTER);
    pushMatrix();
    translate(displayWidth/4, displayHeight/2 + 175);
    rotate(rotation);
    image(pg, 0, 0);
    popMatrix();

    pushMatrix();
    translate(3*displayWidth/4, displayHeight/2 + 175);
    rotate(-rotation);
    image(pg, 0, 0);
    popMatrix();
    rotation += 0.01;
}

public void drawStats() {
    fill(0);
    textFont(infoFont, 16);
    textAlign(LEFT, TOP);
    text(frameRate, 0, 0);
}

void mousePressed() {
    switch(gameMode) {
        case MENU:
            if (mouseX > displayWidth/2 - Constants.BUTTON_WIDTH/2 && mouseX < displayWidth/2 + Constants.BUTTON_WIDTH/2) {
                if (mouseY > displayHeight/2 - Constants.BUTTON_HEIGHT/2 - 50 && mouseY < displayHeight/2 + Constants.BUTTON_HEIGHT/2 - 50) {
                    player = new Player(polyGen.getRegularStar(polygons[currentPolygonIndex][0], polygons[currentPolygonIndex][1], Constants.PLAYER_RADIUS, PI/4, new PVector(Constants.PLAYER_RADIUS, Constants.PLAYER_RADIUS)));
                    course = new Course(courseGenerator.getBasicCourse(), environments.get(currentEnvironmentIndex), player);
                    gameMode = GameMode.GAME;
                } else if (mouseY > displayHeight/2 - Constants.BUTTON_HEIGHT/2 + 100 && mouseY < displayHeight/2 + Constants.BUTTON_HEIGHT/2 + 100) {
                    currentEnvironmentIndex = (currentEnvironmentIndex + 1) % environments.size();
                } else if (mouseY > displayHeight/2 - Constants.BUTTON_HEIGHT/2 + 250 && mouseY < displayHeight/2 + Constants.BUTTON_HEIGHT/2 + 250) {
                    currentPolygonIndex = (currentPolygonIndex + 1) % polygons.length;
                } else if (mouseY > displayHeight/2 - Constants.BUTTON_HEIGHT/2 + 400 && mouseY < displayHeight/2 + Constants.BUTTON_HEIGHT/2 + 400) {
                    currentPolygonIndex = (int)random(polygons.length);
                }
            }
            break;
        case GAME:
            if (player.isStopped() && course.getMode() == CourseMode.PLAY) {
                dragStart = new PVector(mouseX, mouseY);
            } else if (course.getMode() == CourseMode.RESULTS) {
                if (mouseX > displayWidth/2 - Constants.BUTTON_WIDTH/2 && mouseX < displayWidth/2 + Constants.BUTTON_WIDTH/2 && mouseY > 3*displayHeight/4 - Constants.BUTTON_HEIGHT/2 && mouseY < 3*displayHeight/4 + Constants.BUTTON_HEIGHT/2) {
                    gameMode = GameMode.MENU;
                }
            }
            break;
    }
}

void mouseReleased() {
    switch(gameMode) {
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

public void fillPolygons() {
    polygons = new int[][]{
        {3, 1},
        {4, 1},
        {5, 1},
        {6, 1},
        {7, 1},
        {5, 2},
        {6, 2},
        {7, 2},
        {7, 3},
        {8, 2},
        {8, 3},
        {9, 3},
        {9, 4},
        {12, 5}
    };

    currentPolygonIndex = 0;
    rotation = 0;
}
