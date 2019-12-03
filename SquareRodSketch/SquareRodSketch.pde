final int MY_WIDTH = 500 ;
final int MY_HEIGHT = 500 ;
final int ROD_LENGTH = 100 ;
final int STRUT_LENGTH = (int)sqrt(ROD_LENGTH * ROD_LENGTH + ROD_LENGTH * ROD_LENGTH) ;

// For the mouse velocity drawing
int xStart, yStart ;

// particles for the square
Particle p1, p2, p3, p4 ;
Particle p5, p6, p7, p8 ;

// free particle
Particle p9 ;

// The four rods linking the square particles.
Rod rod1, rod2, rod3, rod4 ;
Rod rod5, rod6, rod7, rod8 ;

// The struts
Rod strut1, strut2 ;
Rod strut3, strut4 ;

// Holds all the force generators and the particles they apply to
ForceRegistry forceRegistry ;

// Responsible for resolving all contacts
ContactResolver contactResolver ;

// Holds the contacts
ArrayList contacts ;

ArrayList<Particle> particles;

// initialise screen and particle
void setup() {
  size(500, 500) ;

  // The particles for the square
  p1 = new Particle(MY_WIDTH/2, MY_HEIGHT/2, 0, 0, 0.01f) ;
  p2 = new Particle(MY_WIDTH/2+ROD_LENGTH, MY_HEIGHT/2, 0, 0, 0.01f) ;
  p3 = new Particle(MY_WIDTH/2+ROD_LENGTH, MY_HEIGHT/2+ROD_LENGTH, 0, 0, 0.01f) ;
  p4 = new Particle(MY_WIDTH/2, MY_HEIGHT/2+ROD_LENGTH, 0, 0, 0.01f) ;

  p5 = new Particle(100, 100, 0, 0, 0.005f) ;
  p6 = new Particle(100+ROD_LENGTH, 100, 0, 0, 0.005f) ;
  p7 = new Particle(100+ROD_LENGTH, 100+ROD_LENGTH, 0, 0, 0.005f) ;
  p8 = new Particle(100, 100+ROD_LENGTH, 0, 0, 0.005f) ;

  // The free particle
  p9 = new Particle(MY_WIDTH/2+ROD_LENGTH/2, MY_HEIGHT/4, 0, 1, 0.001f) ;

  //Create the ForceRegistry
  forceRegistry = new ForceRegistry() ;

  //Create the contact resolver and contacts AL
  contactResolver = new ContactResolver() ;
  contacts = new ArrayList() ;
  particles = new ArrayList();
  particles.add(p1);
  particles.add(p2);
  particles.add(p3);
  particles.add(p4);
  particles.add(p5);
  particles.add(p6);
  particles.add(p7);
  particles.add(p8);
  particles.add(p9);

  // Link the particles by rods
  rod1 = new Rod(p1, p2, ROD_LENGTH) ;
  rod2 = new Rod(p2, p3, ROD_LENGTH) ;
  rod3 = new Rod(p3, p4, ROD_LENGTH) ;
  rod4 = new Rod(p1, p4, ROD_LENGTH) ;
  // reinforce the square
  strut1 = new Rod(p1, p3, STRUT_LENGTH) ;
  strut2 = new Rod(p2, p4, STRUT_LENGTH) ;

  // Link the particles by rods
  rod5 = new Rod(p5, p6, ROD_LENGTH) ;
  rod6 = new Rod(p6, p7, ROD_LENGTH) ;
  rod7 = new Rod(p7, p8, ROD_LENGTH) ;
  rod8 = new Rod(p5, p8, ROD_LENGTH) ;
  // reinforce the square
  strut3 = new Rod(p5, p7, STRUT_LENGTH) ;
  strut4 = new Rod(p6, p8, STRUT_LENGTH) ;
}

