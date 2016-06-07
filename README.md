# Digital Puppetry Lab

Repo for the Digital Puppetry Lab class at Bauhaus-Uni Weimar

## OSC-Examples

### Processing ###
All Processing sketches require the [oscP5](http://www.sojamo.de/libraries/oscP5/) library.  
You can install it via the Contribution Manager.  
`Sketch > Import Library > Add Library`

##### Face OSC #####
*Transmitting position and size of faces*
* [Face OSC Sender](osc-examples/processing/face_osc_sender)
* [Face OSC Receiver](osc-examples/processing/face_osc_receiver)

##### Mouse OSC #####
*Transmitting mouse interaction*
* [Mouse OSC Sender](osc-examples/processing/mouse_osc_sender)
* [Mouse OSC Receiver](osc-examples/processing/mouse_osc_receiver)

##### Random OSC #####
*Transmitting random numbers*
* [Random OSC Sender](osc-examples/processing/random_osc_sender)
* [Random OSC Receiver](osc-examples/processing/random_osc_sender)

##### TIC TAC TOE #####
*Bidirectional communication*
* [Player X](osc-examples/processing/tic_tac_toe_player_x)
* [Player O](osc-examples/processing/tic_tac_toe_player_o)

### Pure Data ###
Pure Data patches require the `mrpeach` library (included in pd-extended).  
More info [here](https://flossmanuals.net/pure-data/ch065_osc/).


##### Random OSC #####
*Transmitting random numbers*
* [Random OSC Sender](osc-examples/puredata/random_osc_sender.pd)
* [Random OSC Receiver](osc-examples/puredata/random_osc_receiver.pd)

### MAX MSP ###
MAX patches require the `OSC-route` external.  
More info [here](http://cnmat.berkeley.edu/patch/4029).

## Tracking

### Hacks ###

* [PD-Proxy](tracking/the-captury-hack/random_osc_sender.pd) : puredata patch to make Processing and MAX MSP talk to the captury.

#### Processing ####
* [Twin Spheres Hack](tracking/processing/twin_spheres_hack/) : Processing sketch for tracking the positions of two designated skeletons  
using the pd proxy hack.

### The Captury ###

#### Processing ####
* [Twin Spheres](tracking/processing/twin_spheres/) : Processing sketch for tracking the positions of two designated skeletons  

# License
All code is MIT licensed.
