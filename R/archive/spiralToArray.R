# FUNCTION: Convert matrix to array ---------------------------------------
spiralToArray <- function(X, Y){
    x <- 0
    y <- 0
    dx <- 0
    dy <- -1
    for (i in 1:max(X,Y)**2){
        if(between(x, -X/2 + 0.5, X/2) & between(y, -Y/2 + 0.5, Y/2)){
            print(paste(x,y))
        }
        if(x == y | (x < 0 & x == -y) | (x > 0 & x == 1-y)){
            dx <- -dy
            dy <- dx
        }
        x <- x + dx
        y <- y + dy
    }
}

spiralToArray(266,13)

def spiral(X, Y):
    x = y = 0
    dx = 0
    dy = -1
    for i in range(max(int(X), int(Y))**2):
        if (-X/2 < x <= X/2) and (-Y/2 < y <= Y/2):
        print (x, y)
    # DO STUFF...
    if x == y or (x < 0 and x == -y) or (x > 0 and x == 1-y):
        dx, dy = -dy, dx
    x, y = x+dx, y+dy
        
        
        