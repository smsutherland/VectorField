final int historyLength = 20;
final int maxLifeLength = 5;
final int maxLifeTime = 40;

class Particle{
    PVector position;
    PVector[] history = new PVector[historyLength];
    float distance = 0;
    int lifeTime = 0;
    int historyBound = historyLength;
    boolean debug = false;

    Particle(){
        position = new PVector(0, 0);
        for(int i = 0; i < historyLength; i++){
            history[i] = new PVector(position.x, position.y);
        }
    }

    Particle(PVector position_){
        position = position_;
        for(int i = 0; i < historyLength; i++){
            history[i] = new PVector(position.x, position.y);
        }
    }

    Particle(float x, float y){
        position = new PVector(x, y);
        for(int i = 0; i < historyLength; i++){
            history[i] = new PVector(position.x, position.y);
        }
    }

    Particle(float x, float y, Particle old){
        position = new PVector(x, y);
        for(int i = 0; i < old.historyBound; i++){
            history[i] = new PVector(old.history[i].x, old.history[i].y);
        }
        for(int i = old.historyBound; i < historyLength; i++){
            history[i] = new PVector(history[i-1].x, history[i-1].y);
        }
        historyBound = 0;
    }

    void draw(){
        strokeWeight(1);
        PVector pixelPos = coordToPixel(position);
        stroke(200);
        point(pixelPos.x, pixelPos.y);

        for(int i = 0; i < historyLength; i++){
            stroke(200 - i);
            fill(200 - 5*i);
            pixelPos = coordToPixel(history[i]);
            if(i != 0 && i != historyBound){
                PVector prevPixelPos = coordToPixel(history[i-1]);
                line(prevPixelPos.x, prevPixelPos.y, pixelPos.x, pixelPos.y);
            }
            point(pixelPos.x, pixelPos.y);
        }
    }

    void move(int times, float dx){
        for(int i = 0; i < times; i++){
            PVector delta = function(position);
            if(debug){
                println();
                println();
            }
            for(int j = historyLength - 1; j > 0; j--){
                if(debug){
                    println("before", history[j]);
                }
                history[j] = new PVector(history[j - 1].x, history[j - 1].y);
                if(debug){
                    println("after ", history[j]);
                }
            }
            history[0] = position;
            if(historyBound < historyLength){
                historyBound++;
            }

            delta.mult(dx);
            position.add(delta);

            distance += delta.mag();
            lifeTime++;
        }
    }

    void debug(){
        debug = true;
    }

    boolean dead(){
        return distance >= maxLifeLength || lifeTime >= maxLifeTime;
    }
}