// update particles, render.
void draw() {
  background(128) ;
  forceRegistry.updateForces() ;
  // Keep the square intact
    Contact contact1 = rod1.addContact() ;
    if (contact1 != null)
        contacts.add(contact1) ;
    Contact contact2 = rod2.addContact() ;
    if (contact2 != null)
        contacts.add(contact2) ;
    Contact contact3 = rod3.addContact() ;
    if (contact3 != null)
        contacts.add(contact3) ;
    Contact contact4 = rod4.addContact() ;
    if (contact4 != null)
        contacts.add(contact4) ;
    Contact contact5 = strut1.addContact() ;
    if (contact5 != null)
        contacts.add(contact5) ;
    Contact contact6 = strut2.addContact() ;
    if (contact6 != null)
        contacts.add(contact6) ;
    Contact contact7 = rod5.addContact() ;
    if (contact7 != null)
        contacts.add(contact7) ;
    Contact contact8 = rod6.addContact() ;
    if (contact8 != null)
        contacts.add(contact8) ;
    Contact contact9 = rod7.addContact() ;
    if (contact9 != null)
        contacts.add(contact9) ;
    Contact contact10 = rod8.addContact() ;
    if (contact10 != null)
        contacts.add(contact10) ;
    Contact contact11 = strut3.addContact() ;
    if (contact11 != null)
        contacts.add(contact11) ;
    Contact contact12 = strut4.addContact() ;
    if (contact12 != null)
        contacts.add(contact12) ;
  // Deal with the free particle
  detectCollision(p1,p2) ;
  detectCollision(p2,p3) ;
  detectCollision(p3,p4) ;
  detectCollision(p1,p4) ;
  detectCollision(p5,p6) ;
  detectCollision(p6,p7) ;
  detectCollision(p7,p8) ;
  detectCollision(p5,p8) ;
  contactResolver.resolveContacts(contacts) ;
  p1.integrate() ;
  p2.integrate() ;
  p3.integrate() ;
  p4.integrate() ;
  p5.integrate() ;
  p6.integrate() ;
  p7.integrate() ;
  p8.integrate() ;
  p9.integrate() ;
  contacts.clear() ;
  // Draw rods in black
  stroke(0) ;
  line(p1.position.x, p1.position.y, p2.position.x, p2.position.y) ;
  line(p2.position.x, p2.position.y, p3.position.x, p3.position.y) ;
  line(p3.position.x, p3.position.y, p4.position.x, p4.position.y) ;
  line(p1.position.x, p1.position.y, p4.position.x, p4.position.y) ;

  line(p5.position.x, p5.position.y, p6.position.x, p6.position.y) ;
  line(p6.position.x, p6.position.y, p7.position.x, p7.position.y) ;
  line(p7.position.x, p7.position.y, p8.position.x, p8.position.y) ;
  line(p5.position.x, p5.position.y, p8.position.x, p8.position.y) ;
  // Draw struts in white
  stroke(255) ;
  line(p1.position.x, p1.position.y, p3.position.x, p3.position.y) ;
  line(p2.position.x, p2.position.y, p4.position.x, p4.position.y) ;

  line(p5.position.x, p5.position.y, p7.position.x, p7.position.y) ;
  line(p6.position.x, p6.position.y, p8.position.x, p8.position.y) ;
  // Draw particles for square
  fill(255,0,0) ;
  ellipse(p1.position.x, p1.position.y, 15, 15) ;
  fill(0,255,0) ;
  ellipse(p2.position.x, p2.position.y, 15, 15) ;
  fill(0,0,255) ;
  ellipse(p3.position.x, p3.position.y, 15, 15) ;
  fill(255,255,255) ;
  ellipse(p4.position.x, p4.position.y, 15, 15) ;

  fill(255,0,0) ;
  ellipse(p5.position.x, p5.position.y, 15, 15) ;
  fill(0,255,0) ;
  ellipse(p6.position.x, p6.position.y, 15, 15) ;
  fill(0,0,255) ;
  ellipse(p7.position.x, p7.position.y, 15, 15) ;
  fill(255,255,255) ;
  ellipse(p8.position.x, p8.position.y, 15, 15) ;
  // The free particle
  fill(0,0,0) ;
  ellipse(p9.position.x, p9.position.y, 15, 15) ;
}

// When mouse is pressed, store x, y coords
void mousePressed() {
  xStart = mouseX ;
  yStart = mouseY ;
}

// Check if the free particle has collided with the specified rod.
void detectCollision(Particle pi, Particle pj) {

    for (Particle p: particles) {
        // we take a vector per square rod.
        // Then the question becomes whether we are overlapping that line.
        // we use scalar projection to work this out.
        PVector pipj = pj.position.get().sub(pi.position.get()) ;
        PVector pip = p.position.get().sub(pi.position.get()) ;
        float dotprod = pipj.dot(pip) ;
        float scalarproj = dotprod/pipj.mag() ;

        // keep within bounds of our rod length
        if (scalarproj < 0f) scalarproj = 0f ;
        else if (scalarproj > ROD_LENGTH) scalarproj = ROD_LENGTH ;

        // and what proportion of rod length is it?
        float proportion = scalarproj / ROD_LENGTH ;

        // we are going to find the closest point by multiplying p1p2 by this
        // proportion and then adding the result to p1.
        PVector subRod = pipj.mult(proportion) ;
        PVector closestPoint = pi.position.get().add(subRod) ;

        PVector distance = closestPoint.sub(p.position) ;

        // Collision?
        // Setting restitution to 1 here.
        if (distance.mag() <= 7.5) {
            distance.normalize() ;
            // both particles feel it
            contacts.add(new Contact(pi, p, 1, distance)) ;
            contacts.add(new Contact(pj, p, 1, distance)) ;
        }
    }
}

// When mouse is released create new vector relative to stored x, y coords
void mouseReleased() {
  PVector newVel = new PVector(mouseX - xStart, mouseY - yStart) ;
  newVel.normalize().mult(2) ;
  p9.velocity = newVel ;
}
