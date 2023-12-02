f = open("day2.txt", "r")
lines = f.readlines()

"""
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
"""

# Part 2
answer = 0
for line in lines:
    line = line.strip()
    parts = line.split(":")
    games = parts[1]
    games = games.split(";")
    # games is ["3 blue, 4 red", "1 red, 2 green, 6 blue"]
    print(line)
    # max red, green, blue
    red = 0
    green = 0
    blue = 0
    for game in games:
        game = game.strip()
        # balls is ["3 blue", "4 red"]
        balls = game.split(",")
        for ball in balls:
            ball = ball.strip()
            parts = ball.split(" ")
            if parts[1] == "red":
                red = max(red, int(parts[0]))
            if parts[1] == "green":
                green = max(int(parts[0]), green)
            if parts[1] == "blue":
                blue = max(blue, int(parts[0]))
        print("red %d green %d blue %d" % (red, green, blue))
    power = red * green * blue
    answer = answer + power

print("Part 2:")
print(answer)

