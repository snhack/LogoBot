/*
	Assembly: WheelAssembly
	Combined motor and wheel assembly
	
	Local Frame: 
		Places the motor default connector at the origin - i.e. use the motor default connector for attaching into a parent assembly

*/


// Connectors
// ----------

Wheel_Con_Default				= [ [0,0,0], [0,0,1], 0, 0, 0];



module WheelAssembly( ) {

    assembly("assemblies/Wheel.scad", "Drive Wheel", str("WheelAssembly()")) {
    
        if (DebugCoordinateFrames) frame();
    
        // debug connectors?
        if (DebugConnectors) {
        
        }
    
        // Vitamins
        logo_motor();
    
        // ribbon Cable :)
        if ($rightSide) {
            ribbonCable(
                cables=5,
                cableRadius = 0.6,
                points= [
                    [2.5, -23, 7],
                    [10, -60, 10],
                    [20, -30,15],
                    [26,0, 13]
                ],
                vectors = [
                    [-1, 0 ,0],
                    [-0.5, 0.5, 1],
                    [-0.5, 0.5, 0],
                    [0, 0,1]
                ],
                colors = [
                    "blue",
                    "orange",
                    "red",
                    "pink",
                    "yellow"
                ],
                debug=false
            );
    
    
        } else {
            ribbonCable(
                cables=5,
                cableRadius = 0.6,
                points= [
                    [-2.5, -23, 7],
                    [10, -60, 10],
                    [20, -30,25],
                    [26,0, 30]
                ],
                vectors = [
                    [1, 0 ,0],
                    [0.5, 0.5, -1],
                    [-0.5, 0.5, -1],
                    [0, 0,-1]
                ],
                colors = [
                    "blue",
                    "orange",
                    "red",
                    "pink",
                    "yellow"
                ],
                debug=false
            );
        }
    
        // STL
        step(1, 
                "Push the wheel onto the motor shaft") {
            view(t=[-0.4, 0.2, 0.7], r=[349,125,180], d=415);
        
            Wheel_STL();
        }
    
		
	}
}


module Wheel_STL() {

	printedPart("assemblies/Wheel.scad", "Wheel", "Wheel_STL()") {
	
	    view(t=[0, -1, -1], r=[49, 0, 25], d=336);
	
	    color(Level2PlasticColor) {

            // Main wheel
            rotate_extrude($fn=100)
            translate ([MotorShaftDiameter / 2, 0, 0])
            difference()
            {
                square([(WheelDiameter - MotorShaftDiameter) / 2, WheelThickness]);

                translate([(WheelDiameter - MotorShaftDiameter) / 2 , WheelThickness / 2])
                    circle(r = WheelThickness / 4);
            }
        
            // Flats in center
            for(i = [0:1])
                mirror([i, 0, 0])		
                    translate([MotorShaftFlatThickness / 2, -MotorShaftDiameter / 2, 0])
                        cube([MotorShaftDiameter / 2, MotorShaftDiameter, WheelThickness]);
        }
	    
	}
}
