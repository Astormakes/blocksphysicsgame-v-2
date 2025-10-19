# blocksphysicsgame-v-2

Hi i wanna make a blockgame... this is the secound try i wanna remake it because i have started a bunch of stuff...
even neglected to make every feature multiplayer ready and didnt get the basics to work...
This is ment to be a blockbuilding game where a player creates machines with blocks, that are ment to aid him to secure his survival and acomplish various taks and challanges.
Challenges can me mission like adventures like putting out fires, getting natural desasters under controll or supply runs 

The world itself is not going to be made from blocks, only player buildable structures and vehicales and world structures like cities, infrastructre and alike should be grids.

Grids should be scenes, that are either movable or stationary and contain most of the functionality of the game...
Stationary grids should be placed on "foudation" that foundation should be a blcok thats intersecting the ground and can be bought or made and allows the player to have a snap point

In generall Later i want the world to have a "alive" feel to it. Im thinking mainly about emergent stuff like chunkbased weather, wildlife, and alike as well as NPCs

But first the Basics:
	
Building system:
The Blocks are should be 20x20x20cm big.
Blocks should have attributes like the material, HP, tempreature in a grid
enclosed volumes should be recogoniced as such
enclosed volumes should have attributes like tempreature and pressure as well as different compunds inside like oxygen, water, diesel, gas, co2, nitrogen and more... with their gasious forms as well.
Various reactions between compounds should be possible in a realstic-ish but simplyfied and belivable way that is affected by a volumes pressure and tempreature.
there should be "special" geometire pieces. These can but dont have to, span multiple blocks far and allow volumes to connect across their "air space"
Blocks directly next to a volume should have and affect the volumes tempreature. Blocks should transmitt tempreature to each other.
there should a selection of pipes and ports that transmitt rotational energy as well as volumes together and allow compounds to flow based on pressure.
The Ports position in a volume should decide what compound is sucked or pushed out of a volume. depending compounds density (forming layers)
there should be "parts" that can span multiple blocks wide, high and far that are things like engines and motors, valves, pumps, batteries and alike that do specific things
Special Parts should be player controlled or controlled by controll logic that the player has made but thats way later....
The Main way stuff is build should be in a designer, that allows the player to move the camera freely, have different views, symetrie and building aids...
Im on the edge if handplacing blocks should even be possible because it will be hard to implement "right"
Hand building is highly interesting because thatway things like deposits from chemical reactions could be a thing too which would be sad to miss out on - that goes even as far as... players having to create their own metalblocks in hardcore by melting metal in a stone thing and then gathering them... sounds completly awesome actually hurr~~~ 


Hydrodynamic and arodynamic system:

I want to have a hydrodynamic and arodynamic system. one thing that will be pretty hard i think, is making it so, that water behaves more like irl.
Often games highly simplify the arodynamics logic and so taught me some things about water that dont align with reality i would like to get closer to reality.
often games complelty neglect the tendency for fluids to stick to surfaces if i can simulate that i would allrady be happy...
I'm thinking of either a particle based system. 
When a vehicle moves more then 30kmps it would spawn particles in front of the things that cause forces to happen... those could provably made to stick... 

Or just a more common divergence aproach that happens in the 20x20x20 raster. An issue is going to be to implement slopes and stuff but ya ill see
