menu = {"", "", "","New Game", "Shop", "About", "Exit", "", "", ""}
store = {"", "", "", "","Booste", "Booste x3", "Freeze", "Freeze x3", "Destructor", "Destructor x3", "Green", "Yellow", "Purple", "", "", "", ""}
retry = {"","Retry", "Shop", "Return to menu",""}
about = {"", "", "", "","Developer: Applelo","","Co-Developer: psgarsenal","","Music: Applelo","", "Design: Applelo","","Co-design: Samir88Nasri","","Starfield function by Shine","", "Shop Picture by Teekatas Suwannakrua","", "Thanks to Team Zenyth member for the help.","", "Name Project Contribuor: Sylwer, fanou18,", "BlastersDeath, monsterhunter42 and my ^^","", "If you like the homebrew go on http://team-zenyth.zz.mu","","","CC BY-NC-ND Attribution-NonCommercial 3.0 Unported","", "http://creativecommons.org/licenses/by-nc/3.0/legalcode","","Version 1.00","", "", "", ""}
System.setCpuSpeed(333)
background = Image.load("splash/fond.png")
selecteur = 4
t = 0
tu = 480
space = Image.load("splash/mascotte.png")
background = Image.load("splash/fond.png")
fond = Image.load("splash/fond.png")
team = Image.load("splash/titre.png")
blanc = Color.new(255,255,255)
vert = Color.new(0,255,0)
violet = Color.new(102,0,153)
jaune = Color.new(255,255,0)
bleu = Color.new(0,204,204)
rouge = Color.new(255,0,0)
nil_color = Color.new(0,0,0,0)
font = IntraFont.load("flash0:/font/ltn8.pgf",0)
task = 0
enabled = true
effect = "default"
effect_cube = blanc
effect_vari = 0
booste = false
buy_statut = false
booste_vari = 0
vari = 0
loca = 0
rabout = 0
stall = {10,false}
choose = "bleu"
size = 200
zMax = 5
speed = 0.1
louil = 35
width = 480
height = 272

starfield = {}
math.randomseed(os.time())

function createStar(i)
	starfield[i] = {}
	starfield[i].x = math.random(2*width) - width
	starfield[i].y = math.random(2*height) - height
	starfield[i].z = zMax
end

for i = 1, size do
	createStar(i)
	starfield[i].z = math.random(zMax)
end


function persomove()
if math.abs(pad:analogY()) > louil then
perso.y = perso.y + pad:analogY() / louil
end
if math.abs(pad:analogX()) > louil then
perso.x = perso.x + pad:analogX() / louil
end
if pad:left() then
perso.x = perso.x - 3 - booste_vari
end
if pad:right() then
perso.x = perso.x + 3 + booste_vari
end
if pad:down() then
perso.y = perso.y + 3 + booste_vari
end
if pad:up() then
perso.y = perso.y - 3 - booste_vari
end
end



function IA(ennemytable)
if enabled == true then
statut[ennemytable] = math.random(0,500)
end
if statut[ennemytable] == 0 or  statut[ennemytable] == 500 then
enabled = false
loca = loca + 1
if perso.x > ennemy[ennemytable].x then
ennemy[ennemytable].x = ennemy[ennemytable].x - 1
end
if perso.x < ennemy[ennemytable].x then
ennemy[ennemytable].x = ennemy[ennemytable].x + 1
end
if perso.y > ennemy[ennemytable].y then
ennemy[ennemytable].y = ennemy[ennemytable].y - 1
end
if perso.y < ennemy[ennemytable].y then
ennemy[ennemytable].y = ennemy[ennemytable].y + 1
end
if loca > 50 then
loca = 0
enabled = true
end
end


if perso.x >= ennemy[ennemytable].x - 30 and perso.x <= ennemy[ennemytable].x + 30 and perso.y >= ennemy[ennemytable].y - 30 and perso.y <= ennemy[ennemytable].y + 30 then
stall[2] = true
end

