assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x78
p2maxhealth = 0x78

p1maxmeter = 0x80
p2maxmeter = 0x80

local p1direction = 0x100458
local p2direction = 0x100558

local p1guarddamage = 0x10ACE4
local p2guarddamage = 0x10ADE4

local maxguarddamagetable = 0x21E402
local p1characterindex = 0x100411
local p2characterindex = 0x100511

function gamemsg()
    print "Known issues with garou:"
    print "hitboxes don't currently work"
end

translationtable = {
    "left",
    "right",
    "up",
    "down",
    "button1",
    "button2",
    "button3",
    "button4",
    "coin",
    "start",
    "select",
    ["Left"] = 1,
    ["Right"] = 2,
    ["Up"] = 3,
    ["Down"] = 4,
    ["Button A"] = 5,
    ["Button B"] = 6,
    ["Button C"] = 7,
    ["Button D"] = 8,
    ["Coin"] = 9,
    ["Start"] = 10,
    ["Select"] = 11,
}

gamedefaultconfig = {
    hud = {
        combotextx=145,
        combotexty=40,
        comboenabled=true,
        p1healthx=6,
        p1healthy=16,
        p1healthenabled=true,
        p2healthx=303,
        p2healthy=16,
        p2healthenabled=true,
        p1meterx=90,
        p1metery=208,
        p1meterenabled=true,
        p2meterx=222,
        p2metery=208,
        p2meterenabled=true,
		p1guarddamagetextx = 8,
		p1guarddamagetexty = 32,
		p1guarddamagemetertopy = 33,
		p1guarddamagemeterleftx = 30,
        p1guarddamageenabled=true,
		p2guarddamagetextx = 296,
		p2guarddamagetexty = 32,
		p2guarddamagemetertopy = 33,
		p2guarddamagemeterrightx = 292,
        p2guarddamageenabled=true,
		guarddamagemeterheight = 4,
		guarddamagemeterwidth = 30,
    },
}

-- An actual runtime lookup into the game's table requires a bank switch via 0x2FFFC0. In FBNeo this is implemented
-- with a garou-specific handler on the m68k's WriteWord(). However, all writes exposed to lua ultimately go through
-- the cheat framework, which always writes single bytes at a time, even when calling memory.writeword or other larger writes.
-- So, we'll just hard-code characters' max guard damage values here.
local maxguardtable = {
    0x37, -- Terry
    0x37, -- Rock
    0x37, -- Dong
    0x37, -- Jae Hoon
    0x32, -- Hotaru
    0x37, -- Gato
    0x32, -- Jenet
    0x37, -- Marco
    0x32, -- Hokutomaru
    0x37, -- Freeman
    0x3C, -- Tizoc
    0x3C, -- Kevin
    0x3C, -- Grant
    0x3C, -- Kain
}

function playerOneFacingLeft()
    return rb(p1direction)==0
end

function playerTwoFacingLeft()
    return rb(p2direction)==0
end

function playerOneInHitstun()
    return rb(0x10a39D)~=0
end

function playerTwoInHitstun()
    return rb(0x10a39C)~=0
end

function readPlayerOneHealth()
    return rb(0x10048E)
end

function writePlayerOneHealth(health)
    wb(0x10048E, health)
end

function readPlayerTwoHealth()
    return rb(0x10058E)
end

function writePlayerTwoHealth(health)
    wb(0x10058E, health)
end

function readPlayerOneMeter()
    return rb(0x1004BE)
end

function writePlayerOneMeter(meter)
    wb(0x1004BE, meter)
end

function readPlayerTwoMeter()
    return rb(0x1005BE)
end

function writePlayerTwoMeter(meter)
    wb(0x1005BE, meter)
end

function readPlayerOneGuardDamage()
    return rb(p1guarddamage)
end

function readPlayerOneMaxGuardDamage()
    return maxguardtable[rb(p1characterindex) + 1]
end

function readPlayerTwoGuardDamage()
    return rb(p2guarddamage)
end

function readPlayerTwoMaxGuardDamage()
    return maxguardtable[rb(p2characterindex) + 1]
end

function infiniteTime()
    memory.writebyte(0x107490,0x99)
end

function maxCredits()
    memory.writebyte(0x10E008, 0x09)
    memory.writebyte(0x10E009, 0x09)
end

function Run() -- runs every frame
    infiniteTime()
    maxCredits()
end
