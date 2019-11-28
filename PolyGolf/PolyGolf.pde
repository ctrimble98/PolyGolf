int holeBorderWdith = 20;


Environment grass = new Environment(
    color(181, 230, 29),
    color(37, 178, 74),
    color(145, 184, 23)
);

Hole basicHole = new Hole();

Hole hole;

void setup() {
    fullScreen();
    hole = new Hole(grass);
}

void draw() {
    hole.draw();
}