if statut[ennemytable] > 0 then
if perso.x > ennemy[ennemytable].x then
ennemy[ennemytable].x = ennemy[ennemytable].x + 1
end
if perso.x < ennemy[ennemytable].x then
ennemy[ennemytable].x = ennemy[ennemytable].x - 1
end
if perso.y > ennemy[ennemytable].y then
ennemy[ennemytable].y = ennemy[ennemytable].y + 1
end
if perso.y < ennemy[ennemytable].y then
ennemy[ennemytable].y = ennemy[ennemytable].y - 1
end
end


end

function menu_f()
Mp3.play(true, 0)
 

font:setStyle(1.0, blanc,Color.new(255,255,255,100), 0)
font:print(300, 40,"High Score: "..save.hightscore)
font:print(300, 60,"Cubenergie:"..save.cubenergie)
font:print(300, 80,"Booste:"..save.item_amount[1])
font:print(300, 100,"Freeze:"..save.item_amount[2])
font:print(300, 120,"Destructor:"..save.item_amount[3])
font:print(100, 40, menu[selecteur-3])
font:print(100, 60, menu[selecteur-2])
font:print(100, 80, menu[selecteur-1])
font:print(100, 120, menu[selecteur+1])
font:print(100, 140, menu[selecteur+2])
font:print(100, 160, menu[selecteur+3])
font:setStyle(1.0, blanc,Color.new(0,0,0,20), 0)
font:print(100, 100, menu[selecteur])
font:print(90, 100, ">")

if pad:up() and not oldpad:up() then selecteur = selecteur - 1 end
if pad:down() and not oldpad:down() then selecteur = selecteur + 1 end
if selecteur > 7 then selecteur = 4 end
if selecteur < 4 then selecteur = 7 end	

if pad:left() and not oldpad:left() then t = t - 1 end
if pad:right() and not oldpad:right() then t = t + 1 end
if t > 4 then t = 1 end
if t < 1 then t = 4 end	

if t == 1 then
screen:fillRect(300,200,30,30,bleu)
choose = "bleu"
font:print(332, 230, "Choose!")
elseif t == 2 and save.item_cube[1] == 1 then
screen:fillRect(300,200,30,30,vert)
choose = "vert"
font:print(332, 230, "Choose!")
elseif t == 2 and save.item_cube[1] == 0 then
screen:fillRect(300,200,30,30,vert)
choose = "bleu"
font:print(332, 230, "Buy the color")
elseif t == 3  and save.item_cube[2] == 1  then
screen:fillRect(300,200,30,30,jaune)
choose = "jaune"
font:print(332, 230, "Choose!")
elseif t == 3 and save.item_cube[2] == 0 then
screen:fillRect(300,200,30,30,jaune)
choose = "bleu"
font:print(332, 230, "Buy the color")
elseif t == 4  and save.item_cube[3] == 1  then
screen:fillRect(300,200,30,30,violet)
choose = "violet"
font:print(332, 230, "Choose!")
elseif t == 4 and save.item_cube[3] == 0 then
screen:fillRect(300,200,30,30,violet)
choose = "bleu"
font:print(332, 230, "Buy the color")
end


if pad:cross() and not oldpad:cross() then
if selecteur == 4 then
Mp3.unload(0)
Mp3.load("music/electowars.mp3", 1)
selecteur = 4
task = 301
elseif selecteur == 5 then 
selecteur = 5
imageshop = {booste = Image.load("image/booste.png"),destructor = Image.load("image/destructor.png"), freeze = Image.load("image/freeze.png"), cube = Image.createEmpty(128, 128)}
task = 4
elseif selecteur == 6 then 
selecteur = 5
task = 5
elseif selecteur == 7 then
System.quit()
end
end
end

function loadgame_f()
perso = {x = 2, y = 5, cube = 0}
ennemy = {{x = 500, y = 78},{x = 100, y = 278}, {x = 500, y = 278}, {x = 800, y = 108}, {x = -100, y = 278}}
cubenergie = {x = 0, y = 0, amount = 0}
if choose == "bleu" then
cube = bleu
elseif  choose == "vert" then
cube = vert
elseif  choose == "jaune" then
cube = jaune
elseif  choose == "violet" then
cube = violet
end
cubenergie.x = math.random(0,480)
cubenergie.y = math.random(0,272)
statut = {0,0,0,0,0}
task = 3
end

