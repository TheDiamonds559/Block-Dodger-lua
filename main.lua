function love.load()
    player = {
        x = 200,
        y = 360,
        speed = 4
    }
    enemy = {
        x = math.random( 100, 450 ),
        y = -50,
        speed = 3
    }
    love.graphics.setBackgroundColor(0, 0, 0)
    love.window.setTitle("Block-Dodger!")
    love.window.setMode(500, 400, {resizable=false})
    running = true
    score = 0
    hscore = 0
    s = 40
end

function love.update(dt)
    if running == true then
        if love.keyboard.isDown("a") then
            player.x = player.x - player.speed
        end
        if love.keyboard.isDown("d") then
            player.x = player.x + player.speed
        end
        if player.x > 460 then
            player.x = 460
        elseif player.x < 100 then
            player.x = 100
        end
        enemy.y = enemy.y + enemy.speed
        if enemy.y + 50 >= player.y and player.x - enemy.x > -39 and player.x - enemy.x < 50 then
            running = false
        end
        if enemy.y > 400 then
            enemy.x = math.random( 100, 450 )
            enemy.y = -50
            score = score + s
            if score > hscore then
                hscore = score
            end
        end
        if score > 500 then
            enemy.speed = 6
        elseif score > 300 then
            player.speed = 1
        elseif score > 200 then
            player.speed = 2
            s = 20
            enemy.speed = 4
        elseif score > 100 then
            player.speed = 3
        end
    elseif love.keyboard.isDown("escape") then
        player.x = 200
        player.speed = 4
        enemy.x = math.random( 100, 450 )
        enemy.y = -50
        enemy.speed = 3
        score = 0
        s = 40
        running = true
    end
end

function love.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", 100, 0, 400, 400)
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", player.x, player.y, 40, 40)
    love.graphics.setColor(0, 0, 255)
    love.graphics.rectangle("fill", enemy.x, enemy.y, 50, 50)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setNewFont(20)
    love.graphics.print("Score: "..score, 280, 0)
    love.graphics.setNewFont(15)
    love.graphics.print("High-score: "..hscore, 265, 25)
    love.graphics.setColor(255, 255, 255)
    love.graphics.setNewFont(12)
    love.graphics.print("100 points\nSpeed reduced\n\n200 points\nPoints reduced\nSpeed reduced\nE. speed increase\n\n300 points\nSnail", 0, 12)
    if running == false then
        love.graphics.setColor(0, 0, 0)
        love.graphics.setNewFont(50)
        love.graphics.print("Game Over!", 150, 150)
    end
end
