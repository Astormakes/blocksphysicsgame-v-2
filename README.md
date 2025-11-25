# blocksphysicsgame-v-2

Hi i wanna make a blockgame... this is the secound try. I wanna remake it because, in the old one, i have started a bunch of things, without finishing them and even neglected to make every feature multiplayer ready and didnt get the basics to work right... so here goes Version 2:

This is ment to be a blockbuilding game where a player creates machines with blocks, that are ment to aid him to secure his survival and acomplish various taks and challanges.

Challenges can me missions like putting out fires, getting natural desasters under controll, supply runs, repair missions, wrack retrevial and or servicing/creating of infrastrucute. 

The world itself is not going to be made from blocks, only player buildable structures and vehicles as well as world structures like cities nad infrastructre should be grids.

Grids should be scenes, that are either movable or stationary and contain most of the functionality of the game...

Stationary grids should start as foundation. Thats a lot of blocks intersecting with the ground that can be bought or made and allows the player to have a snap point that is stationary and expandable.

In generall Later i want the world to have a "alive" feel to it. Im thinking mainly about emergent stuff like chunkbased weather, wildlife, as well as NPCs, maybe demand and supply simulations and a simulated economy that the player is taking part of.

## But first the Basics!! 

The Blocks are 20x20x20cm big. That gives a nice round Volume of 8L per Block.

Blocks should have attributes like the material, HP and tempreature? in a grid.

enclosed volumes should be recogoniced as such 

there should be "special" geometire pieces. These can but dont have to, span multiple blocks far and allow volumes to connect across their "air space" an example of that would be a "shape" like a 1x1x2 slope

enclosed volumes should have attributes like tempreature and pressure as well as keep track of compunds inside which compounds are going to be part of the game still has to be determend... but its probably going to include nitrogen, oxygen, diesel, oil, Cerosine, salt and a bunch of others... with their solid, liquid and gasious forms.

Various reactions between compounds should be possible in a realstic-ish but simplyfied and belivable way that is affected by a volumes pressure and tempreature.

Blocks directly next to a volume should transmit/recieve the volumes tempreature? Blocks should transmitt tempreature to each other?

there should a selection of pipes and ports that transmitt rotational energy as well as gasses or liquids to allow compounds to flow based on pressure and resistance. i guess it will be simelar to Ohmes Law (u= r*i) 

The Ports position in a volume should decide what compound is sucked or pushed out of a volume from pressure differences. depending compounds density (forming layers or even mixing)

there should be "parts" that can span multiple blocks wide, high and far that are things like engines and motors, valves, pumps, batteries, levers, sensors, switches and alike that various things, i think these will be speperate scenes

The Main way stuff is build should be in a designer, that allows the player to move the camera freely, have different views, symetrie options and building aids...

I was on the edge if handplacing blocks should even be possible because i'm not 100% sure if i can implement if consistently. But i decided to make it a thing because the options if gives are just far too great. Things like salt deposits in a boilder that have to be cleared out, smelting and gathering blocks, emergency reparis and retro fits situations in which a player might be stranded but is able to save himself by beying creative sounds like a great outlook to me. 

there needs to be a way to create subgrids. For Example, though a hinge block that creates a new subgrid that is connected to its parent grid though a physics constraint. Actuations and pistsons that are driven electrically, via hydraulics or by combustion engines directly should enable players to build complex articulated machinery. 

## Hydrodynamic and arodynamic system

I want to have a hydrodynamic and arodynamic system. one thing that will be pretty hard i think, is making it so, that water behaves more like irl.

Often games highly simplify the arodynamics logic and so taught me some things about water that dont align with reality i would like to get closer to reality.

often games complelty neglect the tendency for fluids to stick to surfaces if i can simulate that i would allrady be happy...

I'm thinking of either a particle based system. Or just a more common divergence aproach that happens inside the 20x20x20 raster. maybe there are some ways in which I can cut corners with this too.

## terrain System

as mentioned at the start, terrain shouldn't be made from blocks since blocky hills can't really be driven on with vehicles. Additionally i think, things like resource gathering are going to be a somewhat important game concept as it will provide a lot of the depth and emergent tasks the player will find himself wanting to solve. Especially in harder game modes where the player might not be able to just buy Material where ever he happens to have his base.

I think an other voxel based system, additional to the voxel like system in grids, might put the bar a little to high though. So my though is, to go with Highmaps based terrain which is split up in somewhat small chunks to remain edible during runtime. If dug into they should kind of collapse and always sort of slope like dirt hills do irl. Unfortunately that compromise means no tunnels, cliffs, underground structures or overhangs in the traditional sense and also that I probably won't be able to use one of the many great premade free to use terrain systems for Godot and I'm going to have to make my own. Dispite all those limitations, I can think of an otherway of realizing underground structures by punching holes though the mesh with foundation, that then is composed of blocks like any other grid in the game.

Also the ability for chunks to be made simply edible allows for hydraulic erosion to be a thing again maybe ??? like it was in my first attempt since the look on the terrain it caused was really quiet distinguishable from other more traditional generation methods and it was lots of fun to implement and watch the results of. With chunks that are editable during runtime, background eroding of chunks and replacing them shouldnt be that big of a deal.

in my first game to enable chunkbased erosion, i took the middle of 4 chunks at the same time, and did erosion in the center of them to enable droplets to run past the borders of a "rain chunk". that might be one way of doing it here too just with smaler chunks in general. 

## Other Game Systems

a System Simelar to Wiremod that enables the player to controll Machines though logic circuits and programming

Hydraulics as in pumping liquids that will drive different types of motors, pistions and stuff based on flow and pressur

Mathematically simulated engines

A Simplified Electric Simulation based on PUI and URI would be really nice... but no AC! xD just DC voltage and converters, that change voltage and current simearly to ac transfroms do irl

### wishfull thinking... 

There may be the need for some items to be placed in a 10x10x10 grid to allow more freedom with routing liquids for hydraulics for example. i can imagne these to be just neglected by the volume simulations and areodynamics and stuff. an alternative could be having hydrauluc interface blocks that connect to a fleixble hose that then connects to the piston as its mmore often done irl

i want to enable the player to build traintracks in some way that are actually usable i dunno how thats going to look though...

i kinda wanna make this game support VR and have the Seats be compatible with VR also. I think it would be great if the player could literaly controll his creations with the VR joystics. I can easily think of many interesting controll schemes... normal joystic controlls like in excavators but also positional controll where the positions and rotaions of both controllers are outputted like mech Controlls with arms sort off, as well as boat and plane like controll schemes. The issue is going to be motion sickness 🤣 and not forcing the player to choose between vr and desktop controlles but having both implemented to be usefull in both instances. 