function game_f()

if stall[2] == true then
stall[1] = stall[1] - 1
if stall[1] < 0 then
task = 31
end
end

--EFFET OUAIS--
if effect == "default" then
effect_enabled = false
effect_cube = blanc
elseif effect == "bleu" then
effect_enabled = true
effect_cube = bleu
elseif effect == "vert" then
effect_enabled = true
effect_cube = vert
elseif effect == "rouge" then
effect_enabled = true
effect_cube = rouge
end
if effect_enabled == true then
effect_vari = effect_vari + 1
end
if effect_vari > 1000 then
effect_vari = 0
effect = "default"
end
screen:fillRect(cubenergie.x,cubenergie.y,10,10,Color.new(math.random(0,255),math.random(0,255),math.random(0,255)))

if perso.x >= cubenergie.x - 30 and perso.x <= cubenergie.x + 30 and perso.y >= cubenergie.y - 30 and perso.y <= cubenergie.y + 30 then
cubenergie.x = math.random(0,470)
cubenergie.y = math.random(0,262)
cubenergie.amount = cubenergie.amount + 1
end
Mp3.play(true, 1)
 
font:setStyle(1.0, blanc,nil_color, 0)
if pad:l() then
font:print(10, 20, "Cubenergie: "..cubenergie.amount)
end
if pad:r() then
font:print(10, 60,"Booste:"..save.item_amount[1])
font:print(10, 80,"Freeze:"..save.item_amount[2])
font:print(10, 100,"Destructor:"..save.item_amount[3])
end
screen:fillRect(perso.x,perso.y,30,30,cube)
persomove()
if cubenergie.amount > 1 and stall[1] > 9 then
screen:fillRect(ennemy[1].x,ennemy[1].y,30,30,rouge)
IA(1)
end
if cubenergie.amount > 10 and stall[1] > 7 then
screen:fillRect(ennemy[2].x,ennemy[2].y,30,30,rouge)
IA(2)
end
if cubenergie.amount > 20 and stall[1] > 5 then
screen:fillRect(ennemy[3].x,ennemy[3].y,30,30,rouge)
IA(3)
end
if cubenergie.amount > 50 and stall[1] > 3 then
screen:fillRect(ennemy[4].x,ennemy[4].y,30,30,rouge)
screen:fillRect(ennemy[5].x,ennemy[5].y,30,30,rouge)
IA(4)
IA(5)
end

----------------
if save.item_amount[2] >= 1 and  pad:triangle() and not oldpad:triangle() then
loca = -950
save.item_amount[2] = save.item_amount[2] - 1
enabled = false
statut[1] = 500
statut[2] = 500
statut[3] = 500
statut[4] = 500
statut[5] = 500
effect = "bleu"
end
----------------
if pad:square() and not oldpad:square() and save.item_amount[1] >= 1 then
save.item_amount[1] = save.item_amount[1] - 1
effect = "vert"
booste = true
end
if booste == true then
louil = 15
booste_vari = 3
vari = vari + 1
if vari > 1000 then
booste = false
booste_vari = 0
louil = 35
vari = 0
end
end
----------------
if pad:circle() and not oldpad:circle() and save.item_amount[3] >= 1 then
save.item_amount[3] = save.item_amount[3] - 1
ennemy[1].x = math.random(800,2000)
ennemy[1].y = math.random(500,2000)

ennemy[2].x = math.random(800,2000)
ennemy[2].y = math.random(500,2000)

ennemy[3].x = math.random(800,2000)
ennemy[3].y = math.random(500,2000)

ennemy[4].x = math.random(800,2000)
ennemy[4].y = math.random(500,2000)

ennemy[5].x = math.random(800,2000)
ennemy[5].y = math.random(500,2000)
effect = "rouge"
end

if perso.x < 0 then perso.x = 0 elseif perso.x + 30 > 480 then perso.x = 480 -  30 end
if perso.y < 0 then perso.y = 0 elseif perso.y + 30 > 272 then perso.y = 272 -  30 end
collectgarbage()
end

