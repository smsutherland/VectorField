class Field{
    PVector function(PVector coords){ // edit this to change the field function.
        float x = coords.x;
        float y = coords.y;
        return new PVector(1, sin(y) + cos(x));
    }

    void drawArrows(){
        PVector max = maxCoords();
        for(int x = -(int)max.x; x <= max.x; x++){
            for(int y = -(int)max.y; y <= max.y; y++){
                strokeWeight(1);
                PVector position = coordToPixel(x, y);
                PVector vector = this.function(new PVector(x, y));
                color mag = getColor(vector.mag());
                vector.normalize();

                fill(mag);
                stroke(mag);
                line(position.x, position.y, position.x + vector.x*scale, position.y - vector.y*scale);
                strokeWeight(4);
                point(position.x + vector.x*scale, position.y - vector.y*scale);
            }
        }
    }
}
