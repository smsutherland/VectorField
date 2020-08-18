import java.lang.Math;

Field f;
Particle[][] particles;

final boolean showArrows = false;
final boolean showParticles = true;

final int recordAfter = 100;
final int recordFor = 100;

final float scale = 16; //pixels per unit
final float particleScale = 2; //particles per unit

void setup() {
    size(512, 512);
    noStroke();
    f = new Field();
    PVector max = maxCoords();
    if(showParticles){
        particles = new Particle[2*(int)(max.x*particleScale) + 1][2*(int)(max.y*particleScale) + 1];
        for(int x = 0; x < particles.length; x++){
            for(int y = 0; y < particles[x].length; y++){
                particles[x][y] = new Particle((float)x/particleScale - max.x, (float)y/particleScale - max.y);
            }
        }
    }
    //particles[0][0].debug();
}

void draw() {
    background(0);
    if(showArrows){
        f.drawArrows();
    }
    if(showParticles){
        drawParticles();
        moveParticles();
        checkParticles();
        if(frameCount > recordAfter && frameCount <= recordAfter + recordFor){
            saveFrame("Recording/field-####.png");
        }
    }

    if(frameCount == recordAfter + 1){
        println("Starting recording...");
    }

    if(frameCount == recordAfter + recordFor){
        println("Done!");
    }
}

void drawParticles(){
    for(int x = 0; x < particles.length; x++){
        for(int y = 0; y < particles[x].length; y++){
            particles[x][y].draw();
        }
    }
}

void moveParticles(){
    for(int x = 0; x < particles.length; x++){
        for(int y = 0; y < particles[x].length; y++){
            particles[x][y].move(1, 0.1);
        }
    }
}

void checkParticles(){
    PVector max = maxCoords();
    for(int x = 0; x < particles.length; x++){
        for(int y = 0; y < particles[x].length; y++){
            if(particles[x][y].dead()){
                if(Math.random() > 0.95){
                    particles[x][y] = new Particle((float)x/particleScale - max.x, (float)y/particleScale - max.y, particles[x][y]);
                }
            }
        }
    }
}

PVector function(PVector coords){
    return f.function(coords);
}

PVector coordToPixel(PVector coord){
    float centerX = width/2;
    float centerY = height/2;
    float x = centerX + coord.x*scale;
    float y = centerY - coord.y*scale;
    return new PVector(x, y);
}

PVector coordToPixel(float x, float y){
    return coordToPixel(new PVector(x, y));
}

PVector pixelToCoord(PVector pixel){
    float centerX = width/2;
    float centerY = height/2;
    float x = (pixel.x - centerX)/scale;
    float y = -(pixel.y - centerY)/scale;
    return new PVector(x, y);
}

PVector pixelToCoord(float x, float y){
    return pixelToCoord(new PVector(x, y));
}

PVector maxCoords(){
    return new PVector(width/(2*scale), height/(2*scale));
}

color getColor(float mag){
	float colorScale = 4;

    if(mag <= 0){
        return color(0,0,0);
    }
    else if(mag < colorScale){
        return lerpColor(color(0,0,0), color(0,0,255), mag/colorScale);
    }
    else if(mag < 2*colorScale){
        return lerpColor(color(0,0,255), color(0,255,0), (mag-colorScale)/colorScale);
    }
    else if(mag < 3*colorScale){
        return lerpColor(color(0,255,0), color(255,0,0), (mag-2*colorScale)/colorScale);
    }
    return color(255,0,0);
}