function nil_game_f()
effect_cube = blanc
louil = 35
Mp3.stop(1)
selecteur = 4
Mp3.unload(1)
perso = nil
ennemy = nil
statut = nil
stall[2] = false
stall[1] = 10
effect = "default"
booste = false
booste_vari = 0
vari = 0
loca = 0
enabled = true
if save.hightscore < cubenergie.amount then
save.hightscore = cubenergie.amount
end
save.cubenergie = save.cubenergie + cubenergie.amount
file = io.open("save.z","w")
save = "save = {hightscore = "..save.hightscore.." , cubenergie = "..save.cubenergie..", item_amount = {"..save.item_amount[1]..","..save.item_amount[2]..","..save.item_amount[3].."}, item_cube = {"..save.item_cube[1].." ,"..save.item_cube[2].." ,"..save.item_cube[3].."} }"
file:write(save)
file:close()
save = nil
dofile("save.z")
selecteur = 2
collectgarbage()
task = 32
end

function retry_f()
font:setStyle(1.0, blanc,Color.new(255,255,255,100), 0)
font:print(300, 20,"Score: "..cubenergie.amount)
font:print(300, 40,"High Score: "..save.hightscore)
font:print(300, 60,"Cubenergie:"..save.cubenergie)
font:print(300, 80,"Booste:"..save.item_amount[1])
font:print(300, 100,"Freeze:"..save.item_amount[2])
font:print(300, 120,"Destructor:"..save.item_amount[3])

font:print(100, 80, retry[selecteur-1])
font:print(100, 120, retry[selecteur+1])
font:setStyle(1.0, blanc,Color.new(0,0,0,20), 0)
font:print(100, 100, retry[selecteur])
font:print(90, 100, ">")

if pad:up() and not oldpad:up() then selecteur = selecteur - 1 end
if pad:down() and not oldpad:down() then selecteur = selecteur + 1 end
if selecteur > 4 then selecteur = 2 end
if selecteur < 2 then selecteur = 4 end	


if pad:cross() and not oldpad:cross() then
if selecteur == 2 then
Mp3.load("music/electowars.mp3", 1)
selecteur = 4
cubenergie.amount = 0
cubenergie = nil
task = 301
elseif selecteur == 3 then 
selecteur = 5
imageshop = {booste = Image.load("image/booste.png"),destructor = Image.load("image/destructor.png"), freeze = Image.load("image/freeze.png")}
cubenergie.amount = 0
cubenergie = nil
task = 4
elseif selecteur == 4 then
Mp3.load("music/cublazar.mp3", 0)
selecteur = 4 
cubenergie.amount = 0
cubenergie = nil
task = 2
end
end
end

function store_f()
font:setStyle(1.0, blanc,Color.new(255,255,255,100), 0)
font:print(100, 40, store[selecteur-4])
font:print(100, 60, store[selecteur-3])
font:print(100, 80, store[selecteur-2])
font:print(100, 100, store[selecteur-1])
font:print(100, 140, store[selecteur+1])
font:print(100, 160, store[selecteur+2])
font:print(100, 180, store[selecteur+3])
font:print(100, 200, store[selecteur+4])
font:print(300, 40,"Cubenergie:"..save.cubenergie)
font:setStyle(1.0, blanc,nil_color, 0)
font:print(90, 120, ">")
font:print(100, 120, store[selecteur])
font:setStyle(1.0, blanc,Color.new(255,255,255,100), 0)

if pad:up() and not oldpad:up() then selecteur = selecteur - 1 end
if pad:down() and not oldpad:down() then selecteur = selecteur + 1 end
if selecteur > 13 then selecteur = 5 end
if selecteur < 5 then selecteur = 13 end

