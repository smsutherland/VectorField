Field f;

float scale = 20; //pixels per unit

void setup() {
    size(512, 512);
    noStroke();
    f = new Field();
}

void draw() {
    background(255);
    f.drawArrows();
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
