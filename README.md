# blocksphysicsgame-v-2

Hi i wanna make a blockgame... this is the secound try. I wanna remake it because, in the old one, i have started a bunch of stuff... even neglected to make every feature multiplayer ready and didnt get the basics to work... so here goes Version 2

This is ment to be a blockbuilding game where a player creates machines with blocks, that are ment to aid him to secure his survival and acomplish various taks and challanges.

Challenges can me missions like putting out fires, getting natural desasters under controll, supply runs, repair missions, wrack retrevial and or servicing/creating of infrastrucute. 

The world itself is not going to be made from blocks, only player buildable structures and vehicles and world structures like cities, infrastructre and alike should be grids.

Grids should be scenes, that are either movable or stationary and contain most of the functionality of the game...

Stationary grids should be placed on "foudation" that foundation should be a block thats intersecting with the ground and can be bought or made and allows the player to have a snap point that is stationary but also be expandable and allows the game to put a pricetag on fixed structure. 

In generall Later i want the world to have a "alive" feel to it. Im thinking mainly about emergent stuff like chunkbased weather, wildlife, as well as NPCs, maybe demand and supply simulations and a simulated economy that the player is taking part of.

## But first the Basics!! 

The Blocks are 20x20x20cm big. That gives a nice round Volume of 8L per Block.

Blocks should have attributes like the material, HP and tempreature in a grid.

enclosed volumes should be recogoniced as such 

there should be "special" geometire pieces. These can but dont have to, span multiple blocks far and allow volumes to connect across their "air space"

enclosed volumes should have attributes like tempreature and pressure as well as keep track of compunds inside like oxygen, water, diesel, Oil, gas, co2, nitrogen and more... with their liquid and gasious forms.

Various reactions between compounds should be possible in a realstic-ish but simplyfied and belivable way that is affected by a volumes pressure and tempreature.

Blocks directly next to a volume should have and affect the volumes tempreature. Blocks should transmitt tempreature to each other.

there should a selection of pipes and ports that transmitt rotational energy as well as gasses or liquids and allow compounds to flow based on pressure and resistance. i guess it will be simelar to uri 

The Ports position in a volume should decide what compound is sucked or pushed out of a volume from pressure differences. depending compounds density (forming layers)

there should be "parts" that can span multiple blocks wide, high and far that are things like engines and motors, valves, pumps, batteries and alike that do specific things, i think these will be speperate scenes

The Main way stuff is build should be in a designer, that allows the player to move the camera freely, have different views, symetrie and buildin0g aids...

Im on the edge if handplacing blocks should even be possible because it will be hard to implement "right", with rerecigonizing volumes while not in the desinger etc... BUT: Hand building is highly interesting because that way things like deposits from chemical reactions could be a thing too which would be sad to miss out on - that goes even as far as... players having to create their own metalblocks in a "hardcore mode" by melting metal in a stone curicable thing and then gathering them... sounds completly awesome actually hurr~~~ it would make players want to automate a smeltery and supply it and stuff... which is one way of playing for sure lol

there needs to be a way to create subgrids. For Example, though a hinge block that provides a hinge that can be used for mechenical tasks and just creates a new grid that is connected to its parent grid though a physics constraint. Different things could be hydraullic or electric Motors, servos and Pistons but thats later i guess~~~

## Hydrodynamic and arodynamic system

I want to have a hydrodynamic and arodynamic system. one thing that will be pretty hard i think, is making it so, that water behaves more like irl.

Often games highly simplify the arodynamics logic and so taught me some things about water that dont align with reality i would like to get closer to reality.

often games complelty neglect the tendency for fluids to stick to surfaces if i can simulate that i would allrady be happy...

I'm thinking of either a particle based system.

When a vehicle moves more then 30kmps it would spawn particles in front of the things that cause forces to happen... those could provably made to stick... I think a simelar thing could be done with blocks actually instead of particulates ... only afraid that it would become unregular as in the forces arent distributed equaally ... but thats an issue with probably every particulate system that that dosent use thousands of particulats .... and in that case i can probably go with the block based system anyway lol..

Or just a more common divergence aproach that happens in the 20x20x20 raster. An issue is going to be to implement slopes and stuff but ya ill see

## Other Game Systems

a System Simelar to Wiremod that enables the player to controll Machines though logic circuits and programming

Hydraulics as in pumping liquiods that will drive different types of motors, pistions and stuff based on flow and pressure

A Simplified Electric Simulation based on PUI and URI would be really nice... but no AC xD just DC voltage converters, that change voltage and current simearly to ac transfroms do irl


### wishfull thinking... 

i want to enable the player to build traintracks in some way that are actually usable i dunno how thats going to look though...

i kinda wanna make this game support VR and have the Seats be compatible with VR also. I think it would be great if the player could literaly controll his creations with the VR joystics. I can easily think of many interesting controll schemes... normal joystic controlls like in excavators but also positional controll where the positions and rotaions of both controllers are outputted like mech Controlls with arms sort off, as well as boat and plane like controll schemes. The issue is going to be motion sickness 🤣 and not forcing the player to choose between vr and desktop controlles but having both implemented to be usefull in both instances. 