--Affichage des items et des prix
if selecteur == 5 then
buy = 35
screen:blit(300,100,imageshop.booste)
if buy <= save.cubenergie then
buy_statut = true
else
buy_statut = false
end
elseif selecteur == 6 then
font:print(428, 228,"x3")
screen:blit(300,100,imageshop.booste) 
buy = 55
if buy <= save.cubenergie then
buy_statut = true
else
buy_statut = false
end
elseif selecteur == 7 then
screen:blit(300,100,imageshop.freeze) 
buy = 40
if buy <= save.cubenergie then
buy_statut = true
else
buy_statut = false
end
elseif selecteur == 8 then
font:print(428, 228,"x3")
screen:blit(300,100,imageshop.freeze) 
buy = 70
if buy <= save.cubenergie then
buy_statut = true
else
buy_statut = false
end
elseif selecteur == 9 then
screen:blit(300,100,imageshop.destructor)
buy = 50
if buy <= save.cubenergie then
buy_statut = true
else
buy_statut = false
end
elseif selecteur == 10 then
font:print(428, 228,"x3")
screen:blit(300,100,imageshop.destructor)
buy = 90
if buy <= save.cubenergie then
buy_statut = true
else
buy_statut = false
end
elseif selecteur == 11 then
screen:fillRect(320,130,90,90,vert)
buy = 250
if save.item_cube[1] == 1 then
buy_statut = "sold"
elseif buy <= save.cubenergie then
buy_statut = true
elseif buy >= save.cubenergie then
buy_statut = false
end
elseif selecteur == 12 then
screen:fillRect(320,130,90,90,jaune)
buy = 300
if save.item_cube[2] == 1 then
buy_statut = "sold"
elseif buy <= save.cubenergie then
buy_statut = true
elseif buy >= save.cubenergie then
buy_statut = false
end
elseif selecteur == 13 then
screen:fillRect(320,130,90,90,violet)
buy = 450
if save.item_cube[3] == 1 then
buy_statut = "sold"
elseif buy <= save.cubenergie then
buy_statut = true
elseif buy >= save.cubenergie then
buy_statut = false
end
end

if buy_statut == false then
font:setStyle(1.0, rouge,Color.new(255,255,255,100), 0)
font:print(40, 260,"Cubenergie: "..buy)
elseif buy_statut == true then
font:setStyle(1.0, vert,Color.new(255,255,255,100), 0)
font:print(40, 260,"Cubenergie: "..buy)
elseif buy_statut == "sold" then
font:setStyle(1.0, blanc,Color.new(255,255,255,100), 0)
font:print(40, 260,"Sold")
end


--Achat ou pas!
if pad:cross() and not oldpad:cross() then
if selecteur == 5 then
if save.cubenergie <= buy then
--
else
save.item_amount[1] = save.item_amount[1] + 1
save.cubenergie = save.cubenergie - buy
end
elseif selecteur == 6 then 
if save.cubenergie <= buy then
--
else
save.item_amount[1] = save.item_amount[1] + 3
save.cubenergie = save.cubenergie - buy
end
elseif selecteur == 7 then 
if save.cubenergie <= buy then
--
else
save.item_amount[2] = save.item_amount[2] + 1
save.cubenergie = save.cubenergie - buy
end

elseif selecteur == 8 then
if save.cubenergie <= buy then
--
else
save.item_amount[2] = save.item_amount[2] + 3
save.cubenergie = save.cubenergie - buy
end

elseif selecteur == 9 then
if save.cubenergie <= buy then
--
else
save.item_amount[3] = save.item_amount[3] + 1
save.cubenergie = save.cubenergie - buy
end

elseif selecteur == 10 then
if save.cubenergie <= buy then
--
else
save.item_amount[3] = save.item_amount[3] + 3
save.cubenergie = save.cubenergie - buy
end

elseif selecteur == 11 then
if save.cubenergie <= buy or save.item_cube[1] == 1 then
--
else
save.item_cube[1] = 1
save.cubenergie = save.cubenergie - buy
end


elseif selecteur == 12 then
if save.cubenergie <= buy or save.item_cube[2] == 1 then
--
else
save.item_cube[2] = 1
save.cubenergie = save.cubenergie - buy
end



