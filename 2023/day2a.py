f = open("day2.txt", "r")
lines = f.readlines()

"""
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
"""

# Part 1
answer = 0
gamenum=1
for line in lines:
    line = line.strip()
    parts = line.split(":")
    games = parts[1]
    games = games.split(";")
    # games is ["3 blue, 4 red", "1 red, 2 green, 6 blue"]
    print(line)
    good = True
    for game in games:
        game = game.strip()
        # balls is ["3 blue", "4 red"]
        balls = game.split(",")
        red=0 
        blue=0 
        green = 0
        for ball in balls:
            ball = ball.strip()
            parts = ball.split(" ")
            if parts[1] == "red":
                red = int(parts[0])
            if parts[1] == "green":
                green = int(parts[0])
            if parts[1] == "blue":
                blue = int(parts[0])
        print("red %d green %d blue %d" %(red, green, blue))
        good = good and not(red > 12 or green > 13 or blue > 14)

    if good:
        answer = answer + gamenum
    gamenum = gamenum + 1

print("Part 1:")
print(answer)

