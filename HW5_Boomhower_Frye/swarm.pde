void explode( ) {
    for (PVector p : points ) {
        p.x = random(-amplitude*gain/200,amplitude*gain/200) ;
        p.y = random(-amplitude*gain/200,amplitude*gain/200) ;
    }
}