elseif selecteur == 13 then
if save.cubenergie <= buy or save.item_cube[3] == 1 then
--
else
save.item_cube[3] = 1
save.cubenergie = save.cubenergie - buy
end
end
end
if save.cubenergie < 0 then
save.cubenergue = 0
end
if pad:circle() then
file = io.open("save.z","w")
save = "save = {hightscore = "..save.hightscore.." , cubenergie = "..save.cubenergie..", item_amount = {"..save.item_amount[1]..","..save.item_amount[2]..","..save.item_amount[3].."}, item_cube = {"..save.item_cube[1].." ,"..save.item_cube[2].." ,"..save.item_cube[3].."} }"
file:write(save)
file:close()
save = nil
dofile("save.z")
Image.free(imageshop.freeze)
Image.free(imageshop.booste)
Image.free(imageshop.destructor)
buy = nil
selecteur = 4
task = 2
end
end

function about_f()
font:setStyle(1.0, blanc,Color.new(255,255,255,100), 0)
font:print(20, 40, about[selecteur-4])
font:print(20, 60, about[selecteur-3])
font:print(20, 80, about[selecteur-2])
font:print(20, 100, about[selecteur-1])
font:print(20, 140, about[selecteur+1])
font:print(20, 160, about[selecteur+2])
font:print(20, 180, about[selecteur+3])
font:print(20, 200, about[selecteur+4])
font:setStyle(1.0, blanc,nil_color, 0)
font:print(20, 120, about[selecteur])
if selecteur > 30 then selecteur = 5 end
if selecteur < 5 then selecteur = 30 end
if pad:circle() and not oldpad:circle() then
selecteur = 4
rabout = 0
task = 2
end
rabout = rabout + 100
if rabout > 5000 then
selecteur = selecteur + 1
rabout = 0
end
end



-------------------------------------------------------------
while true do
pad = Controls.readPeek()
System.draw()
screen:clear()
for i = 1, size do
		starfield[i].z = starfield[i].z - speed
		if starfield[i].z < speed then createStar(i) end
		x = width / 2 + starfield[i].x / starfield[i].z
		y = height / 2 + starfield[i].y / starfield[i].z
		if x < 0 or y < 0 or x >= width or y >= height then
			createStar(i)
		else
			screen:pixel(x, y, effect_cube)
		end
	end

if task == 0 then
Mp3.load("music/cublazar.mp3", 0)
dofile("save.z")
task = 1
--Animation
elseif task == 1 then
while t < 255 do
 System.draw()
 screen:clear()
 screen:blit(0,0,background,t)
 t = t+1
 System.endDraw()
 screen.flip()
end
while x >= 0 do
 System.draw()
 screen:clear()
 screen:blit(0,0,background)
 screen:blit(x,0,space)
 screen:blit(-x,0,team)
 x = x-1.5
 System.endDraw()
 screen.flip()
end
t = 255
while t ~= 0 do
 System.draw()
 screen:clear()
 screen:blit(0,0,background)
 screen:blit(0,0,space)
 screen:blit(0,0,team,t)
 System.endDraw()
 t = t-3
 screen.flip()
end
t = 255
while t ~= 0 do
 System.draw()
 screen:clear()
 screen:blit(0,0,background)
 screen:blit(0,0,space,t)
 System.endDraw()
 t = t-3
 screen.flip()
end
t = 255
while t ~= 0 do
 System.draw()
 screen:clear()
 screen:blit(0,0,fond)
 screen:blit(0,0,background,t)
 System.endDraw()
 t = t-3
 screen.flip()
end
t = 0
while t ~= 255 do
 System.draw()
 screen:clear()
 screen:blit(0,0,fond)
 screen:blit(0,0,fond,t)
 System.endDraw()
 t = t+3
 screen.flip()
end
Image.free(space)
Image.free(fond)
Image.free(background)
Image.free(team)
t = 1
task = 2
--Menu
elseif task == 2 then
menu_f()
elseif task == 301 then
loadgame_f()
elseif task == 3 then
game_f()
elseif task == 31 then
nil_game_f()
elseif task == 32 then
retry_f()
elseif task == 4 then
store_f()
elseif task == 5 then
about_f()
end
oldpad = pad
System.endDraw()
screen.waitVblankStart()
screen.flip()
end